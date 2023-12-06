//
//  File.swift
//  
//
//  Created by Matt Korus on 12/6/23.
//
import XCTest
@testable import AdventOfCode

final class Day06Tests: XCTestCase {
  // Smoke test data provided in the challenge question

    // race Time/Distance to beat where each second button is held = 1 mm/ms acceleration later on
    let testData1 = """
    Time:      7  15   30
    Distance:  9  40  200
    """

  func testPart1() throws {
    let challenge = Day06(data: testData1)
    XCTAssertEqual(String(describing: challenge.part1()), "288")
  }

  func testPart2() throws {
    let challenge = Day06(data: testData1)
    XCTAssertEqual(String(describing: challenge.part2()), "71503")
  }
}
