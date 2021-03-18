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
    
    init (player: Player) {
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
        
        // Control the Game
        var resultWin = false
        var defContinue = true
        var option: String
        
        repeat {
            print("\nYou're in ROUND: \(round) \n Question: \(currentQuestion) Remain Questions: \(9 - currentQuestion)")
            print(" Total Until Now $:\(totalWin)")
            
            // Select and Show Question
            let questionSelected = selectedQuestions[currentQuestion-1]
            showQuestion(number: currentQuestion, selected: questionSelected, op: questionSelected.options)
            
            // Want an Hint
            if round <= 2 && (!h1.usedHint || !h2.usedHint)  {
                let want:Bool = wantHint()
                if want {
                    let hintSelected = chooseHint(h:hints)
                    if hintSelected.uppercased() == "A" {
                        let result50 = h1.responseHint(question: questionSelected)
                        showHint(number: currentQuestion, selected: questionSelected, op: result50)
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
                        print("Audience Choose Option \(option.uppercased())")
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
                switch currentQuestion {
                case 1,2: totalWin = WinningRound.round1.rawValue
                case 3:   totalWin = WinningQuestion.question3.rawValue
                case 4,5: totalWin = WinningRound.round2.rawValue
                case 6:   totalWin = WinningQuestion.question6.rawValue
                case 7:   totalWin = WinningQuestion.question7.rawValue
                case 8:   totalWin = WinningQuestion.question8.rawValue
                case 9:   totalWin = WinningQuestion.question9.rawValue
                default:  totalWin = 0
                }
                
                if (currentQuestion == 3 || currentQuestion == 6) || (round == 3 && currentQuestion < 9) {
                    defContinue = defineContinue()
                }
                currentQuestion += 1
            }
            else {
                switch round {
                case 1:  totalWin = WinningRound.round1.rawValue
                case 2:  totalWin = WinningRound.round2.rawValue
                case 3:  totalWin = WinningRound.round3.rawValue
                default: totalWin = 0
                }
            }
        } while resultWin && defContinue && currentQuestion <= 9
        
        if resultWin {
            if currentQuestion > 9 {
                print("\n\n CONGRATULATIONS!!! \(player.name ?? "") you're a millionaire. You won $ \(totalWin)")
            } else {
                print("\n\n \(player.name ?? "") you won $ \(totalWin)")
            }
        }  else {
            print("\n\n \(player.name ?? "") you won $ \(totalWin)")
        }
    }
    
    func showQuestion(number: Int, selected: Question, op:[String])  {
        print("\nQuestion \(number) - \(selected.question)")
        // CaseIerable protocol doesn't work in XCode 9.4
        let letters = ["a", "b", "c", "d"]
        for i in 0...3 {
            print("\(letters[i].uppercased()) - \(selected.options[i])")
        }
    }
    
    func showHint(number: Int, selected: Question, op: [String]) {
        print("\nQuestion \(number) - \(selected.question)")
        var sortOp = op
        sortOp.sort()
        let letters = ["a", "b", "c", "d"]
        
        // Version 9.4 - firstIndex(where:  )  - doesn't work
        // WOM - use where
        //  let index1 = letters.firstIndex(where: sortOp[0].uppercased()) ?? 0
        //  let index2 = letters.firstIndex(where: sortOp[1].uppercased()) ?? 0
        
        let index1 = letters.index(of: sortOp[0]) ?? letters.endIndex
        let index2 = letters.index(of: sortOp[1]) ?? letters.endIndex
        print("\(letters[index1].uppercased()) - \(selected.options[index1])")
        print("\(letters[index2].uppercased()) - \(selected.options[index2])")
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
            if op.uppercased() == "A" || op.uppercased() == "B" || op.uppercased() == "C" || op.uppercased() == "D"  {
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
            print("\nWrong Answer, CORRECT Answer is:   \(correct.choice().uppercased()) - \(selected.options[index])")
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
    
    func chooseHint(h: [Hint]) -> String {
        var optionHint: String = "a"
        var input: String?
        var invalidOption: Bool = true
        print("\nWhat is your Hint?")
        for item in hints {
            if !item.usedHint {
                item.printOptions()
            }
        }
        print("HINT: ", terminator: "")
        while (invalidOption) {
            input = readLine()
            guard let op = input else {
                print ("You didn't provide option.")
                continue
            }
            optionHint = op
            if optionHint.uppercased() == "A"  && !(hints[0].usedHint) {
                invalidOption.toggle()
            } else {
                if  optionHint.uppercased() == "B"   && !(hints[1].usedHint) {
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
