//
//  Player.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-11.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

struct Player {
    var name: String?
    var totalWin: Int = 0
    var currentQuestion: Int = 1
    var hint1: Bool = false
    var hint2: Bool = false
    
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
    
    // Constructor
    init(name:String) {
        self.name = name
    }
    
    
    
}
