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
    let ingredients: [String?]
    let measures: [String?]
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
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
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

        for i in 1...20 {
            // decode measures and append to its own array
            if let measureKey = CodingKeys(stringValue: "strMeasure\(i)") {
                let measure = try container.decodeIfPresent(String.self, forKey: measureKey)
                if measure == "" || measure == nil {
                    continue
                }
                measuresDecoded.append(measure)
            }
            
            // decode ingredients and append to its own array
            if let ingredientKey = CodingKeys(stringValue: "strIngredient\(i)") {
                let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey)
                if ingredient == "" || ingredient == nil {
                    continue
                }
                ingredientsDecoded.append(ingredient)
            }
        }

        measures = measuresDecoded
        ingredients = ingredientsDecoded
    }

}
