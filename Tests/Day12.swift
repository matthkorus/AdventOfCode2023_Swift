//
//  File.swift
//  
//
//  Created by Matt Korus on 12/12/23.
//

import Foundation
import XCTest
@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day12Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = 
    """
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
    """

  func testPart1() throws {
    let challenge = Day12(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "21")
  }

  func testPart2() throws {
    let challenge = Day12(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "525152")
  }
}
