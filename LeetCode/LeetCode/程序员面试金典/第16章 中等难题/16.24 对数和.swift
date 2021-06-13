//
//  16.24 对数和.swift
//  算法
//
//  Created by Plum on 2021/6/13.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P441
 
 16.24数对和。设计一个算法,找出数组中两数之和为指定值的所有整数对。
 (提示:#547,#596,#643,#672)
 */

struct Interview_16_24 {
    
    /// 暴力法
    struct Solution1 {
        
    }
    
    struct Solution2 {
        static func findPair(in array: [Int], sum: Int) -> [(Int, Int)] {
            guard array.count > 0 else {
                return []
            }
            
            var container: [Int: Int] = [:]
            var result: [(Int, Int)] = []
            for item in array {
                let diff = sum - item
                if let value = container[diff], value > 0 {
                    result.append((diff, item))
                    container.updateValue(value - 1, forKey: diff)
                } else {
                    if let value = container[item] {
                        container.updateValue(value + 1, forKey: item)
                    } else {
                        container[item] = 1
                    }
                }
            }
            
            return result
        }
    }
    
    struct Solution3 {
        static func findPair(in array: [Int], sum: Int) -> [(Int, Int)] {
            guard array.count > 0 else {
                return []
            }
            
            var result: [(Int, Int)] = []
            let array = array.sorted()
            
            var startIndex = 0
            var endIndex = array.count - 1
            
            while startIndex < endIndex {
                let startValue = array[startIndex]
                let endValue = array[endIndex]
                
                if sum == startValue + endValue {
                    result.append((startValue, endValue))
                    startIndex += 1
                    endIndex -= 1
                } else if sum > startValue + endValue {
                    startIndex += 1
                } else {
                    endIndex -= 1
                }
            }
            
            return result
        }
    }

    
    static func test() {
        let a = [1, 3, 4, 6, 9, 2, 4]
        let b = [1, 1, 6, 6, 9, 3, 4]
        print(Solution2.findPair(in: a, sum: 7))
        print(Solution3.findPair(in: a, sum: 7))
        
        print(Solution2.findPair(in: b, sum: 7))
        print(Solution3.findPair(in: b, sum: 7))
        print("\(self) OVER")
    }
}
