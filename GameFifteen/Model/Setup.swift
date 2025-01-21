//
//  GameSetup.swift
//  GameFifteen
//
//  Created by Sergey Dubrovin on 19.01.2025.
//

import Foundation

struct GameSetup {
    
    static var shared = GameSetup()
    
    var fieldSize: Int = 5
    var score: Int = 0
    var startTime: Date?
    
    init() {}
}
