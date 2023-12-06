//
//  File.swift
//  
//
//  Created by Matt Korus on 12/6/23.
//

import Foundation
import Algorithms

struct Day06: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        var races: [Race] = []
        let times = data.lines[0].components(separatedBy: "Time:")[1].components(separatedBy: .whitespacesAndNewlines).compactMap({Int($0)})
        let records = data.lines[1].components(separatedBy: "Distance:")[1].components(separatedBy: .whitespacesAndNewlines).compactMap({Int($0)})
        
        for i in 0..<times.count {
            for j in 0..<times[i] {
                races.append(Race(totalTime: times[i], record: records[i], buttonHoldTime: j))
            }
        }
        var winCount:[Int] = []
        for time in times {
            winCount.append(races.filter{$0.totalTime==time}.reduce(0){$0 + ($1.beatsRecord ? 1 : 0)})
        }
        return winCount.reduce(1,*)
    }
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let time:Int64 = Int64(data.lines[0].components(separatedBy: "Time:")[1].components(separatedBy: .whitespacesAndNewlines).compactMap({$0}).joined())!
        let record:Int64 = Int64(data.lines[1].components(separatedBy: "Distance:")[1].components(separatedBy: .whitespacesAndNewlines).compactMap({$0}).joined())!
        var buttonTime:Int64 = 0
        let chunks:[Int64] = [1000,100,10,1]
        for d in chunks {
            while distance(bt: buttonTime+d, tt: time) <= Double(record) {
                buttonTime += d
            }
        }
        return time - (buttonTime*2+1)
    }
    
    func distance(bt:Int64,tt:Int64) -> Double {
        return Double((tt-bt)*bt)
    }
}

struct Race {
    let totalTime: Int
    let record: Int
    let buttonHoldTime: Int
    
    var beatsRecord: Bool {
        return distance > record
    }
    
    var distance: Int {
        // where button hold time = velocity given the 1mm/ms
        return (totalTime-buttonHoldTime) * buttonHoldTime
    }
}
