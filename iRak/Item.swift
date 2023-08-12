//
//  Item.swift
//  iRak
//
//  Created by Ronald Lens on 12/08/2023.
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
