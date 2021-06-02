//
//  10.4 排序集合的查找.swift
//  算法
//
//  Created by Plum on 2021/5/29.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation


/**
 P336
 
 10.4排序集合的查找,给定一个类似数组的长度可变的数据结构它有 elementat()
 方法,可以在1)的时间内返回下标为的值,但越界会返回1因此,该数据结构只
 支持正整数。给定一个好序的正整数 Listy找到值为x的下标、如果x多次出现
 任选一个返回,(提示:320.337,48)
 */

struct Interview_10_4 {
    
    static func find(array: [Int], value: Int) -> Int? {
        guard !array.isEmpty else {
            return nil
        }
        
        let index = findIndexMaybe(array: array, value: value)
        
        /// 这里 start = index / 2 是个优化点
        return binarySearch(array: array, start: index / 2, end: index, value: value)
    }
    
    private static func findIndexMaybe(array: [Int], value: Int) -> Int {
        var index = 1
        while array[index] != -1 && array[index] <= value {
            index *= 2
        }
        
        return index
    }
    
    private static func binarySearch(array: [Int], start: Int, end: Int, value: Int) -> Int? {
        guard start <= end else {
            return nil
        }
        
        let middleIndex = (start + end) / 2
        let middleValue = array[middleIndex]
        
        var index: Int?
        if middleValue > value {
            // 左部分查找
            index = binarySearch(array: array, start: start, end: middleIndex - 1, value: value)
        } else if middleValue < value {
            // 右边
            index = binarySearch(array: array, start: middleIndex + 1, end: end, value: value)
        } else {
            index = middleIndex
        }
        
        return index
    }
    
    static func test() {
        let a1 = [1, -1, -1, -1, -1]
        assert(find(array: a1, value: 1) == 0)
        
        let a2 = [1, 3, 5, 7, 9, 10, 14, 15, -1, -1, -1, -1, -1, -1, -1]
        assert(find(array: a2, value: 5) == 2)
        
        print("Interview_10_4 OVERT")
    }
}
