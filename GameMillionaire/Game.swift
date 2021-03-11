//
//  Game.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-11.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

//  WELCOME TO PLAY

func welcome() -> Player {
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
        //invalidName.toggle()
        invalidName = false
        result = unwrapped.uppercased()
    }
    
    let player = Player(name: result)
    print("Hello, \(result)")
    return player
}

//  *********** NEEDED UPDATE
// func randomQuestion(round:Int) -> Question {
//    //@TODO Use round to random questions
//    //  Select 9 questions, three for each round
//   let indexQuestion = Int.random(in: 0..<questions.count-1)

//   return (questions[indexQuestion])
// }
func randomQuestion(round:Int) -> Question {
    //@TODO Use round to random questions
    //  Select 9 questions, three for each round
    //let indexQuestion = Int.random(in: 0..<questions.count-1)
    //return (questions[indexQuestion])
    let indexQuestion = arc4random_uniform(15)
    let i: Int = Int(indexQuestion)
    return (questions[i])
}

func selectQuestion(round: Int, questionNumber: Int) -> Question {
    let questionSelected = randomQuestion(round: round)
    print("\nQuestion \(questionNumber) - \(questionSelected.question)")
    print("(a) \(questionSelected.options[0])")
    print("(b) \(questionSelected.options[1])")
    print("(c) \(questionSelected.options[2])")
    print("(d) \(questionSelected.options[3])")
    
    return questionSelected
}

func chooseOption() -> String {
    var invalidOption: Bool = true
    var option: String = ""
    //@TODO hint1 and hint2 -
    while (invalidOption) {
        print("\nWhat is your option (a,b,c or d) ?")
        input = readLine()
        guard let op = input else {
            print ("You didn't provide option.")
            continue
        }
        if op == "a" || op == "b" || op == "c" || op == "d" {
            //invalidOption.toggle()
            invalidOption = false
        } else {
            print("Invalid Option, try again")
        }
        option = op
    }
    return option
}

func confirmOption(option: String) -> String {
    var result = option
    var invalidOption: Bool = true
    
    while (invalidOption) {
        print("Confirm your option (y-Yes n-No), you choose '\(option)'")
        input = readLine()
        guard let conf = input else {
            print ("You didn't provide answer (y-Yes n-No).")
            continue
        }
        //invalidOption.toggle()
        invalidOption = false
        if conf.uppercased() == "Y" {
            invalidOption = false
        } else if conf.uppercased() == "N" {
            invalidOption = false
            print("You'll change your option")
            result = chooseOption()
        } else {
            invalidOption = true
            print("Invalid, try again")
        }
    }
    print("Option confirmed '\(result)'")
    return result
}

func looseOrWin(option: String, selected: Question) -> Bool {
    let ind: Int
    switch option {
    case "a":
        ind = 0
    case "b":
        ind = 1
    case "c":
        ind = 2
    case "d":
        ind = 3
    default:
        ind = 0
    }
    if (ind == selected.correctAnswer) {
        print("\nYour answer is correct.")
        return true
    } else {
        print("Correct Answer is: \(selected.options[selected.correctAnswer])")
        print("You lost. You'll win $ \(player.totalWin)")
        return false
    }
}

func defineContinue() -> Bool {
    var invalidOption: Bool = true
    var cont: Bool = true
    while (invalidOption) {
        print("\nDo you want to continue in the Game   (Y-Yes or N-No) ?")
        input = readLine()
        guard let conf = input else {
            print ("You didn't define Continue or Stop the Game.")
            continue
        }
        //invalidOption.toggle()
        invalidOption = false
        if conf.uppercased() == "Y" {
            cont = true
        } else if conf.uppercased() == "N" {
            cont = false
        } else {
            invalidOption = true
            print("Invalid, try again")
        }
        return cont
    }
}

// @TODO - only in round 1 or 2
func hint1() {
    
    print("HINT 1 - 50% Options")
    //  return 2 option, 1 is correct  (random the second)
}

// @TODO - only in round 1 or 2
func hint2() {
    print("HINT 2 - Ask Audience")
    // return pool answer???
}

var resultWin = false
var defContinue = true
let amount1 = [Int](repeating: 0,count: 3)
let amount2 = [Int](repeating: 10000,count: 2)
let amount3 = [Int](repeating: 100000,count: 3)
let amount4 = [Int](repeating: 1000000,count: 1)
let amountWinning = amount1 + amount2 + amount3 + amount4
//print(amountWinning)

