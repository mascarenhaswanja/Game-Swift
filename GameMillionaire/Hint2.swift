//
//  Hint2.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-16.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

class Hint2: Hint {
    let hint2: String
    
    public override init() {
        hint2 = "Ask Audience Hint"
        super.init()
    }
    
    public override func responseHint(question: Question) -> [Int] {
        let optionCorrect = question.correctAnswer.rawValue
        let randomVal = Int.random(n: 100)
        var randomAnswer: Int
        
            if randomVal < 75 {
                return [optionCorrect]
            } else {
                repeat {
                    randomAnswer = Int.random(n: 3)
                } while (randomAnswer == optionCorrect)
                 return [randomAnswer]
            }
    }
    
    public override func printOptions() {
        print("Hint2 subclass")
        super.printOptions()
    }
}
