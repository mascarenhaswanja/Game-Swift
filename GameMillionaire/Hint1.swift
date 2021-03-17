//
//  Hint1.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-16.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

class Hint1: Hint {
    let hint1: String
    
    public override init() {
        hint1 = "50/50 Hint"
        super.init()
    }

    public override func responseHint(question: Question) -> [Int] {
        // @TODO return 2 possible - 1 is correct and one wrong
        return [0,1]
    }
    
    public func showQuestionHint1(number: Int, selected: Question)  {
            print("\nQuestion \(number) - \(selected.question)")
            print("(A) \(selected.options[0])")
            print("(B) \(selected.options[1])")
    }
    
    public override func printOptions() {
        print("Hint1 subclass")
        super.printOptions()
    }
}
