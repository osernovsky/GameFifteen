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
        } while !isSolvable()
        
        //        if size > 2 {
        //            repeat {
        //                tiles.shuffle()
        //                for i in 0..<size * size {
        //                    tiles[i].col = i % size
        //                    tiles[i].row = i / size
        //                }
        //            } while !isSolvable()
        //        } else {
        //            tiles[0].col = 1 // 1
        //            tiles[0].row = 1
        //            tiles[1].col = 0 // 2
        //            tiles[1].row = 1
        //            tiles[2].col = 0 // 3
        //            tiles[2].row = 0
        //            tiles[3].col = 1 // 0
        //            tiles[3].row = 0
        //        }
    }
    
    //    mutating func moveTile(at index: Int, toRow newRow: Int, toCol newCol: Int) {
    //        tiles[index].row = newRow
    //        tiles[index].col = newCol
    //    }
    
    func printField() {
        for row in 0..<size {
            for col in 0..<size {
                print(tiles[row * size + col].value, terminator: " ")
            }
            print()
        }
    }
}
