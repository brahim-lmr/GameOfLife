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
    
    func test_stateOfCellShouldBeChanged() {
        // GIVEN
        var cell1 = Cell(x: 1, y: 2, state: .alive)
        var cell2 = Cell(x: 1, y: 2, state: .dead)

        // WHEN
        cell1.switchState()
        cell2.switchState()

        // THEN
        XCTAssertEqual(cell1.state, .dead)
        XCTAssertEqual(cell2.state, .alive)
    }
    
    func test_ifTwoCellAreNeighbourds() {
        // GIVEN
        var cell = Cell(x: 2, y: 2)
        
        var cell1 = Cell(x: 1, y: 1)
        var cell2 = Cell(x: 1, y: 2)
        var cell3 = Cell(x: 1, y: 3)
        var cell4 = Cell(x: 2, y: 1)
        var cell5 = Cell(x: 2, y: 2)
        var cell6 = Cell(x: 2, y: 3)
        var cell7 = Cell(x: 3, y: 1)
        var cell8 = Cell(x: 3, y: 2)
        var cell9 = Cell(x: 3, y: 3)

        var cell10 = Cell(x: 1, y: 4)

        // THEN
        XCTAssertTrue(sut.areNeighbours(rhd: cell, lhd: cell1))
        XCTAssertTrue(sut.areNeighbours(rhd: cell, lhd: cell2))
        XCTAssertTrue(sut.areNeighbours(rhd: cell, lhd: cell3))
        XCTAssertTrue(sut.areNeighbours(rhd: cell, lhd: cell4))
        XCTAssertTrue(sut.areNeighbours(rhd: cell, lhd: cell6))
        XCTAssertTrue(sut.areNeighbours(rhd: cell, lhd: cell7))
        XCTAssertTrue(sut.areNeighbours(rhd: cell, lhd: cell8))
        XCTAssertTrue(sut.areNeighbours(rhd: cell, lhd: cell9))
        
        XCTAssertFalse(sut.areNeighbours(rhd: cell, lhd: cell5))
        XCTAssertFalse(sut.areNeighbours(rhd: cell, lhd: cell10))

    }
}
