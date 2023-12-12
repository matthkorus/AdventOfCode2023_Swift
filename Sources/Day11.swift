//
//  File.swift
//
//
//  Created by Matt Korus on 12/6/23.
//

import Algorithms
import Foundation

struct Day11: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
    var data: String

  // Splits input data into its component parts and convert from string.

  // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let galaxyMap = getExpandedGalaxyMap(99)
        let coords = getCoordinateArray(galaxyMap)
        var sum = 0
        let pairs = coords.permutations(ofCount: 2)
        for pair in pairs {
        //    print("pre-test")
            sum += getShortestDistance(pair[0], pair[1])
        //    print("test")
        }
        func getShortestDistance(_ p1:Position,_ p2:Position) -> Int {
       //     print("in here")
            return abs(p1.x-p2.x) + abs(p1.y-p2.y)
        }
        return sum/2 // since permuattions doubles what we want here
    }

  // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let galaxyMap = getExpandedGalaxyMap(999999) // a million times bigger but we're starting at 1

        let coords = getCoordinateArray(galaxyMap)
        var sum = 0
        let pairs = coords.permutations(ofCount: 2)
        for pair in pairs {
        //    print("pre-test")
            sum += getShortestDistance(pair[0], pair[1])
        //    print("test")
        }
        func getShortestDistance(_ p1:Position,_ p2:Position) -> Int {
       //     print("in here")
            return abs(p1.x-p2.x) + abs(p1.y-p2.y)
        }
        return sum/2 // since permuattions doubles what we want here
  }
    func getExpandedGalaxyMap(_ xc: Int) -> [[(Int,Int)]] {
        let grid = data.lines.map{Array($0).map(String.init)}
        var oGrid = [[(Int,Int)]]()
        for _ in 0..<grid.count {
            oGrid.append(Array(repeating: (0,0), count: grid[0].count))
        }
        var i = 0
        var yOffset = 0
        while i<grid.count {
            if !grid[i].contains(where: {$0.contains("#")}) {
                yOffset += xc
            }
            for j in 0..<grid[i].count {
                oGrid[i][j].1 = yOffset
            }
            i += 1
        }
        var j = 0
        var xOffset = 0
        while j < grid[0].count {
            var found = false
            for i in 0..<grid.count {
                if grid[i][j] != "." {
                    found = true
                }
            }
            if !found {
                xOffset += xc
            }
                for i in 0..<grid.count {
                    oGrid[i][j].0 = xOffset
            }
            j+=1
        }
        return oGrid
    }
    func getCoordinateArray(_ map:[[(Int,Int)]]) -> [Position] {
        var grid = data.lines.map{Array($0).map(String.init)}
        var coords: [Position] = []
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                if grid[i][j] == "#" {
                    let xMap = map[i][j].0
                    let yMap = map[i][j].1
                    coords.append(Position(x: j+xMap, y: i+yMap))
                }
            }
        }
        return coords
    }

}

struct Position: Hashable {
    let id = UUID().uuidString
    let x: Int
    let y: Int
}
