//
//  File.swift
//
//
//  Created by Matt Korus on 12/7/23.
//

import XCTest
@testable import AdventOfCode

final class Day10Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    
    // race Time/Distance to beat where each second button is held = 1 mm/ms acceleration later on
    let testData1 = """

    """
    
    let testData2 = """

    """
    
    func testPart1() throws {
        let challenge = Day10(data: testData1)
        XCTAssertEqual(String(describing: challenge.part1()), "2")
    }
    
    func testPart2() throws {
        let challenge = Day10(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "6")
    }
}
