//
//  File.swift
//
//
//  Created by Matt Korus on 12/4/23.
//

import Foundation
import Algorithms

struct Day05: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        // there's something wrong here, redirected to alternate approach
        return data.components(separatedBy: "seeds:")[1].components(separatedBy: .letters)[0].components(separatedBy: .whitespacesAndNewlines).compactMap { Int($0) }.compactMap {
            var val = $0
            for mapName in AlmanacMaps.allCases {
                let map = data.findMapFor(mapName.rawValue)
                val = map.convert(val)
            }
            return val
        }.min() ?? 0
    }
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        // lets pre-build our maps first to help with performance later on
        var maps = [String:[[Int]]]()
        for map in AlmanacMaps.allCases {
            maps[map.rawValue] = data.findMapFor(map.rawValue)
        }
        
        var seedMap = data.components(separatedBy: "seeds:")[1].components(separatedBy: .letters)[0].components(separatedBy: .whitespacesAndNewlines).compactMap { Int($0) }.chunks(ofCount: 2)
        
        // where first index in the chunk is start # and second is the range on top of it (including the initial num)
        var min = 999999999999999
        for sr in seedMap {
            print(sr)
       //     print(sr)
            let start = sr[sr.startIndex]
            let range = sr[sr.endIndex-1]
            // this will give us the seed within a random sample of seeds in our range that is the lowest
            var sample = [Int]()
            for _ in 1...500 {
                sample.append(start + Int((Double(range)*Double.random(in:0...1)).rounded()))
            }
            
            var approxMin = sample.min {seedToLocation($0) < seedToLocation($1)}!
            
            for d in [100000000,10000000,1000000,100000,10000,1000,100,10,1] {
                // iterate up
                while (approxMin+d) < start+range,seedToLocation(approxMin) >= seedToLocation(approxMin+d) {
                    approxMin += d
                }
                // iterate down
                while (approxMin-d) >= start ,seedToLocation(approxMin) >= seedToLocation(approxMin-d) {
                    approxMin -= d
                }
                if seedToLocation(approxMin) < seedToLocation(min) {
           //         print("new Low: \(approxMin) for value: \(seedToLocation(approxMin))")
                    min = approxMin
                }
            }
        }
     //   print("final pic: \(min)")
        return part2Alternate()//seedToLocation(min)
        
        func seedToLocation(_ seed:Int) ->Int {
            var val = seed
            for name in AlmanacMaps.allCases {
                val = maps[name.rawValue]!.convert(val)
            }
            return val
        }
    }
    
    func part2Alternate() -> Int{
        var maps = [String:[[Int]]]()
        for map in AlmanacMaps.allCases {
            maps[map.rawValue] = data.findMapFor(map.rawValue)
        }
        let seedMap = data.components(separatedBy: "seeds:")[1].components(separatedBy: .letters)[0].components(separatedBy: .whitespacesAndNewlines).compactMap { Int($0) }.chunks(ofCount: 2)
        
        var location = 0
        var found = false
        while !found {
            let seed = locationToSeed(location)
            if seedExists(seed) {
                found = true
                print(seed)
            } else {
                location+=1
            }
        }
        return location
        
        func locationToSeed(_ loc: Int) -> Int {
            var val = loc
            for name in AlmanacMaps.allCases.reversed() {
                val = maps[name.rawValue]!.reverseConvert(val)
            }
            return val
        }
        func seedExists(_ seed:Int) -> Bool {
            for sr in seedMap {
                let start = sr[sr.startIndex]
                let range = sr[sr.endIndex-1]
                let end = start + range - 1
                if seed >= start, seed <= end {
                    return true
                }
            }
            return false
        }
    }
}

extension String {
    func findMapFor(_ str: String) -> [[Int]]{
        return self.components(separatedBy: str)[1].components(separatedBy: .letters)[0].lines.map {
            $0.components(separatedBy: .whitespacesAndNewlines).compactMap{Int($0)}
        }
    }
}

enum AlmanacMaps: String, CaseIterable {
    case seedToSoil = "seed-to-soil map:"
    case soilToFertilizer = "soil-to-fertilizer map:"
    case fertilizerToWater = "fertilizer-to-water map:"
    case waterToLight = "water-to-light map:"
    case lightToTemperature = "light-to-temperature map:"
    case temperatureToHumidity = "temperature-to-humidity map:"
    case humidityToLocation = "humidity-to-location map:"
}

fileprivate
extension Array where Element == [Int] {
    // this just makes it so that we notate grid locations in (x,y) which will make more sense as we nest deeper
    func convert(_ val:Int) -> Int {
        for line in self {
            if val >= line[1], val <= line[1]+line[2] {
                let offset = val - line[1]
                return line[0] + offset
            }
        }
        return val
    }
    func reverseConvert(_ val:Int) -> Int {
        for line in self {
            if val >= line[0], val <= line[2]+line[0] {
                let offset = val - line[0]
                return line[1] + offset
            }
        }
        return val
    }
}

