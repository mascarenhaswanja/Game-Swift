//
//  BankofQuestions.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-11.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation
struct Question {
    let level: Int
    let question: String
    let options: [String]
    let correctAnswer: Int
}

// https://millionaire.fandom.com/wiki/Who_Wants_to_Be_a_Millionaire%3F_(U.S._version)/Final_Questions
// let questions : Question = Question()
let questions = [
    Question(level:1, question:"What insect shorted out an early supercomputer and inspired the term: computer bug?", options:["Roach", "Fly", "Japanese beetle", "Moth"],correctAnswer: 3),
    Question( level:1,question:"In the U.S., the Sony Walkman personal cassette player was originally marketed in 1979 under what name?", options:["Soundabout", "Listener", "Eardrummer", "Stowaway"], correctAnswer: 0),
    Question(level:1, question: "Famous pediatrician and author Dr. Benjamin Spock won an Olympic gold medal in what sport?", options:["Swimming", "Rowing", "Fencing", "Sailing"],correctAnswer: 1),
    Question(level:1, question: "According to the Population Reference Bureau, what is the approximate number of people who have ever lived on earth?", options:["50 billion", "100 billion", "1 trillion", "5 trillion"],correctAnswer: 1),
    Question(level:1, question: "The most-watched TV episode of all time, the final episode of M*A*S*H aired at 8:30 PM, on February 28, 1983, following what sitcom?", options:["Private Benjamin", "Square Pegs", "Alice", "Newhart"],correctAnswer: 2),
    
    Question(level:2, question:"Before the American colonies switched to the Gregorian calendar, on what date did their new year start?", options:["March 25", "July 1", "September 25", "December 1"],correctAnswer: 0),
    Question(level:2, question:"During the Cold War, the U.S. government built a bunker to house Congress under what golf resort?", options:["The Breakers", "The Greenbrier", "Pinehurst", "The Broadmoor"], correctAnswer: 1),
    Question(level:2, question:"Who is the only winner of the Nobel Peace Prize to decline the prize?", options:["Albert Schweitzer", "Andrei Sakharov", "Le Duc Tho", "Aung San Suu Kyi"], correctAnswer: 2),
    Question(level:2, question:"In a failed assassination attempt, what U.S. president was shot twice at the point-blank range, but survived because both guns misfired?", options:["John Adams", "Andrew Jackson", "James Polk", "Martin Van Buren"], correctAnswer: 1),
    Question(level:2, question:"A rare example of a word that rhymes with - orange, the Blorenge is a what?", options:["River in Ireland", "Forest in Scotland", "Mountain in Wales", "Desert in Australia"], correctAnswer: 2),
    
    Question(level:3, question:"In the children's book series, where is Paddington Bear originally from?", options:["India", "Peru", "Canada", "Iceland"],correctAnswer: 1),
    Question(level:3, question:"Who is credited with inventing the first mass-produced helicopter?", options:["Elmer Sperry", "Ferdinand von Zeppelin", "Gottlieb Daimler", "Igor Sikorsky"], correctAnswer: 3),
    Question(level:3, question:"Who is the only Nobel laureate to win an Academy Award?", options:["John Steinback", "Jean-Paul Sartre", "George Bernard Shaw", "Toni Morrison"], correctAnswer: 2),
    Question(level:3, question:"What great thinker's death is attributed to a chill he caught while stuffing a chicken with snow for an experiment on refrigeration?", options:["Pythagoras", "Archimedes", "Isaac Newton", "Francis Bacon"], correctAnswer: 3),
    Question(level:3, question:"When scientists tested it with an electroencephalogram, which of these food items produced readings similar to a human brain?", options:["Wint-O-Green Life Saver", "SPAM", "Lime Jell-O", "Jet-Puffed Marshmallow"], correctAnswer: 2),
]
