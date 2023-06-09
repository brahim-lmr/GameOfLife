//
//  Cell.swift
//  GameOfLife
//
//  Created by Brahim Lamri on 9/6/2023.
//

import Foundation

enum State {
    case alive
    case dead
}

struct Cell: Equatable {
    
    let x: UInt
    let y: UInt
    
    var state: State = .dead
    
    static func ==(lhs: Cell, rhs: Cell) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
