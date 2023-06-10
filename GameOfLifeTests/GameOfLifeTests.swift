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
            numberOfRows: 6,
            numberOfColums: 6
        )
    }

    override func tearDown() {
        sut = nil
    }
    
    func testPrintingGrid() {
        sut.printGrid()
    }
    
    
    func test_isValidPositionInGrid() {
        // GIVEN
        let position1: Position = (x:1, y: 3)
        let position2: Position = (x:7, y: 1)
        let position3: Position = (x:2, y: 7)
        let position4: Position = (x:7, y: 7)

        // THEN
        XCTAssertTrue(sut.isValid(position1))
        XCTAssertFalse(sut.isValid(position2))
        XCTAssertFalse(sut.isValid(position3))
        XCTAssertFalse(sut.isValid(position4))
    }
    
    func test_positionShouldReturnCell() {
        // GIVEN
        let aCell = Cell(x: 1, y: 3)
        let position: Position = (x:1, y: 3)
        
        // WHEN
        let cell = sut.getCell(at: position)
       
        // THEN
        XCTAssertNotNil(cell)
        XCTAssertEqual(aCell, cell)
    }
}
