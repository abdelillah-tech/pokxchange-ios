//
//  Rarity.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/2/21.
//

import Foundation
import SwiftUI

public func rarityColor(rarity: String) -> Color {
    let rarityColor: Color
    switch rarity {
        case "legendary":
            rarityColor = Color.orange
        case "rare":
            rarityColor = Color.yellow
        case "uncommon":
            rarityColor = Color.green
        default:
            rarityColor = Color.blue
    }
    return rarityColor
}

