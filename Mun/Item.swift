//
//  Item.swift
//  Mun
//
//  Created by Tomás García Gobet on 15.09.23.
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
