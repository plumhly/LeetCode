//
//  10.11 峰与谷.swift
//  算法
//
//  Created by Plum on 2021/6/3.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P348
 
 
 10.11 峰与谷。在一个整数数组中,“峰”是大于或等于相邻整数的元素,相应地“谷”是
 小于或等于相邻整数的元素。例如,在数组{5,8,6,2,3,4,6}中,{8,6}是峰
 {5,2}是谷。现在给定一个整数数组,将该数组按峰与谷的交替顺序排序。

 实例：
    输入：【5，3，1，2，3】
    输出：【5，1，3，2，3】
 */

struct Interview_10_11 {
    
    /// O(nlog(n))
    struct Solution1 {
        static func sortValleyPeak(array: [Int]) -> [Int] {
            var newArray = array.sorted()
            
            for index in stride(from: 1, to: newArray.count, by: 2) {
                newArray.swapAt(index, index - 1)
            }
            
            return newArray
        }
    }
    
    /// O(n)
    struct Solution2 {
        static func sortValleyPeak(array: [Int]) -> [Int] {
            var array = array
            for index in stride(from: 1, to: array.count, by: +2) {
                let maxIndex = findMinValueIndex(array: array, a: index - 1, b: index, c: index + 1)
                
                // 将最大的放在中间
                if index != maxIndex {
                    array.swapAt(index, maxIndex)
                }
                
            }
            
            return array
        }
        
        private static func findMinValueIndex(array: [Int], a: Int, b: Int, c: Int) -> Int {
            let aValue = a < array.count ? array[a] : Int.max
            let bValue = b < array.count ? array[b] : Int.max
            let cValue = c < array.count ? array[c] : Int.max
            
            let maxValue = min(aValue, min(bValue, cValue))
            var index: Int
            if maxValue == aValue {
                index = a
            } else if maxValue == bValue {
                index = b
            } else {
                index = c
            }
            
            return index
        }
    }
    
    static func test() {
        
        let a = [5, 3, 1, 2, 3]
        print(Solution1.sortValleyPeak(array: a))
        
        print(Solution2.sortValleyPeak(array: a))
        
        print("\(self) OVER")
    }
}

