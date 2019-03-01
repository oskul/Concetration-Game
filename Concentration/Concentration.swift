//
//  Concentration.swift
//  Concentration
//
//  Created by Olga SKULSKA on 2/27/19.
//  Copyright © 2019 Olga SKULSKA. All rights reserved.
//

import Foundation

class Concatration
{
    var cards = [Card]()
    var previouslyOpenedCard = [Int]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var flipCount = 0
    
    var scoreCount = 0
    
    func choseCard(at index : Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if previouslyOpenedCard.contains(index){
                scoreCount -= 1
            }
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    scoreCount += 2
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }

                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                // check if cards match
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
           previouslyOpenedCard.append(index)
        }
    }
    
    func resetCard(){
        flipCount = 0
        scoreCount = 0
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    func shuffle(_ cardArray: [Card]) -> [Card]{
        var notShuffle = cardArray
        var cards = [Card]()
        for _ in notShuffle.indices{
            let randomIndex = Int(arc4random_uniform(UInt32(notShuffle.count - 1)))
            cards.append(notShuffle[randomIndex])
            notShuffle.remove(at: randomIndex)
        }
        return cards
    }
    
    init(numberOfPairsOfCard: Int) {
        for _ in 0..<numberOfPairsOfCard {
            let card = Card()
            cards += [card, card]
        }
        cards =  shuffle(cards)
        //TODO: Shuffle the cards
    }
    
}
