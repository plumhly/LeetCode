//
//  面试题42-连续子数组的最大和.swift
//  LeetCode
//
//  Created by Plum on 2020/6/26.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题42:连续子数组的最大和
 
 P218
 
 题目:输入一个整型数组,数组里有正数也有负数。数组中的一个或连续多个整数组成一个子数组。求所有子数组的和的最大值。要求时间复杂度为O
 */

struct Topic42 {
    struct Solution1 {
        static func maxSuccessionSum(array: [Int]) -> Int? {
               guard array.count > 0 else { return nil }
               
               var sum = array[0]
               var maxSum = sum
               for i in 1..<array.count {
                   sum += array[i]
                   if sum < array[i] {
                       sum = array[i]
                   }
                   if sum > maxSum {
                       maxSum = sum
                   }
               }
               return maxSum
           }
    }
    
    // 动态规划，实现代码同上
    struct Solution2 {
        
    }
   
    
    static func test() {
        let a = [-8, 4, 5, -8]
        assert(Solution1.maxSuccessionSum(array: a) == 9)
        print("Topic42 OVER")
    }
}
