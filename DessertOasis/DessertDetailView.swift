//
//  DessertDetailView.swift
//  DessertOasis
//
//  Created by Cole Whaley on 8/8/24.
//

import SwiftUI

let exampleDessert = Dessert(
    mealName: "Apam balik",
    thumbnail: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
    mealId: "53049"
)

// This would be stored more securely if key was not trivial
private let apiKey: String = "1";

struct DessertDetailView: View {
    @State var dessert: Dessert
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview{
    DessertDetailView(dessert: exampleDessert)
}


