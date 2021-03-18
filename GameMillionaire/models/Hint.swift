//
//  Hint.swift
//  GameMillionaire
//
//  Created by Wanja on 2021-03-16.
//  Copyright © 2021 Wanja. All rights reserved.
//
import Foundation

// Use Protocol Printable
class Hint : Printable {
    var usedHint = false
    
    // default constructor
    public init() {}
    
    // polymorphic method
    public func responseHint(question: Question) -> [String] {
        return []
    }
    
    // polymorphic method
    public func printOptions() {
        print("Hint superclass")
    }
    
}
