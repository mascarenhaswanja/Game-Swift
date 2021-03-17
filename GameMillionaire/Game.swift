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
    let questions: BankOfQuestions = BankOfQuestions()
//    var hint1: Hint1
//    var hint2: Hint2
    var hints: [Hint] = []
    var totalWin: Int = 0
    var currentQuestion: Int = 1

    // computed property
    var round: Int {
        get {
            if currentQuestion <= 3 {
                return 1
            } else if currentQuestion <= 6 {
                return 2
            } else {
                return 3
            }
        }
    }
    
    init(player: Player) {
        self.player = player
    }
    
    
    func playGame() {
        //  Select Random Questions for Game
        let selectedQuestions = questions.gameQuestions()
        
        // Hints
        let hint1: Hint1 = Hint1()
        let hint2: Hint2 = Hint2()
        hints.append(hint1)
        hints.append(hint2)

        // Control the Game
        var resultWin = false
        var defContinue = true
        
        repeat {
            print("\nYou're in ROUND: \(round) QUESTION: \(currentQuestion) REMAIN QUESTIONS: \(9 - currentQuestion)")
            print("TOTAL EARNED UNTIL NOW $:\(totalWin)")
            
            // Select and Show Question
            let questionSelected = selectedQuestions[currentQuestion-1]
            showQuestion(number: currentQuestion, selected: questionSelected)

            // Want an Hint
            var option: String
            if round <= 2 && (hint1.usedHint || hint2.usedHint)  {
                print("Test  Hint - a")
                option = "a"
                //chooseHint()
                hint1.usedHint = true
                hint2.usedHint = true
            } else {
                var confirm = false
                repeat {
                    // Choose Option
                    option = chooseOption()
                    // Confirm Option
                    confirm = confirmOption(option: option)
                } while !confirm
            }
            
            // Win or loose
            resultWin = looseOrWin(option: option, selected: questionSelected)
            
            if resultWin {
                //@TODO update with enum
                //player.totalWin = amountWinning[player.currentQuestion - 1]
                //  NEDEED UPDATE
                switch round {
                    case 1:  totalWin = WinningRound.round1.rawValue
                    case 2:  totalWin = WinningRound.round2.rawValue
                    case 3:  totalWin = WinningRound.round3.rawValue
                    default: totalWin = 0
                }
                
                if (currentQuestion == 3 || currentQuestion == 6) || (round == 3 && currentQuestion < 9) {
                    defContinue = defineContinue()
                }
                currentQuestion += 1
            }
        } while resultWin && defContinue && currentQuestion <= 9
        
        if resultWin {
            if currentQuestion > 9 {
                totalWin = WinningQuestion.question9.rawValue
                print("\n\nCONGRATULATIONS!!! You're a millionaire. You earned $ \(totalWin)")
            } else {
                print("\n\nYou earned $ \(totalWin)")
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

    func confirmOption(option: String) -> Bool {
        var input: String?
        var result = false
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
                print("Option confirmed '\(option.uppercased())'")
                result = true
            } else if conf.uppercased() == "N" {
                invalidOption = false
                print("You'll change your option")
                // result = chooseOption()
            } else {
                invalidOption = true
                print("Invalid, try again")
            }
        }
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
            print("You lost. You'll win $ \(totalWin)")
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
    
//    func chooseHint()  {
//    
//    var input: String?
//    var invalidOption: Bool = true
//    var cont: Bool = true
//    
//    while (invalidOption) {
//        print("\nDo you want a Hint (Y-Yes or N-No) ?")
//        input = readLine()
//        guard let conf = input else {
//        print ("You didn't define if wanna a Hint.")
//        continue
//        }
//        invalidOption.toggle()
//        //invalidOption = false
//        if conf.uppercased() == "Y" {
//                cont = true
//        } else if conf.uppercased() == "N" {
//        cont = false
//        } else {
//            invalidOption.toggle()
//        //invalidOption = true
//        print("Invalid, try again")
//        }
//    }
//    if cont {
//        print("Continue")
//    }
//    let optionHint: Int
//    while (invalidOption) {
//    print("\nWhat is your Hint (1- 50/50 or 2- Ask Audience) ?")
//    input = readLine()
//    guard let op = input else {
//    print ("You didn't provide option.")
//    continue
//    }
//    optionHint = Int(op)!
//    if optionHint == 1 || optionHint == 2 {
//    invalidOption.toggle()
//    //invalidOption = false
//    } else {
//    print("Invalid Option, try again")
//    }
//    }
//    let result: Int
//    if optionHint == 1 {
//    result = choosehint1()
//    print("Result Hint1 \(result)")
//    } else if optionHint == 2 {
//    result = choosehint2()
//    print("Result Hint2 \(result)")
//    }
//    }
//    
//    func choosehint1() ->  Int {
//        
//        print("HINT 1 - 50% Options")
//        //  return 2 option, 1 is correct  (random the second)
//        /*
//         50/50 chance
//         If they choose this hint type, the game will automatically remove two of the incorrect choices from the question.  A,b,c,d  -  B(correct) and A,C,D random
//         */
//        return 1
//    }
//    
//    // @TODO - only in round 1 or 2
//    func choosehint2() -> Int {
//        print("HINT 2 - Ask Audience")
//        // return pool answer???
//        /* If the player chooses this hint type, the game will “poll the audience” for their opinion on what the correct answer to the question is. The audience picks the correct answer 75% of the time.
//         */
//        var option: [Int] = Array(repeating: 0, count: 4)
//        var randomOption: Int
////        for _ in 1...4 {
////            randomOption = Int.random(in: 1...100)
////            option.append(randomOption)
//        //}
//        //return option.max()
//        //return option[0]
//    return 0
//    }
}
