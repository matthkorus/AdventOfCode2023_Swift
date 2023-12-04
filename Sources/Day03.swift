//
//  File.swift
//
//
//  Created by Matt Korus on 12/2/23.
//

import Foundation
import Algorithms

struct Day03: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        var sum = 0
        
        let grid = data.lines.map{Array($0)}
        for y in 0..<grid.count {
            if !grid[y].isEmpty { // handle a weird case where a bonus line was added to the data
                var x: Int = 0
                while x<grid[y].count-1 {
                    if grid.at(x,y).isNumber {
                        var num = String(grid.at(x,y))
                        var nx = x + 1
                        while grid.at(nx,y).isNumber{
                            num += String(grid.at(nx,y)) // build out the whole number
                            if nx+1<grid[y].count {
                                nx += 1
                            } else { break }
                        }
                        if isAdjacentToSymbol(x, nx-1),let iNum = Int(num) {
                            sum += iNum
                            //     print(iNum)
                        }
                        x = nx - 1
                        
                    }
                    x += 1
                }
            }
            
            func isAdjacentToSymbol(_ st:Int,_ en:Int) -> Bool {
                let range = Range((st>0 ? st-1 : st)...(grid[y].count-2>en ? en+1 : en))
                if y > 0 {
                    for char in grid[y-1][range] {
                        if !char.isNumber,!char.isLetter,char != "." {
                            return true
                        }
                    }
                }
                for char in grid[y][range] {
                    if !char.isNumber,!char.isLetter,char != "." {
                        return true
                    }
                }
                if y < grid.count - 2 { // need to account for the 0 index here and then add head room
                    for char in grid[y+1][range] {
                        if !char.isNumber,!char.isLetter,char != "." {
                            //           print(true)
                            return true
                        }
                    }
                }
                return false
            }
        }
        return sum
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var sum = 0
        let grid = data.lines.map{Array($0)}
        for y in 0..<grid.count {
            if !grid[y].isEmpty { // handle a weird case where a bonus line was added to the data
                var x: Int = 0
                while x<grid[y].count-1 {
                    if grid.at(x,y) == "*" {
                        if adjacentNumbers(x).count >= 2 {
                            print(adjacentNumbers(x))
                            print(adjacentNumbers(x).reduce(1,*))
                            sum += adjacentNumbers(x).reduce(1,*)
                        }
                    }
                    x += 1
                }
            }
            
            func adjacentNumbers(_ x: Int) -> [Int] {
                var ret = [Int]()
                let range = Range((x>0 ? x-1 : x)...(grid[y].count-2>x ? x+1 : x))
                if y > 0 {
                    findNumberString(y-1)
                }
                
                findNumberString(y)
                
                if y < grid.count - 2 { // need to account for the 0 index here and then add head room
                    findNumberString(y+1)
                }
                
                
                // need to fix the implementation of this, can lead to numbers populating twice if they align in x with the *
                func findNumberString(_ y:Int) {
                    var x = range.lowerBound
                    while x<=range .upperBound {
                        if grid.at(x,y).isNumber {
                            var num = String(grid.at(x,y))
                            var j = 1
                            while grid.at(x-j,y).isNumber {
                                num = String(grid.at(x-j,y)) + num
                                if x-(j+1)>=0 {
                                    j += 1
                                } else { break }
                            }
                            var k = 1
                            while grid.at(x+k,y).isNumber {
                                num += String(grid.at(x+k,y))
                                if x+k+1 <= grid[y].count-1 {
                                    k += 1
                                } else { break }
                            }
                            if let iNum = Int(num) {
                                ret.append(iNum)
                            }
                        }
                        x += 1
                    }
                }
                return ret
            }
        }
        return sum
    }
}

fileprivate
extension Array where Element == [Character] {
    // this just makes it so that we notate grid locations in (x,y) which will make more sense as we nest deeper
    func at(_ x:Int,_ y:Int) -> Character {
        //   [print(x," ",y)]
        return self[y][x]
    }
}
