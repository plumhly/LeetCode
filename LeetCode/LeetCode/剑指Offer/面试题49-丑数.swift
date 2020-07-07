//
//  面试题49-丑数.swift
//  LeetCode
//
//  Created by Plum on 2020/6/30.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

struct Topic49 {
    struct Solution1 {
        static func findUglyNumber(at index: Int) -> Int {
            guard index > 0 else {
                return 0
            }
            
            var number = 0
            var uglyIndex = 0
            while uglyIndex < index {
                number += 1
                if isUglyNumber(number) {
                    uglyIndex += 1
                }
            }
            return number
        }
        
        static func isUglyNumber(_ number: Int) -> Bool {
            var number = number
            while number % 2 == 0 {
                number /= 2
            }
            while number % 3 == 0 {
                number /= 3
            }
            while number % 5 == 0 {
                number /= 5
            }
            return number == 1
        }
    }
    
    struct Solution2 {
        static func findUglyNumber(at index: Int) -> Int {
            guard index > 0 else {
                return 0
            }
            
            var uglyNumbers = Array<Int>(repeating: 0, count: index)
            uglyNumbers[0] = 1
            
            var multiple2Index = 0
            var multiple3Index = 0
            var multiple5Index = 0
            var uglyIndex = 1
            while uglyIndex < index {
                let v2 = uglyNumbers[multiple2Index] * 2
                let v3 = uglyNumbers[multiple3Index] * 3
                let v5 = uglyNumbers[multiple5Index] * 5
                let min = trippleMin(value1: v2, value2: v3, value3: v5)
                
                uglyNumbers[uglyIndex] = min
                uglyIndex += 1
                
                // 调整下一个位置 // * 数字
                while uglyNumbers[multiple2Index] * 2 <= min {
                    multiple2Index += 1
                }
                
                while uglyNumbers[multiple3Index] * 3 <= min {
                    multiple3Index += 1
                }
                
                while uglyNumbers[multiple5Index] * 5 <= min {
                    multiple5Index += 1
                }
                
            }
            
            return uglyNumbers[index - 1]
        }
        
        static func trippleMin(value1: Int, value2: Int, value3: Int) -> Int {
            return min(min(value1, value2), value3)
        }
    }
    
    static func test() {
        assert(Solution1.findUglyNumber(at: 0) == 0)
        assert(Solution1.findUglyNumber(at: 1) == 1)
        assert(Solution1.findUglyNumber(at: 11) == 15)
        assert(Solution1.findUglyNumber(at: 12) == 16)
        print("Topic49 Solution1 VOER ")
        
        assert(Solution2.findUglyNumber(at: 0) == 0)
        assert(Solution2.findUglyNumber(at: 1) == 1)
        assert(Solution2.findUglyNumber(at: 11) == 15)
        assert(Solution2.findUglyNumber(at: 12) == 16)
        print("Topic49 Solution2 VOER ")
    }
}
