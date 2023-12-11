//
//  File.swift
//
//
//  Created by Matt Korus on 12/6/23.
//

import Algorithms
import Foundation

struct Day09: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
    var data: String

  // Splits input data into its component parts and convert from string.

  // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        var nextValues = [Int]()
        for line in data.lines {
            nextValues.append(nextNumInSeq(line.components(separatedBy:.whitespacesAndNewlines).compactMap({Int($0)})))
        }
        return nextValues.reduce(0,+)
    }

    func part2() -> Any {
            var nextValues = [Int]()
            for line in data.lines {
                nextValues.append(nextNumInSeq(line.components(separatedBy:.whitespacesAndNewlines).compactMap({Int($0)}).reversed()))
            }
            return nextValues.reduce(0,+)
  }
    
    func nextNumInSeq(_ s:[Int])-> Int {
        var d = [Int]()
        for n in 0..<s.count-1 { // work backwards through array
            let i = s.count - 1 - n
            let j = s.count - 2 - n
            d.append(s[i]-s[j])
        }
        d.reverse() // puts the highest difference back at the end since we had added it first initially
        return s.last! + ((d.filter{$0 != 0}.count > 0) ? nextNumInSeq(d) : 0 )
    }
}
