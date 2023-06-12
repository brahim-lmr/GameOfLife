//
//  Cell.swift
//  GameOfLife
//
//  Created by Brahim Lamri on 9/6/2023.
//

import Foundation

enum CellState {
    case alive
    case dead
    
    mutating func toggle() {
        switch self {
        case .alive:
            self = .dead
        case .dead:
            self = .alive
        }
    }
}

struct Cell: Hashable {
    
    let x: Int
    let y: Int
    
    var state: CellState = .dead
    
    var position: Position {
        (x: x, y: y)
    }
    
    static func ==(lhs: Cell, rhs: Cell) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
