//
//  Solution01.swift
//  01 - Sonar
//
//  Created by BrookXy on 2022/1/14.
//

import Foundation


@objc class Solution01: NSObject {
    static var intArray = Input01.split(separator: Character("\n")).map { Int($0)! }

    static func part1() {
        var current = intArray[0]
        let ret = intArray.reduce(0) { partialResult, item in
            var temp = partialResult
            if item > current {
                temp += 1
            }
            current = item
            return temp
        }
        print(ret)
    }

    static  func part2() {
        let window = 3
        func get(start: Int) -> Int {
            let end = start + window
            if intArray.count < end {
                return 0
            }
            return intArray[start..<(start + window)].reduce(0, +)
        }
        
        var current = get(start: 0)
        
        var ret = 0
        for (index, _) in intArray.enumerated() {
            let temp = get(start: index)
            if temp > current {
                ret += 1
            }
            current = temp
        }
        print(ret)
    }


}

