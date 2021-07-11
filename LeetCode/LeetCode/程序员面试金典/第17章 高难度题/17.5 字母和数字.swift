//
//  字母和数字.swift
//  算法
//
//  Created by Plum on 2021/6/16.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 17.5字母与数字,给定一个放有字符和数字的数组,找到最长的子数组,且包含的字符和数
 字的个数相同。(提示:#484,#514,618,670,712)
 */

struct Interview_17_5 {
    
    /// 暴力法
    struct Solution1 {
        static func findMaxLengthLetterAndDigitArray(in array: [Any]) -> [Any] {
            guard array.count > 0 else {
                return []
            }
            
            for start in 0..<array.count {
                for end in stride(from: array.count - 1, to: start, by: -1) {
                    if isLetterAndDigitEqual(in: array, start: start, end: end) {
                        return Array(array[start...end])
                    }
                }
            }
            
            return []
        }
        
        private static func isLetterAndDigitEqual(in array: [Any], start: Int, end: Int) -> Bool {
            var count = 0
            for index in start...end {
                if array[index] is Int {
                    count += 1
                } else {
                    count -= 1
                }
            }
            
            return count == 0
        }
    }
    
    struct Solution2 {
        static func findMaxLengthLetterAndDigitArray(in array: [Any]) -> [Any] {
            guard array.count > 0 else {
                return []
            }
            
            let deltas = findDeltas(in: array)
            let range = findLongestSubIndex(in: deltas)
            
            return Array(array[range.0...range.1])
        }
        
        private static func findDeltas(in array: [Any]) -> [Int] {
            var delta = 0
            var result: [Int] = []
            for item in array {
                if item is String {
                    delta += 1
                } else {
                    delta -= 1
                }
                result.append(delta)
            }
            
            return result
        }
        
        private static func findLongestSubIndex(in deltas: [Int]) -> (Int, Int) {
            var start = 0
            var end = 0
            var container: [Int: Int] = [:]
            for (index, item) in deltas.enumerated() {
                if let pre = container[item] {
                    let currentLong = end - start
                    if currentLong < index - pre {
                        start = pre + 1
                        end = index
                    }
                    
                } else {
                    container[item] = index
                }
            }
            
            return (start, end)
        }
    }
    
    static func test() {
        
        let a: [Any] = [1, 2, "A", "b", 1]
        print(Solution1.findMaxLengthLetterAndDigitArray(in: a))
        print(Solution2.findMaxLengthLetterAndDigitArray(in: a))
        
        print("\(self) OVER")
    }
}
