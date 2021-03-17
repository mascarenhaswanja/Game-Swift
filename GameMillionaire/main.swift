//
//  main.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-08.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

//@TODO Implement inheritence ? Hints
// Protocol and Extension-OK

import Foundation

var player = Player()
player.welcomeGame()

let game = Game(player: player)
game.playGame()

/*  This project is unisng XCode 9.4 (some funcionalities are not available)
 
 GAME DESIGN
 Game has-a:
    Player
    Hint
    BankOfQuestions
 
 BankOfQuestions has-a:
    Question
 
 Class:
    Game
    Player
    Hint
 
 Structs:
    Question
    BankofQuestion
 
 Inheritance:
    Hint - superclass
        Hint1 - subclass
        Hint2 - subclass
 
 Protocol:
    Printable - print special situations with Hint
 
 Extensions:
    Int -  random from arc4random
    Bool - toggle self = !self
 
 Enum:
    AnswerChoices: a,b,c,d
    WinningMoney per question and round
 */
 
