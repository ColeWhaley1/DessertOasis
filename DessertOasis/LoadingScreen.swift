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
    
    var body: some View {
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
                    self.size = 1.0
                    self.opacity = 1.0
                }
            }
        }
    }
}

#Preview {
    LoadingScreen()
}
