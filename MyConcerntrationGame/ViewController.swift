//
//  ViewController.swift
//  MyConcerntrationGame
//
//  Created by Stephen Cao on 18/3/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let halloweenTopic = ["👻","🎃","😈","💀","👹","🦇"]
    let badFeelingTopic = ["🤥","😦","😷","🤒","😵","🤑"]
    let catTopic = ["😺","😻","🙀","😾","😹","😽"]
    let gestureTopic = ["👐","👍","🤜","👌","👈","👏"]
    let animalTopic = ["🐳","🦑","🦒","🦌","🦛","🦈"]
    let clothesChoices = ["👢","👘","👗","👠","🧥","👒"]
    var topicChoices = [[String]]()
    
    func initTopicChoices() ->[String]{
        topicChoices.append(halloweenTopic)
        topicChoices.append(catTopic)
        topicChoices.append(gestureTopic)
        topicChoices.append(animalTopic)
        topicChoices.append(clothesChoices)
        topicChoices.append(badFeelingTopic)
        return topicChoices[Int(arc4random_uniform(UInt32(topicChoices.count)))]
    }
    
    lazy var game = Concerntration.init(numberOfPairs: (cardButtons.count + 1) / 2, andChoicesTopic: initTopicChoices())

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipsLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func playNewGame(_ sender: UIButton) {
        resetButtons()
    }
    @IBAction func buttonTouch(_ sender: UIButton) {
        if let buttonNumber = cardButtons.firstIndex(of: sender){
            flipsLabel.text = game.updateFlipsCount()
            if(!game.cards[buttonNumber].isFaceUp){
                detectSelectCorrectPairs()
                let character = game.selectCard(atIndex: buttonNumber)
                sender.setTitle(character, for: UIControl.State.normal)
                sender.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                game.cards[buttonNumber].isFaceUp = true
            }else{
                setCardFaceDown(atIndex: buttonNumber)
            }
        }
    }
    func resetButtons(){
        for index in 0..<cardButtons.count{
            setCardFaceDown(atIndex: index)
            cardButtons[index].isEnabled = true
        }
        scoreLabel.text = game.resetScoreCount()
        flipsLabel.text = game.resetFlipsCount()
        game = Concerntration.init(numberOfPairs: (cardButtons.count + 1) / 2, andChoicesTopic: initTopicChoices())
    }
    func setCardFaceDown(atIndex index: Int){
        showCardDown(atIndex: index)
        cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    }
    func dismissCards(atIndex index: Int){
        showCardDown(atIndex: index)
        cardButtons[index].isEnabled = false
    }
    func showCardDown(atIndex index:Int){
        game.cards[index].isFaceUp = false
        cardButtons[index].setTitle("", for: UIControl.State.normal)
    }
    func detectSelectCorrectPairs(){
        let result = game.didSelectCorrectPairs()
        let faceUpCards = game.getFaceUpCards()
        if result == 2{
            for index in faceUpCards{
                dismissCards(atIndex: index)
            }
        }else if result == -1{
            for index in faceUpCards{
                 setCardFaceDown(atIndex: index)
            }
        }
        scoreLabel.text = game.updateScoreCount(withScore: result)
    }
    
    func addNewTheme(withEmojiSet set :[String]){
        topicChoices.append(set)
    }
}

