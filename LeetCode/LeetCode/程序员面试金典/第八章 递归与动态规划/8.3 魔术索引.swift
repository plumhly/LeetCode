//
//  8.3 魔术索引.swift
//  算法
//
//  Created by Plum on 2021/3/7.
//  Copyright © 2021 Plum. All rights reserved.
//

/*
 8.3魔术索引。在数组A[0..n-1]中，有所谓的魔术索引，满足条件A[i]=i给定一个
 有序整数数组，元素值各不相同，编写一种方法找出魔术索引，若有的话，在数组A中
 找出一个魔术索引。
 
 进阶：如果数组元素有重复值
 */

import Foundation

struct Interview_8_3 {
    struct Solution1 {
        struct Normal {
            static func findMagicIndex(in array: [Int]) -> Int? {
                guard !array.isEmpty else {
                    return nil
                }
                
                return findMagicIndex(in: array, low: 0, high: array.count - 1)
            }
            
            private static func findMagicIndex(in array: [Int], low: Int, high: Int) -> Int? {
                guard low <= high else {
                    return nil
                }
                
                /// 相等
                if low == high {
                    return array[low] == low ? low : nil
                }
                
                // 不相等
                let middle = low + high >> 1
                let value = array[middle]
                if value > middle {
                    // 往左边寻找
                    return findMagicIndex(in: array, low: low, high: middle)
                } else if value < middle {
                    return findMagicIndex(in: array, low: middle + 1, high: high)
                } else {
                    return middle
                }
            }
        }
        
        struct Advance {
            static func findMagicIndex(in array: [Int]) -> Int? {
                guard !array.isEmpty else {
                    return nil
                }
                
                return findMagicIndex(in: array, low: 0, high: array.count - 1)
            }
            
            private static func findMagicIndex(in array: [Int], low: Int, high: Int) -> Int? {
                guard low <= high else {
                    return nil
                }
                
                /// 相等
                if low == high {
                    return array[low] == low ? low : nil
                }
                
                // 不相等
                let middle = low + high >> 1
                let middleValue = array[middle]
                
                if middleValue == middle {
                    return middleValue
                }
                
                let leftIndex = min(middle - 1, middleValue)
                if let left = findMagicIndex(in: array, low: low, high: leftIndex) {
                    return left
                }
                
                let rightIndex = max(middle + 1, middleValue)
                return findMagicIndex(in: array, low: rightIndex, high: high)
            }
        }
    }
    
    static func test() {
        let value1 = [1, 2, 3, 4]
        let value2 = [0, 2, 3, 4]
        assert(Solution1.Normal.findMagicIndex(in: value1) == nil)
        assert(Solution1.Normal.findMagicIndex(in: value2) == 0)
        assert(Solution1.Normal.findMagicIndex(in: []) == nil)
        assert(Solution1.Normal.findMagicIndex(in: [0]) == 0)
        
        
        let value3 = [2, 2, 2, 4]
        assert(Solution1.Advance.findMagicIndex(in: value3) == 2)
        
        
        print("Interview_8_3.Solution1 OVER")
        
    }
}
