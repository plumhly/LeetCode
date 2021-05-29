//
//  10.5 稀疏数组搜索.swift
//  算法
//
//  Created by Plum on 2021/5/29.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 10.5稀疏数组搜索,有个排好序的字符数组其中布若一些空字符,编写一种方法
 找出给定字符串的位置
 示例:
 输入:在字符数组{"at", "", "", "", "ball", "", "", "car", "", "", "dad", "", "",} 中查找 "ball"
 输出:4
 (提示:256)
 */

struct Interview_10_5 {
    
    static func findIndex(in array: [String], value: String) -> Int? {
        guard !array.isEmpty && !value.isEmpty else {
            return nil
        }
        
        return binarySearch(array: array, value: value, start: 0, end: array.count - 1)
    }
    
    static func binarySearch(array: [String], value: String, start: Int, end: Int) -> Int? {
        guard start <= end else {
            return nil
        }
        
        func search(middleIndex: Int, value: String) -> Int? {
            let middleValue = array[middleIndex]
            var index: Int?
            
            if middleValue > value {
                // 左边
                index = binarySearch(array: array, value: value, start: start, end: middleIndex - 1)
            } else if middleValue < value {
                index = binarySearch(array: array, value: value, start: middleIndex + 1, end: end)
            } else {
                index = middleIndex
            }
            
            return index
        }
        
        /// 中间index
        let middleIndex = (start + end) / 2
        let middleValue = array[middleIndex]
        
        var index: Int?
        if middleValue.isEmpty {
            if let nextIndex = findLatesIndex(in: array, emptyIndex: middleIndex) {
                index = search(middleIndex: nextIndex, value: value)
            }
        } else {
            index = search(middleIndex: middleIndex, value: value)
        }
        
        return index
    }
    
    
    static func findLatesIndex(in array: [String], emptyIndex: Int) -> Int? {
        
        var leftIndex = emptyIndex - 1
        var rightIndex = emptyIndex + 1
        var index: Int?
        while leftIndex >= 0 && rightIndex < array.count {
            if array[leftIndex].count > 0 {
                index = leftIndex
                break
            }
            
            if array[rightIndex].count > 0 {
                index = rightIndex
                break
            }
            
            leftIndex -= 1
            rightIndex += 1
        }
        
        return index
    }
    
    
    
    static func test() {
        
        let a1 = ["", "", "", ""]
        assert(findIndex(in: a1, value: "a") == nil)
        
        let a2 = ["1", "", "", "", "3", "", "", "", "4", "", "", "", ]
        assert(findIndex(in: a2, value: "3") == 4)
        
        let a3 = ["a", "b", "c", "d", "e"]
        assert(findIndex(in: a3, value: "d") == 3)
        
        
        print("\(self) OVER")
    }
}
