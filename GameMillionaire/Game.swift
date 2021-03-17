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
        let h1: Hint1 = Hint1()
        let h2: Hint2 = Hint2()
        hints.append(h1)
        hints.append(h2)
        // ERASE
        // print(game.hints[0].usedHint)
        // print(h1.usedHint)
        
        // Control the Game
        var resultWin = false
        var defContinue = true
        var option: String
        
        repeat {
            print("\nYou're in ROUND: \(round) QUESTION: \(currentQuestion) REMAIN QUESTIONS: \(9 - currentQuestion)")
            print("TOTAL EARNED UNTIL NOW $:\(totalWin)")
            
            // Select and Show Question
            let questionSelected = selectedQuestions[currentQuestion-1]
            showQuestion(number: currentQuestion, selected: questionSelected, op: questionSelected.options)
            
            // Want an Hint
            if round <= 2 && (!h1.usedHint || !h2.usedHint)  {
                print("Test hint")
                
                // ask audience - option
                // 50 - define option
                let want:Bool = wantHint()
                if want {
                    // h1.usedHint = true
                    let hintNumber = chooseHint(h:hints)
                    print(hintNumber)
                    if hintNumber == 1 {
                        let result50 = h1.responseHint(question: questionSelected)
                        showHint(number: currentQuestion, selected: questionSelected, op: result50)
                        //option = result50[0]
                        var confirm = false
                        repeat {
                            // Choose Option
                            option = chooseOptionHint(opHint: result50)
                            // Confirm Option
                            confirm = confirmOptionHint(option: option)
                        } while !confirm
                        h1.usedHint = true
                    } else {
                        let audience = h2.responseHint(question: questionSelected)
                        option = audience[0]
                        h2.usedHint = true
                    }
                } else {  //  NO HINT
                    var confirm = false
                    repeat {
                        // Choose Option
                        option = chooseOption()
                        // Confirm Option
                        confirm = confirmOption(option: option)
                    } while !confirm
                }
            } else {  // round3 - NO HINTS
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
    
    // func showQuestion(number: Int, selected: Question)  {
    //     print("\nQuestion \(number) - \(selected.question)")
    //     print("(A) \(selected.options[0])")
    //     print("(B) \(selected.options[1])")
    //     print("(C) \(selected.options[2])")
    //     print("(D) \(selected.options[3])")
    // }
    func showQuestion(number: Int, selected: Question, op:[String])  {
        
        print("\nQuestion \(number) - \(selected.question)")
        
        let letters = ["A", "B", "C", "D"]
        for i in 0...3 {
            print("\(letters[i]) - \(selected.options[i])")
        }
    }
    
    func showHint(number: Int, selected: Question, op: [String]) {
        print("\nQuestion \(number) - \(selected.question)")
        print(op[0], op[1])
        var sortOp = op
        sortOp.sort()
        let letters = ["A", "B", "C", "D"]
        let index1 = letters.firstIndex(of: sortOp[0].uppercased) ?? 0
        let index2 = letters.firstIndex(of: sortOp[1].uppercased) ?? 0
        
        print("\(letters[index1]) - \(selected.options[index1])")
        print("\(letters[index2]) - \(selected.options[index2])")
    }
    
    func chooseOption() -> String {
        var input: String?
        var invalidOption: Bool = true
        var option: String = ""
        while (invalidOption) {
            print("\nWhat is your option (A, B, C, D, E) ?")
            input = readLine()
            guard let op = input else {
                print ("You didn't provide option.")
                continue
            }
            if op.uppercased() == "A" || op.uppercased() == "B" || op.uppercased() == "C" || op.uppercased() == "D"  || op.uppercased() == "E" {
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
    
    func chooseOptionHint(opHint: [String]) -> String {
        var input: String?
        var invalidOption: Bool = true
        var option: String = ""
        while (invalidOption) {
            print("\nWhat is your option ?")
            input = readLine()
            guard let op = input else {
                print ("You didn't provide option.")
                continue
            }
            //////
            if op.uppercased() == opHint[0].uppercased() || op.uppercased() ==  opHint[1].uppercased() {
                invalidOption.toggle()
                //invalidOption = false
            } else {
                print("Invalid Option, try again")
            }
            option = op
        }
        return option
    }
    //  MAYBE NOT
    func confirmOptionHint(option: String) -> Bool {
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
    
    func wantHint() -> Bool {
        var input: String?
        var invalidOption: Bool = true
        var cont: Bool = true
        
        while (invalidOption) {
            print("\nDo you want a Hint (Y-Yes or N-No) ?")
            input = readLine()
            guard let conf = input else {
                print ("You didn't define if You wanna a Hint.")
                continue
            }
            invalidOption.toggle()
            //invalidOption = false
            if conf.uppercased() == "Y" {
                cont = true
            } else if conf.uppercased() == "N" {
                cont = false
            } else {
                invalidOption.toggle()
                //invalidOption = true
                print("Invalid, try again")
            }
        }
        return cont
    }
    
    func chooseHint(h: [Hint]) -> Int {
        var optionHint: Int = 0
        var input: String?
        var invalidOption: Bool = true
        
        print("\nWhat is your Hint?")
        //for item in hints   {
        for item in hints {
            if !item.usedHint {
                item.printOptions()
            }
        }
        while (invalidOption) {
            
            input = readLine()
            guard let op = input else {
                print ("You didn't provide option.")
                continue
            }
            optionHint = Int(op)!
            if optionHint == 1  && !(hints[0].usedHint) {
                print("chooseHint1")
                invalidOption.toggle()
            } else {
                if optionHint == 2  && !(hints[1].usedHint) {
                    print("chooseHint2")
                    invalidOption.toggle()
                    //invalidOption = false
                } else {
                    print("Invalid Option, try again")
                }
            }
        }
        return optionHint
    }
}
