//
//  面试题66-构建乘积数组.swift
//  LeetCode
//
//  Created by Plum on 2020/7/11.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题66:构建乘积数组
 
 P312
 
 题目:给定一个数组A[O,1,…-1],请构建一个数组B[O,1,…m-1】,其中B中的元素]=A[이xA]…XAi]×A汁1]x… XAI-l]l。不能使用除法。
 */

struct Topic66 {
    static func multiply(array: [Int]) -> [Int]? {
        guard array.count > 1 else {
            return nil
        }
        
        var result = Array<Int>(repeating: 0, count: array.count)
        
        result[0] = 1
        
        // 左边
        for i in 1..<array.count {
            result[i] = result[i - 1] * array[i - 1]
        }
        
        // 右边
        var temp = 1
        for i in (0...array.count - 2).reversed() {
            temp *= array[i + 1]
            result[i] *= temp
        }
        return result
    }
    
    static func test() {
        let a = [1, 2, 3, 4, 5, 6]
        let result = multiply(array: a)
        print("Topic66 OVER")
    }
}
