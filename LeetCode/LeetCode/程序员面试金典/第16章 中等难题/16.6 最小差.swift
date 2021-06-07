//
//  16.6 最小差.swift
//  算法
//
//  Created by Plum on 2021/6/6.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation



/*
 P399
 
 16.6最小差,给定两个整数数组,计算其在最小(非负)的一对数值(每个数组中取一个
 值),并返回该对数值的差,
 示例:
    输入:{1,3,15,11,2),(23,127,235,19,8）
    输出: 3，即数值对(11,8）
 */

struct Interview_16_6 {
    
    // 暴力法
    struct Solution1 {
        
    }
    
    struct Solution2 {
        static func findMinDiff(with array:[Int], array2: [Int]) -> Int? {
            guard !array.isEmpty, !array2.isEmpty else {
                return nil
            }
            
            let a = array.sorted()
            let b = array2.sorted()
            
            var aIndex = 0
            var bIndex = 0
            var min = Int.max
            
            while aIndex < array.count, bIndex < b.count {
                let diff = abs(a[aIndex] - b[bIndex])
                if diff < min {
                    min = diff
                }
                
                if a[aIndex] < b[bIndex] {
                    aIndex += 1
                } else {
                    bIndex += 1
                }
            }
            
            return min
        }
    }

    
    static func test() {
        
        assert(Solution2.findMinDiff(with: [1], array2: []) == nil)
        
        assert(Solution2.findMinDiff(with: [1, 3, 15, 11, 2], array2: [23, 127, 235, 19, 8]) == 3)
        
        print("\(self) OVER")
    }
}
