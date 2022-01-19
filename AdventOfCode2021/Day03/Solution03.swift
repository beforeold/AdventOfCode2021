//
//  Solution03.swift
//  01 - Sonar
//
//  Created by BrookXy on 2022/1/14.
//

import Foundation

@objc class Solution03: NSObject {
    typealias Binary = Bool
    typealias Number = [Binary]
    
    static let binaryArray: [Number] = Input03.split(separator: "\n").map { substring -> [Binary] in
        return substring.map { char -> Binary in
            let int = Int(String(char))!
            return int == 1
        }
    }
    
    static func toDecimal(_ array: [Binary]) -> Int {
        var ret = 0
        for (index, item) in array.reversed().enumerated() {
            ret += (item ? 1 : 0) * Int(pow(2.0, Double(index)))
        }
        return ret
    }
    
    @objc
    static func part1() {
        let columnCount = binaryArray[0].count
        
        var gamma = [Binary]()
        
        // each column
        for column in 0..<columnCount {
            var dict = [Bool: Int]()
            for number in binaryArray {
                let value = number[column]
                
                var count = dict[value] ?? 0
                count += 1
                dict[value] = count
            }
            
            let zeroCount = dict[false] ?? 0
            let oneCont = dict[true] ?? 0
            gamma.append(oneCont >= zeroCount)
        }
        
        // oposite
        let epsilon = gamma.map { !$0 }
        
        // to decimal
        let gammaDecimal = toDecimal(gamma)
        let epsilonDecimal = toDecimal(epsilon)
        let ret = gammaDecimal * epsilonDecimal
        print(ret)
    }
    
    @objc
    static func part2() {
        func getRet(_ isOO: Bool) -> Number {
            let columnCount = binaryArray[0].count
            var numberList = binaryArray
        
            // each column
            for column in 0..<columnCount {
                if numberList.count == 1 { break }
                
                var trueNumberList = [Number]()
                var falseNumberList = [Number]()
                
                for number in numberList {
                    let value = number[column]
                    if value {
                        trueNumberList.append(number)
                    } else {
                        falseNumberList.append(number)
                    }
                }
                
                if isOO {
                    // more common one, return true if ==
                    if trueNumberList.count >= falseNumberList.count {
                        // keep true
                        numberList = trueNumberList
                    } else {
                        // keep false
                        numberList = falseNumberList
                    }
                } else {
                    // less common one, return false if ===
                    if falseNumberList.count <= trueNumberList.count {
                        // keep true
                        numberList = falseNumberList
                    } else {
                        // keep false
                        numberList = trueNumberList
                    }
                }
            }
            
            // stopped with the last left one
            return numberList[0]
        }
        
        // oposite
        let oo = getRet(true)
        let coo = getRet(false)
        
        // to decimal
        let gammaDecimal = toDecimal(oo)
        let epsilonDecimal = toDecimal(coo)
        let ret = gammaDecimal * epsilonDecimal
        print(ret)
    }
}
