//
//  Item.swift
//  DessertOasis
//
//  Created by Cole Whaley on 8/6/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
