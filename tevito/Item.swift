//
//  Item.swift
//  tevito
//
//  Created by Javier Godoy Núñez on 1/29/24.
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
