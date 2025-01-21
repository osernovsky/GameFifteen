//
//  Move.swift
//  GameFifteen
//
//  Created by Sergey Dubrovin on 20.01.2025.
//

extension Field {
    
    func whereIsEmpty() -> (index: Int, col: Int, row: Int) {
        let emptyTile = tiles.first { $0.value == 0 }!
        let index = tiles.firstIndex { $0 == emptyTile }!
        return (index, emptyTile.col, emptyTile.row)
    }
}

extension Field {
    
    mutating func move(at index: Int) -> Bool {
        
        let col = tiles[index].col
        let row = tiles[index].row
        let emptyTile = whereIsEmpty()
        
        if (abs(col - emptyTile.col) == 1 && (row - emptyTile.row) == 0)
            || (abs(row - emptyTile.row) == 1 && (col - emptyTile.col) == 0){
            tiles[index].col = emptyTile.col
            tiles[index].row = emptyTile.row
            tiles[emptyTile.index].col = col
            tiles[emptyTile.index].row = row
            
            return true
        }
        
        return false
    }
}
