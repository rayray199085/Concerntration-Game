//
//  Card.swift
//  MyConcerntrationGame
//
//  Created by Stephen Cao on 19/3/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var character :String?
    var identifier = 0
    static var uniqueIdentifier = -1
    static func getUniqueIdentifier() -> Int{
        uniqueIdentifier += 1
        return uniqueIdentifier;
    }
    init() {
        isFaceUp = false
        identifier = Card.getUniqueIdentifier()
    }
}
