//
//  GameOfLifeTests.swift
//  GameOfLifeTests
//
//  Created by Brahim Lamri on 9/6/2023.
//

import XCTest
@testable import GameOfLife

final class GameOfLifeTests: XCTestCase {

    private var sut: Game!

    override func setUp() {
        sut = Game(
            numberOfRows: 3,
            numberOfColums: 6
        )
    }

    override func tearDown() {
        sut = nil
    }
    
    func testPrintingGrid() {
        sut.printGrid()
    }
}
