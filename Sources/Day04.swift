//
//  File.swift
//
//
//  Created by Matt Korus on 12/2/23.
//

import Foundation
import Algorithms

struct Day04: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        data.lines.reduce(0) {
            let segments = $1.split(separator: ":")[1].split(separator: "|").map{$0.split(separator: " ")}
            let matches = segments[1].reduce(0) { return segments[0].contains($1) ? $0 + 1 : $0}
            return matches > 0 ? $0 + Int((pow(2.0,(Double(matches-1))))) : $0
            }
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var cc = Array(repeating: CardCounter(), count: data.lines.count)
        for i in 0..<data.lines.count {
                cc[i].populate(data.lines[i].split(separator: ":")[1].split(separator: "|").map{$0.split(separator: " ")})
                if cc[i].matches() > 0 {
                    for j in 1...cc[i].matches() {
                        cc[i+j].c += 1 * cc[i].c
                    }
                }
        }
        return cc.reduce(0){ $0 + $1.c }
    }
}

fileprivate
struct CardCounter {
    var c = 1 // always start with one copy
    var wN = [String]()
    var n = [String]()
    
    mutating func populate(_ segments: [[Substring]]) {
        self.wN = segments[0].map{String($0)}; self.n = segments[1].map{String($0)}
    }
    func matches() -> Int {n.reduce(0) {return wN.contains($1) ? $0 + 1 : $0}}
}
