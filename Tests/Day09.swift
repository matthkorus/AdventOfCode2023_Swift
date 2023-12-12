//
//  File.swift
//
//
//  Created by Matt Korus on 12/7/23.
//

import XCTest
@testable import AdventOfCode

final class Day09Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    
    // race Time/Distance to beat where each second button is held = 1 mm/ms acceleration later on
    let testData1 = """
    8 23 43 64 87 126 230 542 1426 3703 9058 20729 44688 91697 180910 346222 647728 1193456 2183213 4001351 7416521
    """
    
    let testData2 = """

    """
    
    func testPart1() throws {
        let challenge = Day09(data: testData1)
        XCTAssertEqual(String(describing: challenge.part1()), "14007565")
    }
    
//    func testPart2() throws {
//        let challenge = Day09(data: testData2)
//        XCTAssertEqual(String(describing: challenge.part2()), "6")
//    }
}
