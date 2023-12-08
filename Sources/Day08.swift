//
//  File.swift
//
//
//  Created by Matt Korus on 12/6/23.
//

import Algorithms
import Foundation

struct Day08: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    var turns: [Int] {
        return Array(data.lines[0]).map{$0=="L" ? 0 : 1}
    }
  // Splits input data into its component parts and convert from string.

  // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
      let map = buildMap()
      var loc = "AAA"
        var totalTurns = 0
        while loc != "ZZZ" {
            for turn in turns {
                loc = map[loc]![turn]
                totalTurns += 1
                if loc == "ZZZ" {
                    break
                }
            }
        }
    // Calculate the sum of the first set of input data
      return totalTurns
    }

  // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let map = buildMap()
        var ret = 0
        var locations = map.keys.filter { $0.last == "A"}
        var pathLengths: [Int] = []
        for loc in locations {
            var totalTurns = 0
            var location = loc
            while location.last != "Z" {
                for turn in turns  {
                    location = map[location]![turn]
                    totalTurns += 1
                    if location.last == "Z" {
                        break
                    }
                }
            }
            pathLengths.append(totalTurns)
        }

        return lcm(of: pathLengths)
  }
    
    
    func buildMap() -> [String:[String]]{
        var map: [String:[String]] = [:]
        for i in 1..<data.lines.count { // first line is directions, second is blank
            let components = data.lines[i].components(separatedBy: " = ")
            let key = components[0]
            let chars:[Character] = ["="," ","(",",",")"]
            let trimmedString = components[1].trimmingCharacters(in: CharacterSet(charactersIn: "()"))
            let arrayOfStrings = trimmedString.components(separatedBy: ", ").filter { !$0.isEmpty }
            map[key] = arrayOfStrings
        }
     //   print(map)
        return map
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        return b == 0 ? a : gcd(b, a % b)
    }

    func lcm(_ a: Int, _ b: Int) -> Int {
        return a / gcd(a, b) * b
    }

    func lcm(of numbers: [Int]) -> Int {
        return numbers.reduce(1) { (currentLcm, number) in
            lcm(currentLcm, number)
        }
    }
}
