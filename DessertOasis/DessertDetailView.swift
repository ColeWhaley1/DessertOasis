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

struct DessertDetailView: View {
    @State var dessert: Dessert
    @State var dessertDetails: DessertDetails?
    @State var errorMsg: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Text("meal: \(dessertDetails?.mealName ?? "")")
            }
        }
        .task{
            await fetchDessertDetails()
        }
        
    }
    
    func fetchDessertDetails() async {
        do{
            var details = try await getDessertDetails(mealId: dessert.mealId)
            dessertDetails = details
        } catch {
            errorMsg = "Failed to fetch details for: \(dessert.mealName)"
        }
    }
    
}

#Preview{
    DessertDetailView(dessert: exampleDessert)
}


