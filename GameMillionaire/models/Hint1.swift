//
//  Hint1.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-16.
//  Copyright © 2021 Wanja. All rights reserved.
//
import Foundation

class Hint1: Hint {
    let description: String
    
    public override init() {
        description = "50/50 Hint"
        super.init()
    }

     
    public override func responseHint(question: Question) -> [String] {
        var randomAnswer: Int
        let optionCorrect = question.correctAnswer.rawValue
        let wrongAnswer: String
        
        repeat {
            randomAnswer = Int.random(n: 3)
            //randomAnswer = Int.random(in: 0..<3)
        } while (randomAnswer == optionCorrect)
        
        switch randomAnswer {
        case 0:
            wrongAnswer = "a"
        case 1:
            wrongAnswer = "b"
        case 2:
            wrongAnswer = "c"
        case 3:
            wrongAnswer = "d"
        default:
            wrongAnswer = "a"
        }
        var result: [String] = []
        //let randomResult = Int.random(in: 0...1)
        let randomResult = Int.random(n: 1)
        if(randomResult == 0){
            result.append(question.correctAnswer.choice())
            result.append(wrongAnswer)
        }
        else{
            result.append(wrongAnswer)
            result.append(question.correctAnswer.choice())
        }
        return (result)
    }
    
    public override func printOptions() {
        print("A - \(description)")
        // super.printOptions()
    }
}
