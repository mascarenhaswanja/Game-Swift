//
//  Game.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-11.
//  Copyright © 2021 Wanja. All rights reserved.
//
import Foundation

class Game {
    var player: Player
    let questions: BankOfQuestions
    
    init(player: Player, questions: BankOfQuestions) {
        self.player = player
        self.questions = questions
    }
    
    func playGame() {
        //  Select Random Questions for Game
        let selectedQuestions = questions.gameQuestions()
        var resultWin = false
        var defContinue = true
        
        repeat {
            print("\nYou're in ROUND: \(player.round) QUESTION: \(player.currentQuestion) REMAIN QUESTIONS: \(9-player.currentQuestion)")
            print("TOTAL EARNED UNTIL NOW $:\(player.totalWin)")
            
            // Select and Show Question
            let questionSelected = selectedQuestions[player.currentQuestion-1]
            showQuestion(number: player.currentQuestion, selected: questionSelected)
            
            // Choose Option
            let option = chooseOption()
            
            // Confirm Option
            let confirm = confirmOption(option: option)
            
            // Win or loose
            resultWin = looseOrWin(option:confirm, selected: questionSelected)
            
            if resultWin {
                //player.totalWin = amountWinning[player.currentQuestion - 1]
                //  NEDEED UPDATE
                switch player.round {
                    case 1:  player.totalWin = Winning.round1.rawValue
                    case 2:  player.totalWin = Winning.round2.rawValue
                    case 3:  player.totalWin = Winning.round3.rawValue
                    default: player.totalWin = 0
                }
                
                if (player.currentQuestion == 3 || player.currentQuestion == 6) || (player.round == 3 && player.currentQuestion < 9) {
                    defContinue = defineContinue()
                }
                player.currentQuestion += 1
            }
        } while resultWin && defContinue && player.currentQuestion <= 9
        
        if resultWin {
            if player.currentQuestion > 9 {
                player.totalWin = Winning.winner.rawValue
                print("\n\nCONGRATULATIONS!!! You're a millionaire. You earned $ \(player.totalWin)")
            } else {
                print("\n\nYou earned $ \(player.totalWin)")
            }
        }
        
    }
    
    func showQuestion(number: Int, selected: Question)  {
        print("\nQuestion \(number) - \(selected.question)")
        print("(A) \(selected.options[0])")
        print("(B) \(selected.options[1])")
        print("(C) \(selected.options[2])")
        print("(D) \(selected.options[3])")
    }
    
    func chooseOption() -> String {
        var input: String?
        var invalidOption: Bool = true
        var option: String = ""
        //@TODO hint1 and hint2 -
        while (invalidOption) {
            print("\nWhat is your option (A, B, C, D) ?")
            input = readLine()
            guard let op = input else {
                print ("You didn't provide option.")
                continue
            }
            if op.uppercased() == "A" || op.uppercased() == "B" || op.uppercased() == "C" || op.uppercased() == "D" {
                 invalidOption.toggle()
                //invalidOption = false
            } else {
                print("Invalid Option, try again")
            }
            option = op
        }
        return option
    }
    
    //@TODO Ask to confirm until answer Yes
    func confirmOption(option: String) -> String {
        var input: String?
        var result = option
        var invalidOption: Bool = true
        
        while (invalidOption) {
            print("Confirm your option (Y-Yes N-No), you choose \(option.uppercased())")
            input = readLine()
            guard let conf = input else {
                print ("You didn't provide answer (Y-Yes N-No).")
                continue
            }
            invalidOption.toggle()
            //invalidOption = false
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
        print("Option confirmed '\(result.uppercased())'")
        return result
    }
    
    func looseOrWin(option: String, selected: Question) -> Bool {
        let index = selected.correctAnswer.rawValue
        let correct = selected.correctAnswer
        
        if (option == correct.choice()) {
            print("\nYour answer is correct.")
            return true
        } else {
            print("Correct Answer is \(selected.options[index])")
            print("You lost. You'll win $ \(player.totalWin)")
            return false
        }
    }
    
    func defineContinue() -> Bool {
        var input: String?
        var invalidOption: Bool = true
        var cont: Bool = true
        
        while (invalidOption) {
            print("\nDo you want to continue in the Game   (Y-Yes or N-No) ?")
            input = readLine()
            guard let conf = input else {
                print ("You didn't define Continue or Stop the Game.")
                continue
            }
            invalidOption.toggle()
            //invalidOption = false
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
}
