//
//  Game.swift
//  GameOfLife
//
//  Created by Brahim Lamri on 9/6/2023.
//

import Foundation

fileprivate typealias Row = [Cell]
fileprivate typealias Grid = [Row]

final class Game {
    
    private var numberOfRows: UInt
    private var numberOfColums: UInt
    
    private var grid = Grid()
    
    init(numberOfRows: UInt, numberOfColums: UInt) {
        self.numberOfRows = numberOfRows
        self.numberOfColums = numberOfColums
        grid = createGrid()
    }
}

extension Game {
    private func createGrid() -> Grid {
        var grid = Grid()
        for x in 0..<numberOfRows {
            var row = Row()
            for y in 0..<numberOfColums {
                row.append(Cell(x: x, y: y, state: .dead))
            }
            grid.append(row)
        }
        return grid
    }
}

extension Game {
    func printGrid() {
        _ = grid.map { row in
            let symbolsInRow = row.map {
                return $0.state == .alive ? "■" : "□"
                
            }
            print(
                symbolsInRow.joined(
                    separator: String.space
                )
            )
        }
        print()
    }
}
