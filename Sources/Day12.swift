import Algorithms

fileprivate
var memo: [String:Int] = [:]

struct Day12: AdventDay {
    init(data: String) {
        self.data = data
    }
    
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        solve()
    }
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        solve(5)
    }
    
    func solve(_ copies:Int=1 ) -> Any {
        var answer = 0
        for line in data.lines {
            let patternArray = Array(repeating: String(line.pattern), count: copies)
            let joinedPattern = patternArray.joined(separator: "?")
            let numbers:[Int] = Array(repeating:line.numbers,count:copies).flatMap {$0}
            answer += countMatches(joinedPattern, size: joinedPattern.count, splits: numbers)
            print(answer)
        }
        return answer
    }
    
    
    
    func countMatches(_ str:String, size: Int, splits: [Int]) -> Int {
        let memoKey = "\(str)-\(size)-\(splits)"
        if let cachedResult = memo[memoKey] {
            return cachedResult
        }
        if splits.count == 0 {
            if str.allSatisfy({ $0 == "." || $0 == "?" }) {
                memo[memoKey] = 1
                return 1
            }
            memo[memoKey] = 0
            return 0
        }
        let a = splits[0]
        let rest:[Int] = Array(splits.dropFirst())
        let after = rest.reduce(0,+) + rest.count
        
        var count = 0
        
        for before in 0..<(size-after-a+1) {
            let cand = String(repeating:".",count:before) + String(repeating:"#",count:a) + (rest.isEmpty ? "" : ".")
            // Check if all pairs of characters match (c0 from pattern and c1 from cand)
            if zip(str, cand).allSatisfy({ c0, c1 in c0 == c1 || c0 == "?" }) {
                // If all pairs match, call countMatches recursively and add to the count
                let startIndex = str.index(str.startIndex, offsetBy: cand.count)
                let remainingPattern = String(str[startIndex...])
                count += countMatches(remainingPattern, size: size - a - before - 1, splits: rest)
            }
        }
        // Return the count
        memo[memoKey] = count
        return count
    }
    
    func memoize<Input: Hashable, Output>(_ function: @escaping (Input) -> Output) -> (Input) -> Output {
        // our item cache
        var storage = [Input: Output]()

        // send back a new closure that does our calculation
        return { input in
            if let cached = storage[input] {
                return cached
            }

            let result = function(input)
            storage[input] = result
            return result
        }
    }
}

fileprivate extension Substring {
    var numbers : [Int] {
        self.components(separatedBy: .whitespaces)[1].components(separatedBy: ",").compactMap{Int($0)}
    }
    var pattern : String {
        self.components(separatedBy: .whitespaces)[0]
    }
}
