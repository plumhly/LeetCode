//
//  10.3 搜索旋转数组.swift
//  算法
//
//  Created by Plum on 2021/5/29.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation


/**
 P335
 
 10.3 搜索旋转数组。给定一个排序后的数组包含n个整数,但这个数组已被旋转过很多次
 了,次数不详。请编写代码找出数组中的某个元素,假设数组元素原先是按升序排列的。
 
 实例：
    输入：在数组{15, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10,  14}中找出 5
    输出：8
 */

/**
 有序数组，怎样旋转，都会一边是排序的
 */
struct Interview_10_3 {
    
    static func search(array: [Int], value: Int) -> Int? {
        return seach(array: array, start: 0, end: array.count - 1, value: value)
    }
    
    private static func seach(array: [Int], start: Int, end: Int, value: Int) -> Int? {
        guard start <= end else {
            return nil
        }
        
        let middleIndex = (start + end) / 2
        let middleValue = array[middleIndex]
        
        if value == middleValue {
            return middleIndex
        }
        
        var index: Int?
        
        if middleValue > array[start] {
            // 表名前部分是有序的
            if value >= array[start] && value < middleValue {
                // 左边寻找
                index = seach(array: array, start: start, end: middleIndex - 1, value: value)
            } else {
                // 右边寻找
                index = seach(array: array, start: middleIndex + 1, end: end, value: value)
            }
        } else if middleValue < array[start] {
            // 说明右边是有序的
            if value > middleValue && value <= array[end] {
                /// 右边寻找
                index = seach(array: array, start: middleIndex + 1, end: end, value: value)
            } else {
                index = seach(array: array, start: start, end: middleIndex - 1, value: value)
            }
        } else {
            // 相等，这个时候，需要看最右边的，如果不同，那么在右边寻找， 如果相同，那么两边都要寻找。
            let endValue = array[end]
            if middleValue != endValue {
                // 右边搜索
                index = seach(array: array, start: middleIndex + 1, end: end, value: value)
            } else {
                // 【2， 2， 2， 3， 4，2】
                // 两边搜索
                index = seach(array: array, start: start, end: middleIndex - 1, value: value)
                if index == nil {
                    index = seach(array: array, start: middleIndex + 1, end: end, value: value)
                }
            }
        }
        
        return index
    }
    
    static func test() {
        let a1 = [15, 16, 1, 2, 3]
        assert(search(array: a1, value: 3) == 4)
        
        let a2 = [2, 2, 2, 3, 4, 2]
        assert(search(array: a2, value: 3) == 3)
        print(" Interview_10_3 Over")
    }
}
