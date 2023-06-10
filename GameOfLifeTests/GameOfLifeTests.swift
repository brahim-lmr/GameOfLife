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
        let position: Position = (x:1, y: 2)

        // WHEN
        sut.changeStateOfCellAt(position: position, to: .alive)
        let cell = sut.getCell(at: position)!
        // THEN
        XCTAssertEqual(cell.state, .alive)
    }
    
    func test_ifTwoCellareNeighbors() {
        // GIVEN
        let cell = Cell(x: 2, y: 2)
        
        let cell1 = Cell(x: 1, y: 1)
        let cell2 = Cell(x: 1, y: 2)
        let cell3 = Cell(x: 1, y: 3)
        let cell4 = Cell(x: 2, y: 1)
        let cell5 = Cell(x: 2, y: 2)
        let cell6 = Cell(x: 2, y: 3)
        let cell7 = Cell(x: 3, y: 1)
        let cell8 = Cell(x: 3, y: 2)
        let cell9 = Cell(x: 3, y: 3)

        let cell10 = Cell(x: 1, y: 4)

        // THEN
        XCTAssertTrue(sut.areNeighbors(rhd: cell, lhd: cell1))
        XCTAssertTrue(sut.areNeighbors(rhd: cell, lhd: cell2))
        XCTAssertTrue(sut.areNeighbors(rhd: cell, lhd: cell3))
        XCTAssertTrue(sut.areNeighbors(rhd: cell, lhd: cell4))
        XCTAssertTrue(sut.areNeighbors(rhd: cell, lhd: cell6))
        XCTAssertTrue(sut.areNeighbors(rhd: cell, lhd: cell7))
        XCTAssertTrue(sut.areNeighbors(rhd: cell, lhd: cell8))
        XCTAssertTrue(sut.areNeighbors(rhd: cell, lhd: cell9))
        
        XCTAssertFalse(sut.areNeighbors(rhd: cell, lhd: cell5))
        XCTAssertFalse(sut.areNeighbors(rhd: cell, lhd: cell10))

    }
    
    func test_getNeighborsForMiddleCell_shouldBeEight() {

        // GIVEN
        let position: Position = (x:2, y: 2)
        
        let cells = sut.getNeighborsForCell(at: position)
        
        // THEN
        XCTAssertEqual(cells.count, 8)
    }
    
    func test_getNeighborsForCornerCell_shouldBeThree()  {

        // GIVEN
        let position: Position = (x:0, y: 0)
        
        let cells = sut.getNeighborsForCell(at: position)
        
        // THEN
        XCTAssertEqual(cells.count, 3)
    }
    
    func test_getNeighborsForEdgeCell_shouldBeFive()  {

        // GIVEN
        let position: Position = (x:0, y: 1)
        
        let cells = sut.getNeighborsForCell(at: position)
        
        // THEN
        XCTAssertEqual(cells.count, 5)
    }
    
    func test_getNeighborsForNoExistingCell_shouldBeZero()  {

        // GIVEN
        let position: Position = (x:-1, y: -1)
        
        let cells = sut.getNeighborsForCell(at: position)
        
        // THEN
        XCTAssertEqual(cells.count, .zero)
    }
    
    func test_getLivingNeighborsForCell_ShouldBeZeroInEmptyGameGrid() {

        // GIVEN
        let position: Position = (x:2, y: 3)
        
        let aliveCells = sut.getAliveNeighbordForCell(at: position)
        // THEN
        XCTAssertEqual(aliveCells.count, 0)
        
    }
    
    func test_foundOneLivingNeighbors() {
        
        // GIVEN
        
        sut.changeStateOfCellAt(position: (x:1, y: 2), to: .alive)
        
        sut.printGrid()
        
        let position: Position = (x:2, y: 2)
        let aliveCells = sut.getAliveNeighbordForCell(at: position)

        // THEN
        XCTAssertEqual(aliveCells.count, 1)
        
    }
    
    func test_foundTwoLivingNeighbors() {
        
        // GIVEN
        
        sut.changeStateOfCellAt(position: (x:2, y: 1), to: .alive)
        sut.changeStateOfCellAt(position: (x:2, y: 3), to: .alive)
        sut.changeStateOfCellAt(position: (x:0, y: 1), to: .alive)

        sut.printGrid()
        
        let position: Position = (x:2, y: 2)
        let aliveCells = sut.getAliveNeighbordForCell(at: position)

        // THEN
        XCTAssertEqual(aliveCells.count, 2)
        
    }
    
    // REPRODUTION
    func test_deadCellWithThreeNeighbors_getsAlive() {
        
        // GIVEN
        sut.changeStateOfCellAt(position: (x:0, y: 3), to: .alive)
        sut.changeStateOfCellAt(position: (x:0, y: 4), to: .alive)
        sut.changeStateOfCellAt(position: (x:0, y: 5), to: .alive)
        sut.changeStateOfCellAt(position: (x:1, y: 4), to: .dead)
        
        sut.printGrid()
        
        // WHEN
        sut.computeNextGeneration()
        
        let state = sut.getCell(at: (x: 1, y: 4))?.state
        
        // THEN
        XCTAssertEqual(state, .alive)
        
        sut.printGrid()
    }
    
    // OVERPOPULATION
    func test_cellWithMoreThanThreeLivedNeighbors_dies() {
        
        // GIVEN
        sut.changeStateOfCellAt(position: (x:0, y: 3), to: .alive)
        sut.changeStateOfCellAt(position: (x:0, y: 4), to: .alive)
        sut.changeStateOfCellAt(position: (x:0, y: 5), to: .alive)
        sut.changeStateOfCellAt(position: (x:1, y: 3), to: .alive)
        sut.changeStateOfCellAt(position: (x:1, y: 4), to: .alive)

        sut.printGrid()

        // WHEN
        sut.computeNextGeneration()

        let cell1 = sut.getCell(at: (x: 0, y: 4))
        let cell2 = sut.getCell(at: (x: 1, y: 4))

        // THEN
        XCTAssertEqual(cell1?.state, .dead)
        XCTAssertEqual(cell2?.state, .dead)

        sut.printGrid()
    }
    
    // UNDERPOPULATION
    func test_cellWithLessThanTwoLivedNeighbors_dies() {
        
        // GIVEN
        sut.changeStateOfCellAt(position: (x:0, y: 3), to: .alive)
        sut.changeStateOfCellAt(position: (x:1, y: 4), to: .alive)
      
        sut.printGrid()

        // WHEN
        sut.computeNextGeneration()

        let cell1 = sut.getCell(at: (x: 0, y: 3))
        let cell2 = sut.getCell(at: (x: 1, y: 4))

        // THEN
        XCTAssertEqual(cell1?.state, .dead)
        XCTAssertEqual(cell2?.state, .dead)

        sut.printGrid()
    }
    
    func test_cellWithTwoLivedNeighbors_lives() {
        
        // GIVEN
        sut.changeStateOfCellAt(position: (x:0, y: 3), to: .alive)
        sut.changeStateOfCellAt(position: (x:0, y: 4), to: .alive)
        sut.changeStateOfCellAt(position: (x:1, y: 4), to: .alive)
        sut.changeStateOfCellAt(position: (x:2, y: 5), to: .alive)

        sut.printGrid()

        // WHEN
        sut.computeNextGeneration()

        let cell = sut.getCell(at: (x: 1, y: 4))

        // THEN
        XCTAssertEqual(cell?.state, .alive)

        sut.printGrid()
    }
    
    func test_cellWithThreeLivedNeighbors_lives() {
        
        // GIVEN
        sut.changeStateOfCellAt(position: (x:0, y: 3), to: .alive)
        sut.changeStateOfCellAt(position: (x:0, y: 4), to: .alive)
        sut.changeStateOfCellAt(position: (x:0, y: 5), to: .alive)
        sut.changeStateOfCellAt(position: (x:1, y: 4), to: .alive)

        sut.printGrid()

        // WHEN
        sut.computeNextGeneration()

        let cell = sut.getCell(at: (x: 1, y: 4))

        // THEN
        XCTAssertEqual(cell?.state, .alive)

        sut.printGrid()
    }
}
