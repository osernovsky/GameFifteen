//
//  GameClass.swift
//  GameFifteen
//
//  Created by Sergey Dubrovin on 19.01.2025.
//

import SwiftUI

struct Tile: Identifiable, Equatable {
    var id = UUID()
    var value: Int = 0  // Значение плитки
    var col: Int        // Столбец плитки
    var row: Int        // Строка плитки
    
    init(col: Int, row: Int, value: Int) {
        self.value = value
        self.col = col
        self.row = row
    }
}

struct Field {
    
    var tiles: [Tile] = []
    var size: Int
    
    init(size: Int) {
        self.size = size
        newGame()
    }
    
    mutating func newGame() {
        
        tiles.removeAll()
        
        for row in 0..<size {
            for col in 0..<size {
                let value = row * size + col + 1
                tiles.append(Tile(col: col, row: row, value: value))
            }
        }
        tiles[tiles.count - 1].value = 0
        
        repeat {
            tiles.shuffle()
            for i in 0..<size * size {
                tiles[i].col = i % size
                tiles[i].row = i / size
            }
        } while !isSolvable() || tableSolved()
    }
}
