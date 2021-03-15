//
//  Question.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-08.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

struct Question {
    let level: Int
    let question: String
    let options: [String]
    let correctAnswer: AnswerChoices
}
