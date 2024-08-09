//
//  dessertDetails.swift
//  DessertOasis
//
//  Created by Cole Whaley on 8/9/24.
//

import Foundation

// This would be stored more securely if key was not trivial
private let apiKey: String = "1";

struct DessertDetailsResponse: Decodable {
    let results: [DessertDetails]
    
    private enum CodingKeys: String, CodingKey {
        case results = "meals"
    }
}

func getDessertDetails(mealId: String) async throws -> DessertDetails {
    let url = URL(string: "https://www.themealdb.com/api/json/v1/\(apiKey)/lookup.php?i=\(mealId)")!
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let dessertDetailsResponse: DessertDetailsResponse = try JSONDecoder().decode(DessertDetailsResponse.self, from: data)
    let dessertDetails = dessertDetailsResponse.results[0]
    return dessertDetails
}
