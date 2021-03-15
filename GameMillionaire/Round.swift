//
//  Round.swift
//  GameMillionaire
//
//  Created by Letícia Lima on 2021-03-15.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

extension Winning {
    func roundWinning(_ round: Int = 1) -> String {
        return String(format:"\(round)",self as! CVarArg)
    }
}
