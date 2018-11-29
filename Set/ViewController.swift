//
//  ViewController.swift
//  Set
//
//  Created by Ivaylo Kisyov on 11.11.18.
//  Copyright © 2018 Ivaylo Kisyov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var setCardButtons: [UIButton]!
    
    @IBOutlet weak var dealThreeMoreCardButton: UIButton!
    
    let setGame = Set()
    override func viewDidLoad() {
        super.viewDidLoad()
        resetButtons()
        updateViewFromModel()
    }
    
    func resetButtons() {
        for buttonsIndex in setCardButtons.indices {
            let button = setCardButtons[buttonsIndex]
            button.deselect()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25.0)
            button.layer.cornerRadius = 10
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            button.setAttributedTitle(nil, for: UIControl.State.normal)
        }
    }
    
    
    @IBAction func selectCard(_ sender: UIButton) {
        if let cardIndex = setCardButtons.index(of: sender) {
            if cardIndex < setGame.cardsInGame.count {
                setGame.select(card: setGame.cardsInGame[cardIndex])
            }
            updateViewFromModel()
        }
    }
    
    @IBAction func newGame() {
        dealThreeMoreCardButton.isEnabled = true
        setGame.newGame()
        resetButtons()
        updateViewFromModel()
    }
    
    @IBAction func addThreeNewCards() {
        if setGame.findSet() == nil && setGame.availableCards.count >= 3 {
            setGame.addCards(numberOfCardsToSelect: 3)
            updateViewFromModel()
            if setGame.cardsInGame.count >= 24 {
                dealThreeMoreCardButton.isEnabled = false
            }
        } else {
            dealThreeMoreCardButton.isEnabled = false
        }
    }
    
    @IBAction func cheatTheGame() {
        if let sets = setGame.findSet(){
            setGame.selectedCards.removeAll()
            for set in sets {
                setGame.select(card: set)
            }
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        var cardButtonIndex = 0
        resetButtons()
        scoreLabel.text = "Score: \(setGame.score)"
        for card in setGame.cardsInGame {
            let button = setCardButtons[cardButtonIndex]
            ButtonRender.renderCard(cardToRender: card, onButton: button, selectButton: setGame.cardsIsSelected(card: card), isSet: setGame.isSet())
            cardButtonIndex += 1
            dealThreeMoreCardButton.isEnabled = true
        }
    }
    
}

