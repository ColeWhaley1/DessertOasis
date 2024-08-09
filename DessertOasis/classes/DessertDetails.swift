//
//  DessertDetails.swift
//  DessertOasis
//
//  Created by Cole Whaley on 8/9/24.
//

import Foundation

class DessertDetails: Decodable {
    let mealId: String
    let mealName: String
    let drinkAlternate: String?
    let category: String?
    let area: String?
    let instructions: String?
    let mealThumb: String
    let tags: String?
    let youtube: String?
    let ingredients: [String?] // json has it as 20 variables and not an arr, so i have to dynamically put all ingredients in arr. very frustrating
    let measures: [String?] // same as above
    let source: String?
    let imageSource: String?
    let creativeCommonsConfirmed: String?
    let dateModified: String?
    
    private enum CodingKeys: String, CodingKey {
        case mealId = "idMeal"
        case mealName = "strMeal"
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case mealThumb = "strMealThumb"
        case tags = "strTags"
        case youtube = "strYoutube"
        case source = "strSource"
        case imageSource = "strImageSource"
        case creativeCommonsConfirmed = "strCreativeCommonsConfirmed"
        case dateModified = "dateModified"
        case ingredients = "ingredients"
        case measures = "measures"
    }
    
    // have to custom init because the json format is different from the format we want.
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        mealId = try container.decode(String.self, forKey: .mealId)
        mealName = try container.decode(String.self, forKey: .mealName)
        drinkAlternate = try container.decodeIfPresent(String.self, forKey: .drinkAlternate)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        area = try container.decodeIfPresent(String.self, forKey: .area)
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        mealThumb = try container.decode(String.self, forKey: .mealThumb)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        youtube = try container.decodeIfPresent(String.self, forKey: .youtube)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        imageSource = try container.decodeIfPresent(String.self, forKey: .imageSource)
        creativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .creativeCommonsConfirmed)
        dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)
        
        var ingredientsDecoded: [String?] = []
        var measuresDecoded: [String?] = []
        
        // convert the json vars into 2 arrs of ingredients and measures. More concise and clean
        for i in 1...20{
            let strIngredient = "strIngredient\(i)"
            let strMeasure = "strMeasure\(i)"
            
            if let ingredientKey = CodingKeys(stringValue: strIngredient),
               let ingredient = try? container.decodeIfPresent(String.self, forKey: ingredientKey) {
                ingredientsDecoded.append(ingredient)
            } else {
                continue
            }
                        
            if let measureKey = CodingKeys(stringValue: strMeasure),
               let measure = try? container.decodeIfPresent(String.self, forKey: measureKey) {
                measuresDecoded.append(measure)
            } else {
                continue
            }

        }
        
        // init last 2 fields as arrays
        ingredients = ingredientsDecoded
        measures = measuresDecoded
    }
}
