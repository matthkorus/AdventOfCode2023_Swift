//
//  File.swift
//  
//
//  Created by Matt Korus on 12/1/23.
//

import Foundation
import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

    
  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
      var partialResult = 0
      for line in data.lines {
          if let d1 = line.first(where: {$0.isNumber}),
          let d2 = line.last(where: {$0.isNumber}) {
              partialResult += Int(String(d1) + String(d2)) ?? 0
          }
      }
      return partialResult
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Sum the maximum entries in each set of data
    "Not applicable"
  }
}

extension StringProtocol {
    var lines: [SubSequence] { split(whereSeparator: \.isNewline) }
}
