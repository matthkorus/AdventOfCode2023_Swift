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
    -L|F7
    7S-7|
    L|7||
    -L-J|
    L|-JF
    """
    
    let testData2 = """
    FF7FSF7F7F7F7F7F---7
    L|LJ||||||||||||F--J
    FL-7LJLJ||||||LJL-77
    F--JF--7||LJLJ7F7FJ-
    L---JF-JLJ.||-FJLJJ7
    |F|F-JF---7F7-L7L|7|
    |FFJF7L7F-JF7|JL---7
    7-L-JL7||F7|L7F-7F7|
    L.L7LFJ|||||FJL7||LJ
    L7JLJL-JLJLJL--JLJ.L
    """
    
    func testPart1() throws {
        let challenge = Day10(data: testData1)
        XCTAssertEqual(String(describing: challenge.part1()), "4")
    }
    
    func testPart2() throws {
        let challenge = Day10(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "10")
    }
}
