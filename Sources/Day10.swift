//
//  File.swift
//
//
//  Created by Matt Korus on 12/6/23.
//

import Algorithms
import Foundation

struct Day10: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    var gridCalc: [[String]] {
        return data.lines.map{Array($0).map(String.init)}
    }
    
    // Splits input data into its component parts and convert from string.
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        var count = 0
        let grid = gridCalc
        let startY = data.lines.firstIndex(where: {$0.contains("S")})!
        let startX = grid[startY].firstIndex(of: "S")!
        var sY = startY, sX = startX, pX = startX, pY = startY
        while findMove(ci: sX, cj: sY, pi: pX, pj: pY,grid:grid) != (startY,startX) {
            let newPosition = findMove(ci: sX, cj: sY, pi: pX, pj: pY,grid:grid)
            (pX,pY) = (sX,sY)
            (sY,sX) = newPosition
            count += 1
        }
        count += 1
        return count/2
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        // Pick's Thereom
        // A = i - b/2 - 1
        // we get b/2 from part one, can use Shoelace formula to get A, i is what we want.
        let grid = gridCalc
        let startY = data.lines.firstIndex(where: {$0.contains("S")})!
        let startX = grid[startY].firstIndex(of: "S")!
        var points = [(Int,Int)]()
        var sY = startY, sX = startX, pX = startX, pY = startY
        points.append((sX,sY))
        while findMove(ci: sX, cj: sY, pi: pX, pj: pY,grid:grid) != (startY,startX) {
            let newPosition = findMove(ci: sX, cj: sY, pi: pX, pj: pY,grid:grid)
            (pX,pY) = (sX,sY)
            (sY,sX) = newPosition
            points.append((sX,sY))
        }
        let newPosition = findMove(ci: sX, cj: sY, pi: pX, pj: pY,grid:grid)
        (sY,sX) = newPosition
        points.append((sX,sY))
        let b = points.count
        // add starting position back in to make full loop
        var sum = 0
        for i in 0..<points.count-1 {
            let j = i+1 // restart from beginning if we reach the last one
            sum += (points[i].0*points[j].1)
            sum -= (points[j].0*points[i].1)
        }
        let A = abs(sum)/2
        print(A)
        return A - (b/2) - 1
    }
    
    func findMove(ci:Int,cj:Int,pi:Int,pj:Int,grid:[[String]]) -> (Int,Int) {
        if grid[cj][ci] == "|" {
            if pj<cj {
                return (cj+1,ci)
            }
            else {
                return (cj-1,ci)
            }
        }
        else if grid[cj][ci] == "-" {
            if pi<ci {
                return (cj,ci+1)
            }
            else {
                return (cj,ci-1)
            }
        }
        else if grid[cj][ci] == "F" {
            if pj>cj {
                return (cj,ci+1)
            } else {
                return (cj+1,ci)
            }
        }
        else if grid[cj][ci] == "L" {
            if pj<cj {
                return (cj,ci+1)
            } else {
                return (cj-1,ci)
            }
            
        }
        else if grid[cj][ci] == "J" {
            if pj<cj {
                return (cj,ci-1)
            } else {
                return (cj-1,ci)
            }
        }
        else if grid[cj][ci] == "7" {
            if pj>cj {
                return (cj,ci-1)
            } else {
                return (cj+1,ci)
            }
        }
        else if grid[cj][ci] == "S" {
            return findInitialMove(ci: ci, cj: cj, pi: pi, pj: pj,grid:grid)
        }
        else {
            return (cj,ci)
        }
    }
    
    func findInitialMove(ci:Int,cj:Int,pi:Int,pj:Int,grid:[[String]]) -> (Int,Int) { // make this y,x
        let past = (pj,pi)
        let north = (cj-1,ci)
        let south = (cj+1,ci)
        let east = (cj,ci+1)
        let west = (cj,ci-1)
        if north.0 >= 0{
            if grid[north.0][north.1] == "F" && north != past {
                return north
            }
            if grid[north.0][north.1] == "7" && north != past {
                return north
            }
            if grid[north.0][north.1] == "|" && north != past {
                return north
            }
        }
        if south.0 < grid.count {
            if grid[south.0][south.1] == "|" && south != past {
                return south
            }
            if grid[south.0][south.1] == "J" && south != past {
                return south
            }
            if grid[south.0][south.1] == "L" && south != past {
                return south
            }
        }
        if east.1 < grid[cj].count {
            if grid[east.0][east.1] == "-" && east != past {
                return east
            }
            if grid[east.0][east.1] == "7" && east != past {
                return east
            }
            if grid[east.0][east.1] == "J" && east != past {
                return east
            }
        }
        if  west.1 >= 0 {
            if grid[west.0][west.1] == "-" && west != past {
                return west
            }
            if grid[west.0][west.1] == "F" && west != past {
                return west
            }
            if grid[west.0][west.1] == "L" && west != past {
                return west
            }
        }
        return past
    }
}

