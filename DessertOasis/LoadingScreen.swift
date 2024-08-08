//
//  LoadingScreen.swift
//  DessertOasis
//
//  Created by Cole Whaley on 8/7/24.
//

import SwiftUI

struct LoadingScreen: View {
    @Binding var isActive: Bool
    @State private var size = 0.7
    @State private var opacity = 0.5
    @State private var errorMsg = ""
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack{
                VStack{
                    Image("Dessert Oasis Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.5)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                Task {
                    await loadDesserts()
                }
            }
        }
    }
    
    private func loadDesserts() async {
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
        } catch {
            errorMsg = "failed to sleep"
        }
        isActive = true
    }
}

#Preview {
    @State var isSplashActive: Bool = true
    LoadingScreen(isActive: $isSplashActive)
}
