//
//  main.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-08.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

//@TODO Implement inheritence ?
// Protocol and Extension

import Foundation

func welcomeGame() -> Player {
    print("*****************************************")
    print("****          WELCOME TO PLAY        ****")
    print("****   WHO WANTS TO BE A MILIONAIRE  ****")
    print("****       You have 3 Rounds         ****")
    print("****   Each round has 3 questions    ****")
    print("**** Round 3 allows stop in question ****")
    print("*****************************************")
    
    var input: String?
    var invalidName: Bool = true
    var result: String = "No Name"
    while (invalidName) {
        print("What's your name?")
        input = readLine()
        guard let unwrapped = input else {
            print("You didn't provide a name.")
            continue
        }
        invalidName.toggle()
        //invalidName = false
        result = unwrapped.uppercased()
    }
    let player = Player(name: result)
    print("Hello, \(result)")
    return player
}

var player = welcomeGame()

let questions = BankOfQuestions()

var game = Game(player: player, questions: questions)
game.playGame()
