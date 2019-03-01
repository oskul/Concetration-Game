//
//  Card.swift
//  Concentration
//
//  Created by Olga SKULSKA on 2/27/19.
//  Copyright © 2019 Olga SKULSKA. All rights reserved.
//

import Foundation

struct  Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
