//
//  Game.swift
//  GameOfLife
//
//  Created by Brahim Lamri on 9/6/2023.
//

import Foundation

fileprivate typealias Row = [Cell]
fileprivate typealias Grid = [Row]
typealias Position = (x: Int, y: Int)

final class Game {
    
    private var numberOfRows: Int
    private var numberOfColums: Int
    
    private var grid = Grid()
    
    init(numberOfRows: Int, numberOfColums: Int) {
        self.numberOfRows = numberOfRows
        self.numberOfColums = numberOfColums
        grid = createGrid()
    }
    
    func isValid(_ position: Position) -> Bool {
        (position.x >= 0 && position.x < numberOfRows)
        &&
        (position.y >= 0 && position.y < numberOfColums)
    }
    
    func getCell(at position: Position) -> Cell? {
        guard isValid(position) else { return nil }
        
        return grid[position.x][position.y]
    }
    
    func changeStateOfCellAt(
        position: Position,
        to state: State
    ) {
        guard isValid(position) else { return }
        
        grid[position.x][position.y].state = state
    }
    
    func areNeighbours(rhd: Cell, lhd: Cell) -> Bool {
        if rhd == lhd { return false }
        
        // Two cell are neighbourds if
        // the offset between x axis is 1 or 0
        // and the offset between y axis is 1 or 0
        
        let range = [0, 1]
                
        let xOffset = abs(rhd.x - lhd.x)
        let yOffset = abs(rhd.y - lhd.y)

        return range.contains(xOffset) && range.contains(yOffset)
    }
    
    func getNeighborsForCell(at position: Position) -> [Cell] {
        guard let cell = getCell(at: position) else { return [] }
        
        return  grid
            .flatMap { $0 }
            .filter { areNeighbours(rhd: $0, lhd: cell) }
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
