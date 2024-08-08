//
//  LoadingScreen.swift
//  DessertOasis
//
//  Created by Cole Whaley on 8/7/24.
//

import SwiftUI

struct LoadingScreen: View {
    @State private var size = 0.7
    @State private var opacity = 0.5
    @State private var errorMsg = ""
    @State private var isActive: Bool = false
    
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    LoadingScreen()
}
