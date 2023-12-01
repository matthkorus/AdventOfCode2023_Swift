//
//  File.swift
//  
//
//  Created by Matt Korus on 12/1/23.
//

import Foundation

import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day01Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData2 = """
    9twobfknine57sixfour7
    fourthreeseven1grvhrjxklh3ninetwothree
    """
    
    let testData1 = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

  func testPart1() throws {
    let challenge = Day01(data: testData1)
    XCTAssertEqual(String(describing: challenge.part1()), "142")
  }

  func testPart2() throws {
    let challenge = Day01(data: testData2)
    XCTAssertEqual(String(describing: challenge.part2()), "140")
  }
}
