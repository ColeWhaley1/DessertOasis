//
//  dessert.swift
//  DessertOasis
//
//  Created by Cole Whaley on 8/7/24.
//

import Foundation

let apiKey = "1"

struct DessertResponse: Decodable {
    let results: [Dessert]
    
    private enum CodingKeys: String, CodingKey {
        case results = "meals"
    }
}

func getDesserts() async throws -> [Dessert] {
    let url = URL(string: "https://themealdb.com/api/json/v1/\(apiKey)/filter.php?c=Dessert")!
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let decoded = try JSONDecoder().decode(DessertResponse.self, from: data)
    
    return decoded.results
}
