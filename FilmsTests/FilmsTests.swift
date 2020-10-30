//
//  FilmsTests.swift
//  FilmsTests
//
//  Created by Javier Fernández on 30/10/2020.
//

import XCTest
@testable import Films

class FilmsTests: XCTestCase {

    var scoresData: ScoresData!
    
    override func setUpWithError() throws {
        scoresData = ScoresData()
    }

    override func tearDownWithError() throws {
       scoresData = nil
    }
    
    /// Test para ver que nuestro scores tiene los mismos registros que el archivo JSON
    func testScoresDataJSON() {
        XCTAssert(!scoresData.scores.isEmpty)
        XCTAssertEqual(scoresData.scores.count, 72)
    }

}
