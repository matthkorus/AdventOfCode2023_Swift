//
//  File.swift
//  
//
//  Created by Matt Korus on 12/7/23.
//

import XCTest
@testable import AdventOfCode

final class Day07Tests: XCTestCase {
  // Smoke test data provided in the challenge question

    // race Time/Distance to beat where each second button is held = 1 mm/ms acceleration later on
    let testData1 = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

  func testPart1() throws {
    let challenge = Day07(data: testData1)
    XCTAssertEqual(String(describing: challenge.part1()), "6440")
  }

  func testPart2() throws {
    let challenge = Day07(data: testData1)
    XCTAssertEqual(String(describing: challenge.part2()), "5905")
  }
}
