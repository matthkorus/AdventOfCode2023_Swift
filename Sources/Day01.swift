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
      var partialResult = 0
      for line in data.lines {
          let line = String(line)
          partialResult += Int(firstNumber(line) + lastNumber(line)) ?? 0
      }
      return partialResult
  }
}

func firstNumber(_ str:String) -> String {
    let fw = str.firstWordIndexandNumber()
    let fn = str.firstNumberAndIndex()
    if fw.0 ?? 99 < fn.0 ?? 99{
        if let int = fw.1 {
            return String(int)
        } else {
            return ""
        }
    } else {
        if let int = fn.1 {
            return String(int)
        } else {
            return ""
        }
    }
}
func lastNumber(_ str:String) -> String {
    let lw = str.lastWordIndexandNumber()
    let ln = str.lastNumberAndIndex()
    if lw.0 ?? 0 > ln.0 ?? 0{
        if let int = lw.1 {
            return String(int)
        } else {
            return ""
        }
    } else {
        if let int = ln.1 {
            return String(int)
        } else {
            return ""
        }
    }
}

extension StringProtocol {
    var lines: [SubSequence] { split(whereSeparator: \.isNewline)}
    

    
    func lastWordIndexandNumber() -> (Int?,Int?) {
        var lastIndex: Int?
        var lastWordValue: Int?
        let numbers = [
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine"]
        for number in numbers {
            if let range: Range<String.Index> = self.range(of: number,options:.backwards) {
                let index: Int = self.distance(from: self.startIndex, to: range.lowerBound)
                if index>lastIndex ?? 0 {
                    lastIndex = index
                    lastWordValue = wordToDigit(number)
                }
                
            }
        }
        return (lastIndex,lastWordValue)
    }
    
    func firstWordIndexandNumber() -> (Int?,Int?) {
        var firstIndex: Int?
        var firstWordValue: Int?
        let numbers = [
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine"]
        for number in numbers {
            if let range: Range<String.Index> = self.range(of: number) {
                let index: Int = self.distance(from: self.startIndex, to: range.lowerBound)
                if index<firstIndex ?? 100 {
                    firstIndex = index
                    firstWordValue = wordToDigit(number)
                }
                
            }
        }
        return (firstIndex,firstWordValue)
    }
    
    func wordToDigit(_ string:String) -> Int {
        switch string {
        case "one" : return 1
        case "two" : return 2
        case "three" : return 3
        case "four" : return 4
        case "five" : return 5
        case "six" : return 6
        case "seven" : return 7
        case "eight" : return 8
        case "nine" : return 9
        default : return 0
        }
    }
    
    func firstNumberAndIndex() -> (Int?,Int?) {
        if let d1 = self.first(where:{$0.isNumber}), let ind = self.firstIndex(where: {$0.isNumber}){
            return (self.distance(to: ind),Int(String(d1)))
        } else {
            return (nil,nil)
        }
    }
    func lastNumberAndIndex() -> (Int?,Int?) {
        if let ind = self.lastIndex(where:{$0.isNumber}),let d1 = self.last(where:{$0.isNumber}) {
            return (self.distance(to: ind),Int(String(d1)))
        } else {
            return (nil,nil)
        }
    }
}

extension StringProtocol {
    func distance(of element: Element) -> Int? { firstIndex(of: element)?.distance(in: self) }
    func distance<S: StringProtocol>(of string: S) -> Int? { range(of: string)?.lowerBound.distance(in: self) }
}
extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}
extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int { string.distance(to: self) }
}
