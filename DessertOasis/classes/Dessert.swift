//
//  Item.swift
//  DessertOasis
//
//  Created by Cole Whaley on 8/6/24.
//

import Foundation
import SwiftData

struct Dessert: Decodable {
    let mealName: String
    let thumbnail: String
    let mealId: String
    
    private enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case thumbnail = "strMealThumb"
        case mealId = "idMeal"
    }
}
