//
//  Player.swift
//  GameMillionaire
//
//  Created by Muzammil on 2021-03-11.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

class Player {
    var name: String?
    
    
    func welcomeGame() {
        print("******************************************************************")
        print("****                        WELCOME TO PLAY                   ****")
        print("****                 WHO WANTS TO BE A MILIONAIRE             ****")
        print("******************************************************************")
        print("****    You have 3 Rounds (Easy, Medium and High Difficult    ****")
        print("****              Each round has 3 questions                  ****")
        print("**** Round 1 and 2 you can use hints: 50/50 or Ask Audience   ****")
        print("****              Round 3 allows stop in each question        ****")
        print("******************************************************************")
        
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
            result = unwrapped
        }
        self.name = result
        print("Hello, \(result.uppercased())")
    }
}
