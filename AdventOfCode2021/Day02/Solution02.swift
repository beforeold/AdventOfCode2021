//
//  Solution02.swift
//  01 - Sonar
//
//  Created by BrookXy on 2022/1/14.
//

import Foundation

@objc class Solution02: NSObject {
    typealias Unit = Int
    typealias Action = (MoveType, Unit)
    
    enum MoveType: String {
        case forward
        case up
        case down
    }
    
    static let actions: [Action] = Input02.split(separator: Character("\n")).map { substring -> Action in
        let components = substring.split(separator: Character(" "))
        let moveType = MoveType(rawValue: String(components.first!))!
        let value = Unit(String(components.last!))!
        return (moveType, value)
    }
    
    @objc
    static func part1() {
        struct Position {
            var horizontal: Unit
            var depth: Unit
            
            mutating func apply(_ action: (MoveType, Unit)) {
                switch action {
                case (.forward, let x):
                    horizontal += x
                    
                case (.up, let x):
                    depth -= x
                case (.down, let x):
                    depth += x
                }
            }
        }
        
        let ret = actions.reduce(Position(horizontal: 0, depth: 0)) { partialResult, action in
            var partialResult = partialResult
            partialResult.apply(action)
            return partialResult
        }
        print(ret.horizontal * ret.depth)
    }
    
    @objc
    static func part2() {
        struct Position {
            var horizontal: Unit
            var depth: Unit
            var aim: Unit
            
            mutating func apply(_ action: (MoveType, Unit)) {
                switch action {
                case (.forward, let x):
                    horizontal += x
                    depth += x * aim
                    
                case (.up, let x):
                    aim -= x
                case (.down, let x):
                    aim += x
                }
            }
        }
        
        let ret = actions.reduce(Position(horizontal: 0, depth: 0, aim: 0)) { partialResult, action in
            var partialResult = partialResult
            partialResult.apply(action)
            return partialResult
        }
        print(ret.horizontal * ret.depth)
    }
}
