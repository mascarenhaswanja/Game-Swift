//
//  Hint2.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-16.
//  Copyright © 2021 Wanja. All rights reserved.
//
import Foundation

class Hint2: Hint {
    let description: String
    
    public override init() {
        description = "Ask Audience Hint"
        super.init()
    }
    
    public override func responseHint(question: Question) -> [String] {
        let optionCorrect = question.correctAnswer.rawValue
        let randomVal = Int.random(n: 100)
        //let randomVal = Int.random(in: 0..<100)
        
        var randomAnswer: Int
        
        if randomVal < 75 {
            return [question.correctAnswer.choice()]
        } else {
            repeat {
                 randomAnswer = Int.random(n: 3)
                 //randomAnswer = Int.random(in: 0..<3)
            } while (randomAnswer == optionCorrect)
            
            switch randomAnswer {
            case 0:
                return ["a"]
            case 1:
                return ["b"]
            case 2:
                return ["c"]
            case 3:
                return ["d"]
            default:
                return ["a"]
            }
        }
    }

    public override func printOptions() {
        print("B - \(description)")
        //super.printOptions()
    }
}
