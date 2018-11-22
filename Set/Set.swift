//
//  Set.swift
//  Set
//
//  Created by Ivaylo Kisyov on 11.11.18.
//  Copyright © 2018 Ivaylo Kisyov. All rights reserved.
//

import Foundation
class Set {
    var availableCards = [Card]()
    var cardsInGame = [Card]()
    var selectedCards = [Card]()
    
    var score = 0
    
    init() {
        newGame()
    }
    
    func newGame() {
        score = 0
        availableCards.removeAll()
        cardsInGame.removeAll()
        selectedCards.removeAll()
        
        generateAllCardCombinations()
        addCards(numberOfCardsToSelect: 12)
    }
    
    private func generateAllCardCombinations() {
        for color in CardColor.allValues {
            for symbol in CardSymbol.allValues {
                for number in CardNumber.allValues {
                    for shading in CardShading.allValues {
                        let card = Card(cardColor: color, cardSymbol: symbol, cardNumber: number, cardShading: shading)
                        availableCards.append(card)
                    }
                }
            }
        }
    }
    
    private func addCard() {
        let selectedCard = self.availableCards.remove(at: availableCards.count.arc4Random())
        cardsInGame.append(selectedCard)
    }
    
    func addCards(numberOfCardsToSelect numberOfCards: Int) {
        for _ in 0..<numberOfCards {
            addCard()
        }
    }
    
    func cardsIsSelected(card: Card) -> Bool {
        return selectedCards.index(of: card) != nil
    }
    
    func isSet() -> Bool {
        //If two are... and one is not, then it is not a 'Set'.
        if selectedCards.count != 3 {
            return false
        }
        
        if selectedCards[0].cardColor == selectedCards[1].cardColor {
            if selectedCards[0].cardColor != selectedCards[2].cardColor {
                return false
            }
        } else if selectedCards[1].cardColor == selectedCards[2].cardColor {
            return false
        } else if (selectedCards[0].cardColor == selectedCards[2].cardColor) {
            return false
        }
        
        if selectedCards[0].cardNumber == selectedCards[1].cardNumber {
            if selectedCards[0].cardNumber != selectedCards[2].cardNumber {
                return false
            }
        } else if selectedCards[1].cardNumber == selectedCards[2].cardNumber {
            return false
        } else if (selectedCards[0].cardNumber == selectedCards[2].cardNumber) {
            return false
        }
        
        if selectedCards[0].cardShading == selectedCards[1].cardShading {
            if selectedCards[0].cardShading != selectedCards[2].cardShading {
                return false
            }
        } else if selectedCards[1].cardShading == selectedCards[2].cardShading {
            return false
        } else if (selectedCards[0].cardShading == selectedCards[2].cardShading) {
            return false
        }
        
        if selectedCards[0].cardSymbol == selectedCards[1].cardSymbol {
            if selectedCards[0].cardSymbol != selectedCards[2].cardSymbol {
                return false
            }
        } else if selectedCards[1].cardSymbol == selectedCards[2].cardSymbol {
            return false
        } else if (selectedCards[0].cardSymbol == selectedCards[2].cardSymbol) {
            return false
        }
        
        return true
    }
    
    func select(card: Card) {
        if selectedCards.count == 3 && isSet() {
            selectedCards.forEach {
                if let selectedCardInGameIndex = cardsInGame.index(of: $0) {
                    cardsInGame.remove(at: selectedCardInGameIndex)
                    if availableCards.count > 0 {
                        let selectedCard = availableCards.remove(at: availableCards.count.arc4Random())
                        cardsInGame.insert(selectedCard, at: selectedCardInGameIndex)
                    }
                }
            }
            selectedCards.removeAll()
            score += 3
        } else if selectedCards.count == 3 && !isSet() {
            selectedCards.removeAll()
            score -= 5
        }
        
        if let cardToSelect = selectedCards.index(of: card) {
            // Card is already selected, so remove it from the selection
            selectedCards.remove(at: cardToSelect)
            score -= 1
        } else {
            selectedCards.append(card)
        }
        
        print("Selected \(selectedCards.count) cards")
        print("Cards available in deck \(availableCards.count) cards")
        print("Cards in game \(cardsInGame.count) cards")
        
    }
}

extension Int {
    func arc4Random() -> Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
