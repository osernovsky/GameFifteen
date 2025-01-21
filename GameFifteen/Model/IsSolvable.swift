//
//  IsSolvable.swift
//  GameFifteen
//
//  Created by Sergey Dubrovin on 20.01.2025.
//

extension Field {
    
    func isSolvable() -> Bool {
        
        let flatTiles = tiles.map { $0.value }.filter { $0 != 0 }
        var inversions = 0
        
        for i in 0..<flatTiles.count {
            for j in (i+1)..<flatTiles.count {
                if flatTiles[i] > flatTiles[j] {
                    inversions += 1
                }
            }
        }
        
        let emptyTile = tiles.first { $0.value == 0 }
        let emptyRowFromBottom = size - emptyTile!.row
        
        if size % 2 == 0 {
            print("\nПоле четное. Инверсий \(inversions), позиция нуля снизу \(emptyRowFromBottom)")
            printField()
//            return (inversions % 2 != 0) && (emptyRowFromBottom % 2 == 0)
            return ((inversions % 2 != 0) && (emptyRowFromBottom % 2 == 0)) || ((inversions % 2 == 0) && (emptyRowFromBottom % 2 != 0))
        } else {
            print("\nПоле нечетное. Инверсий \(inversions)")
            printField()
            return inversions % 2 == 0
        }
    }
}

extension Field {
    
    func tableSolved() -> Bool {
        for tile in tiles {
            let isHome = tile.row * size + tile.col + 1 == tile.value
            if !isHome && tile.value != 0 {
                return false
            }
        }
        return true
    }
}
