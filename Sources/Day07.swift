//
//  File.swift
//  
//
//  Created by Matt Korus on 12/7/23.
//

import Foundation

//
//  File.swift
//
//
//  Created by Matt Korus on 12/6/23.
//

import Foundation
import Algorithms

struct Day07: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    func part1() -> Any {
        let hands = data.lines.map{$0.components(separatedBy: .whitespaces)}.sorted{compareHands($0,$1)}
        // creates array [[String]] where [[String]][i] is the line and [[String]][i][j] is the hand value
        // we can do count - index to get rank since rank 1 is the worst
        return hands.reduce(0) { p,hand in
            if let index = hands.firstIndex(of: hand),let bid = Int(hand.bid()) {
           //     print(bid," ",hands.count-index)
                return p + (bid * (hands.count - index))
            } else { return p}
        }
    }
    
    func part2() -> Any {
        let hands = data.lines.map{$0.components(separatedBy: .whitespaces)}.sorted{compareHands2($0,$1)}
        return hands.reduce(0) { p,hand in
            if let index = hands.firstIndex(of: hand),let bid = Int(hand.bid()) {
           //     print(bid," ",hands.count-index)
                return p + (bid * (hands.count - index))
            } else { return p}
        }
    }
    func compareHands(_ hand1:[String],_ hand2:[String]) -> Bool  {// true if hand 1 is higher
        if HandType.find1(hand1.cards()) == HandType.find1(hand2.cards()) {
            let cards1 = Array(hand1.cards()), cards2 = Array(hand2.cards())
            for i in 0..<cards1.count {
                if cards1[i] != cards2[i] {
                    return cardValue(cards1[i]) > cardValue(cards2[i])
                }
            }
            return false // this is an error
        } else {
            return HandType.find1(hand1.cards()).rawValue > HandType.find1(hand2.cards()).rawValue
        }
    }
    func compareHands2(_ hand1:[String],_ hand2:[String]) -> Bool  {// true if hand 1 is higher
        if HandType.find2(hand1.cards()) == HandType.find2(hand2.cards()) {
        //    print("\(hand1.cards()) [\(HandType.find2(hand1.cards()))] is equal to \(hand2.cards()) [\(HandType.find2(hand2.cards()))]")
            let cards1 = Array(hand1.cards()), cards2 = Array(hand2.cards())
            for i in 0..<cards1.count {
                if cards1[i] != cards2[i] {
            //        print("\(cards1[i])  vs \(cards2[i])")
            //        print(cardValue2(cards1[i]) > cardValue2(cards2[i]))
                    return cardValue2(cards1[i]) > cardValue2(cards2[i])
                }
            }
            return false // this is an error
        } else {
           // print("\(hand1.cards()) [\(HandType.find2(hand1.cards()))] vs \(hand2.cards()) [\(HandType.find2(hand2.cards()))] = \(HandType.find2(hand1.cards()).rawValue > HandType.find2(hand2.cards()).rawValue)")
            return HandType.find2(hand1.cards()).rawValue > HandType.find2(hand2.cards()).rawValue
        }
    }
    
    func cardValue(_ card: Character, part2: Bool=false) -> Int {
        if let num = Int(String(card)) {
            return num
        }
        if card == "A" { return 14 }
        if card == "K" { return 13 }
        if card == "Q" { return 12 }
        if card == "J" { return part2 ? 1 : 11 }
        if card == "T" { return 10 }
        return 2
    }
    func cardValue2(_ card: Character) -> Int {
        if let num = Int(String(card)) {
            return num
        }
        if card == "A" { return 14 }
        if card == "K" { return 13 }
        if card == "Q" { return 12 }
        if card == "J" { return 1 }
        if card == "T" { return 10 }
        return 2
    }
}

fileprivate extension Array where Element == String {
    func cards() -> String {
        self.first!
    }
    func bid() -> String {
        self.last!
    }
}

enum HandType: Int {
    case fiveOfAKind = 6
    case fourOfAKind = 5
    case fullHouse = 4
    case threeOfAKind = 3
    case twoPair = 2
    case onePair = 1
    case highCard = 0
    
    static func find1(_ cards:String) -> HandType {
        let counts = Array(cards).uniqued().map{ card in
            return cards.filter { $0 == card }.count
        }
        if counts.contains(5) {
            return .fiveOfAKind
        }
        else if counts.contains(4) {
            return .fourOfAKind
        }
        else if counts.contains(3),counts.contains(2) {
            return .fullHouse
        }
        else if counts.contains(3) {
            return .threeOfAKind
        }
        else if counts.filter({ $0 == 2 }).count == 2 {
            return .twoPair
        }
        else if counts.contains(2) {
            return .onePair
        }
        else {
            return .highCard
        }
    }
    static func find2(_ cards:String) -> HandType {
      //  print(cards)
        let jokers = Array(cards).filter {$0 == "J"}.count
        var fCards = cards
        fCards.removeAll(where: {$0 == "J"})
        let counts = Array(fCards).uniqued().map{ card in
            return cards.filter { $0 == card }.count
        }
//        if cards == "T55JT" {
 //           print(counts," ",jokers)
 //       }
      //  print(counts)
      //  print(counts.filter({ $0 == 2 }).count )
        if counts.contains(5-jokers) {
            return .fiveOfAKind
        }
        else if jokers == 5 {
            return.fiveOfAKind
        }
        else if counts.contains(4-jokers) {
            return .fourOfAKind
        }
        else if jokers == 4 {
            return .fourOfAKind
        }
        else if counts.contains(2),counts.contains(3) {
            return .fullHouse
        }
        else if 3-jokers==2,counts.filter({ $0 == 2 }).count == 2 {
            return .fullHouse
        }
        else if counts.contains(2),jokers==2 {
            return .fullHouse
        }
        else if counts.contains(3),jokers>0 {
            return .fullHouse
        }
        else if counts.contains(3-jokers) {
            return .threeOfAKind
        }
        else if jokers == 3 {
            return .threeOfAKind
        }
        else if counts.filter({ $0 == 2 }).count == 2 {
            return .twoPair
        }
        else if counts.contains(2),jokers>0 {
            return .twoPair
        }
        else if counts.contains(2-jokers) {
            return .onePair
        }
        else if jokers == 2 {
            return .onePair
        }
        else {
            return .highCard
        }
    }
}

