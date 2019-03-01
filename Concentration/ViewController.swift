//
//  ViewController.swift
//  Concentration
//
//  Created by Olga SKULSKA on 2/27/19.
//  Copyright © 2019 Olga SKULSKA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concatration(numberOfPairsOfCard: (cardButtons.count + 1) / 2)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {

        if let cardNumber = cardButtons.index(of: sender){
            game.choseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card not in curdButtons")
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.resetCard()
        updateViewFromModel()
        emoji.removeAll()
        emojiChoices = currEmoji

    }
    
    func updateViewFromModel(){
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreCountLabel.text = "Score: \(game.scoreCount)"
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? .clear : .orange
            }
        }
    }
    
    // Set theme
    var themeSet : [String: [String]] = [
        "halloween" : ["👻", "🎃", "🍭", "😈", "🤡", "🍫", "🧟‍♂️", "💀"],
        "animals" : ["🐕", "🐈", "🐴", "🐭", "🐘", "🐷", "🐮", "🦁"],
        "faces":  ["😀", "🤪", "😬", "😭", "😎", "😍", "🤠", "😇", "🤩", "🤢"],
        "fruits": ["🍏", "🥑", "🍇", "🍒", "🍑", "🥝", "🍐", "🍎", "🍉", "🍌"],
        "transport": ["🚗", "🚓", "🚚", "🏍", "✈️", "🚜", "🚎", "🚲", "🚂", "🛴"],
        "sports": ["🏊🏽‍♀️", "🤽🏻‍♀️", "🤾🏾‍♂️", "⛹🏼‍♂️", "🏄🏻‍♀️", "🚴🏻‍♀️", "🚣🏿‍♀️", "⛷", "🏋🏿‍♀️", "🤸🏼‍♂️"]
    ]
    
    var currEmoji: [String] {
        let key = Array(themeSet.keys)[Int(arc4random_uniform(UInt32(themeSet.count - 1)))]
        let currTheme = themeSet[key]!
        return currTheme
    }
    
    var emoji =  [Int:String]()
    lazy var emojiChoices = currEmoji
    
    func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

