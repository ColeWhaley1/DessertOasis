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
    @State var image: UIImage
    
    var body: some View {
        VStack{
            HStack{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 20)
                    .alignmentGuide(.top) { _ in 0 }
                    .alignmentGuide(.leading) { _ in 0 }
                    .padding(.leading, 20)
                    .overlay(
                        Circle().stroke(Color.black, lineWidth: 3)
                            .padding(.leading, 20)
                    )
                
                Text("\(dessert.mealName)")
                    .font(Font.headline.bold())
                    .padding(.leading, 20)
                
                Spacer()
            }
            
            if(dessertDetails?.ingredients.isEmpty ?? true){
                ProgressView()
            } else {
                // list ingredients and measures
                List{
                    Text("Ingredients")
                        .font(Font.subheadline.bold())
                        .frame(maxWidth: .infinity, alignment: .center)
                    ForEach(0..<(dessertDetails?.ingredients.count ?? 0), id: \.self) { i in
                        if let ingredient = dessertDetails?.ingredients[i], let measure = dessertDetails?.measures[i] {
                            HStack{
                                Text("\(measure)")
                                    .padding(10)
                                    .background(Color.purple.opacity(0.9))
                                    .foregroundColor(.white)
                                    .cornerRadius(50)
                                    .fontWeight(.bold)
                                Text("\(ingredient)")
                                    .font(.system(size: 24))
                                    
                            }
                            .padding(.bottom, 10)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            }
            
            let instructionsLoading = dessertDetails?.instructions?.isEmpty ?? true
            
            if !instructionsLoading {
                // instructions
                List{
                    Text("Instructions")
                        .font(Font.subheadline.bold())
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text(dessertDetails?.instructions ?? "Instructions Unavailable")
                }
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            }

        }
        .task{
            await fetchDessertDetails()
        }
        
    }
    
    func fetchDessertDetails() async {
        do{
            let details = try await getDessertDetails(mealId: dessert.mealId)
            dessertDetails = details
        } catch {
            errorMsg = "Failed to fetch details for: \(dessert.mealName)"
        }
    }
    
}

#Preview {
    DessertDetailView(dessert: exampleDessert, image: UIImage(named: "image-not-found")!)
}



