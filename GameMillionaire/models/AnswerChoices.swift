//
//  AnswerChoices.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-12.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

// CaseIerable protocol doesn't work in XCode 9.4
enum AnswerChoices: Int {
    case a = 0
    case b = 1
    case c = 2
    case d = 3
    
    func choice() -> String {
        return "\(self)"
    }
}


