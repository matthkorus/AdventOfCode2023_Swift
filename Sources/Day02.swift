//
//  File.swift
//  
//
//  Created by Matt Korus on 12/2/23.
//

import Foundation
import Algorithms

struct Day02: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    let r = 12
    let g = 13
    let b = 14
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        var sum = 0
        for line in data.lines {
            let game = line.createCubeGameFromLine()
            if game.isPossible(r: r, g: g, b: b) {
                sum += game.num
            }
        }
        return sum
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        return data.lines.reduce(0) { pp, line in
            let game = line.createCubeGameFromLine()
            return pp + game.power()
        }
    }
}

extension Substring {
    fileprivate func createCubeGameFromLine() -> CubeGame {
        let parts = self.split(separator: ":")
        let num = Int(parts[0].filter("0123456789".contains))!
        var cubeRounds = [CubeRound]()
        let rounds = parts[1].split(separator: ";")
        for round in rounds {
            let draws = round.split(separator: ",")
            var r = 0,b = 0, g = 0
            for draw in draws {
                if draw.contains("red") {
                    r = Int(draw.filter("0123456789".contains)) ?? 0
                } else if draw.contains("green"){
                    g = Int(draw.filter("0123456789".contains)) ?? 0
                } else if draw.contains("blue") {
                    b = Int(draw.filter("0123456789".contains)) ?? 0
                }
            }
            cubeRounds.append(CubeRound(r: r, g: g, b: b))
        }
        return CubeGame(num: num, rounds: cubeRounds)
    }
}

struct CubeGame {
    let num: Int
    let rounds: [CubeRound]
    
    func isPossible(r:Int,g:Int,b:Int) -> Bool {
        for round in self.rounds {
            if r<round.r || g<round.g || b<round.b {
                return false
            }
        }
        return true
    }
    private func leastRed() -> Int {
        let reds = rounds.compactMap { $0.r }
        return reds.max()!
    }
    private func leastGreen() -> Int {
        let greens = rounds.compactMap { $0.g }
        return greens.max()!
    }
    private func leastBlue() -> Int {
        let blues = rounds.compactMap { $0.b }
        return blues.max()!
    }
    func power() -> Int {
        return leastRed() * leastGreen() * leastBlue()
    }
}

struct CubeRound {
    let r: Int
    let g: Int
    let b: Int
}
