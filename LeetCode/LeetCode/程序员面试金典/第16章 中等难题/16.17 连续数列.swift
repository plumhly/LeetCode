//
//  16.17 连续数列.swift
//  算法
//
//  Created by Plum on 2021/6/12.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 
 16.17连续数列。给定一个整数数组(有正数有负数)找出总和最大的连续数列,并返回总和。

 示例:
    输入:2,-8,3,-2,4,-10
    输出:5(即{3,-2,4})
 (提示:#530,#550,#566,#593,#613)
 */

struct Interview_16_17 {
    
    struct Solution {
        static func findMaxSumSequence(in array: [Int]) -> Int {
            guard array.count > 0 else {
                return 0
            }
            
            var maxSum = Int.min
            var sum = Int.min
            for item in array {
                if sum < 0 {
                    sum = item
                } else {
                    sum += item
                }
                
                if sum > maxSum {
                    maxSum = sum
                }
            }
            
            return maxSum
        }
    }
    
    static func test() {
        
        assert(Solution.findMaxSumSequence(in: [2, -8, 3, -2, 4, -10]) == 5)
        
        print("\(self) OVER")
    }
}
