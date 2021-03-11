//
//  main.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-08.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

//*****  WELCOME

var input: String?
var player = welcome()
// print(player.currentQuestion, player.totalWin,  player.hint1, player.hint2, player.round)

//*****  GAME   ******

repeat {
    print("\nYou're in ROUND: \(player.round) QUESTION: \(player.currentQuestion) REMAIN QUESTIONS: \(9-player.currentQuestion) EARNED $:\(player.totalWin)")
    // Select a Question
    let selected = selectQuestion(round: player.round, questionNumber: player.currentQuestion)
    
    // Choose Option
    let option = chooseOption()
    
    // Confirm Option
    let confirm = confirmOption(option: option)
    
    // Win or loose
    resultWin = looseOrWin(option:confirm, selected: selected)
    
    // @TODOd
    //  Verify at the end round 1 and 2 defineContinue()
    if resultWin {
        player.totalWin = amountWinning[player.currentQuestion - 1]
        // print("\nYou're in ROUND: \(player.round) QUESTION: \(player.currentQuestion) REMAIN QUESTIONS: \(9-player.currentQuestion) EARNED $:\(player.totalWin)")
        if player.currentQuestion == 3 ||  player.currentQuestion == 6 {
            defContinue = defineContinue()
        } else if player.round == 3 && player.currentQuestion < 9{
            defContinue = defineContinue()
        }
        player.currentQuestion += 1
    }
    // @TODO questionNumber final is 9
} while resultWin && defContinue && player.currentQuestion <= 9

if resultWin {
    if player.currentQuestion > 9 {
        print("\n\nCONGRATULATIONS!!! You're a millionaire. You earned $ \(player.totalWin)")
    } else {
        print("\n\nYou earned $ \(player.totalWin)")
    }
}
