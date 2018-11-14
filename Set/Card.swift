//
//  Card.swift
//  Set
//
//  Created by Ivaylo Kisyov on 11.11.18.
//  Copyright © 2018 Ivaylo Kisyov. All rights reserved.
//

import Foundation

struct Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.cardColor == rhs.cardColor &&
            lhs.cardNumber == rhs.cardNumber &&
            lhs.cardShading == rhs.cardShading &&
            lhs.cardSymbol == rhs.cardSymbol
    }
    
    let cardColor: CardColor
    let cardSymbol: CardSymbol
    let cardNumber: CardNumber
    let cardShading: CardShading
}

enum CardColor {
    case black
    case red
    case blue
    
    static let allValues = [black, red, blue]
}

enum CardShading {
    case striped
    case solid
    case open
    
    static let allValues = [striped, solid, open]
}

enum CardSymbol {
    case triangle
    case square
    case circle
    
    static let allValues = [triangle, square, circle]
}

enum CardNumber {
    case one
    case two
    case three
    
    static let allValues = [one, two, three]
}

