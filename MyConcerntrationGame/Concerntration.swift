//
//  Concerntration.swift
//  MyConcerntrationGame
//
//  Created by Stephen Cao on 19/3/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class Concerntration {
    var flipsCount = 0
    var scoreCount = 2
    var cards = [Card]()
    var buttonChoices = [String]()
    var choicesMap = [Int : String]()
    init(numberOfPairs number : Int, andChoicesTopic topicChoices:[String]) {
        for _ in 0..<number{
            let card = Card.init()
            cards += [card, card]
        }
        buttonChoices = topicChoices
        setupChoices()
        cards.shuffle()
    }
    func selectCard(atIndex index: Int) -> String{
        return cards[index].character ?? "?"
    }
    
    func setupChoices(){
        var index = 0
        while index < cards.count{
            if(buttonChoices.count > 0){
                let character = buttonChoices.remove(at: Int(arc4random_uniform(UInt32(buttonChoices.count))))
                cards[index].character = character
                cards[index + 1].character = character
            }
            index += 2
        }
    }
    
    func didSelectCorrectPairs() ->Int{
        var faceUpCards = getFaceUpCards()
        if(faceUpCards.count <= 1){
            return 0
        }
        if(faceUpCards.count == 2){
            if let char1 = cards[faceUpCards[0]].character, let char2 = cards[faceUpCards[1]].character, char1.elementsEqual(char2){
                return 2
            }else{
                return -1
            }
        }
        return 0
    }
    
    func getFaceUpCards() ->[Int] {
        var faceUpCards = [Int]()
        for index in 0..<cards.count{
            if(cards[index].isFaceUp){
                faceUpCards.append(index)
            }
        }
        return faceUpCards
    }
    func updateFlipsCount() ->String{
        flipsCount += 1
        return "flips: \(flipsCount)"
    }
    func resetFlipsCount() ->String{
        flipsCount = 0
        return "flips: \(flipsCount)"
    }
    func updateScoreCount(withScore score: Int) -> String {
        scoreCount += score
        return "Score: \(scoreCount)"
    }
    func resetScoreCount() ->String{
        scoreCount = 2
        return "Score: \(scoreCount)"
    }
}
