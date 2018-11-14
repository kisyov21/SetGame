//
//  ButtonRender.swift
//  Set
//
//  Created by Ivaylo Kisyov on 11.11.18.
//  Copyright © 2018 Ivaylo Kisyov. All rights reserved.
//

import Foundation
import UIKit

class ButtonRender {
    
    private static func getSymbol(ofCard card: Card) -> String {
        switch card.cardSymbol {
        case .triangle:
            return "▲"
        case .circle:
            return "●"
        case .square:
            return "◼︎"
        }
    }
    
    private static func getColor(ofCard card: Card) -> UIColor {
        switch card.cardColor {
        case .black:
            return UIColor.black
        case .blue:
            return UIColor.blue
        case .red:
            return UIColor.red
        }
    }
    
    private static func getButtonTitle(ofCard card: Card, usingSymbol symbol: String) -> String {
        switch card.cardNumber {
        case .one:
            return "\(symbol)"
        case .two:
            return "\(symbol) \(symbol)"
        case .three:
            return "\(symbol) \(symbol) \(symbol)"
        }
    }
    
    private static func getButtonAttributedTitle(ofCard card: Card, withTitle title: String, withColor color: UIColor) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        switch card.cardShading {
        case .open:
            attributes[.strokeWidth] = 4
            attributes[.foregroundColor] = color
        case .solid:
            attributes[.strokeWidth] = -1
            attributes[.foregroundColor] = color
        case .striped:
            attributes[.strokeWidth] = -1
            attributes[.foregroundColor] = color.withAlphaComponent(0.25)
        }
        
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    public static func renderCard(cardToRender card: Card, onButton: UIButton, selectButton: Bool, isSet: Bool) {
        let buttonColor = getColor(ofCard: card)
        let cardSymbol = getSymbol(ofCard: card)
        let buttonTitle = getButtonTitle(ofCard: card, usingSymbol: cardSymbol)
        let attributedTitle = getButtonAttributedTitle(ofCard: card, withTitle: buttonTitle, withColor: buttonColor)
        
        onButton.setAttributedTitle(attributedTitle, for: UIControl.State.normal)
        
        if selectButton {
            if isSet {
                onButton.select(borderColor: #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1))
            } else {
                onButton.select()
            }
        } else {
            onButton.deselect()
        }
    }
}
