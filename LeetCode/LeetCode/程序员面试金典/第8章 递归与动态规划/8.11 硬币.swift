//
//  8.11 硬币.swift
//  算法
//
//  Created by Plum on 2021/5/15.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P304
 
 8.11硬币。给定数量不限的硬币,币值为25分、10分、5分和1分,编写代码计算n分有几
 种表示法。(提示:#300,#324,#343,#380,#394)
 
 */

struct Interview_8_11 {
    
    struct Solution1 {
        public static func makeChange(n: Int) -> Int {
            return makeChange(n: n, faceValue: [25, 10, 5, 1], index: 0)
        }
        
        private static func makeChange(n: Int, faceValue: [Int], index: Int) -> Int {
            guard index < faceValue.count - 1 else {
                return 1
            }
            
            var way = 0
            let money = faceValue[index]
            for value in stride(from: 0, through: n, by: money) {
                way += makeChange(n: n - value, faceValue: faceValue, index: index + 1)
            }
            
            return way
        }
    }
    
    /// 缓存值
    struct Solution2 {
        public static func makeChange(n: Int) -> Int {
            let faceValues = [25, 10, 5, 1]
            
            /// 二维数组的细节 n + 1，用n和index构成
            var result: [[Int]] = Array<[Int]>(repeating: Array<Int>(repeating: 0, count: faceValues.count), count: n + 1)
            return makeChange(n: n, faceValue: faceValues, index: 0, result: &result)
        }
        
        private static func makeChange(n: Int, faceValue: [Int], index: Int, result: inout [[Int]]) -> Int {
            guard index < faceValue.count - 1 else {
                return 1
            }
            
            let preResult = result[n][index]
            if preResult > 0 {
                return preResult
            }
            
            var way = 0
            let money = faceValue[index]
            for value in stride(from: 0, through: n, by: money) {
                way += makeChange(n: n - value, faceValue: faceValue, index: index + 1, result: &result)
            }
            
            result[n][index] = way
            
            return way
        }
    }
    
    static func test() {
        assert(Solution1.makeChange(n: 3) == 1)
        assert(Solution1.makeChange(n: 10) == 4)
        
        
        assert(Solution2.makeChange(n: 3) == 1)
        assert(Solution2.makeChange(n: 10) == 4)
        
        print("Interview_8_11 Solution1 Over")
    }
}
