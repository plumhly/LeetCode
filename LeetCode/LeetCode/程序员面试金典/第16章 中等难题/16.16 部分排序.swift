//
//  16.16 部分排序.swift
//  算法
//
//  Created by Plum on 2021/6/10.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P419
 
 16.16部分排序。给定一个整数数组,编写一个函数,找出索引m和n,只要将m和n之间的元素排好序,整个数组就是有序的。注意:nm尽量最小,也就是说,找出符合条件的最短序列。
 示例:
    输入:1,2,4,7,10,11,7,12,6,7,16,18,19
    输出:(3,9)
 (提示:#481,#552,#666,#707,#734,#745)
 */

struct Interview_16_16 {
    
    static func findUnsortSequence(in array: [Int]) -> (start: Int, end: Int) {
        guard array.count > 0 else {
            return (0, 0)
        }
        
        let leftEnd = findLeftEndIndex(in: array)
        if leftEnd == array.count - 1 {
            return (0, 0)
        }
        
        let rightStart = findRightStartIndex(in: array)
        
        // 左 + 中 最大的 => 缩小右边
        // 中 + 右 最小的 => 缩小左边
        var maxIndexInLeftToMiddle = leftEnd
        var minIndexInMiddleToRight = rightStart
        
        for i in (maxIndexInLeftToMiddle + 1) ..< minIndexInMiddleToRight {
            if array[i] > array[maxIndexInLeftToMiddle] {
                maxIndexInLeftToMiddle = i
            }
            
            if array[i] < array[minIndexInMiddleToRight] {
                minIndexInMiddleToRight = i
            }
        }
        
        
        // 左 + 中 最大的 => 缩小右边
        // 中 + 右 最小的 => 缩小左边
        let middleStart = shrinkLeft(in: array, preEnd: leftEnd, minIndex: minIndexInMiddleToRight)
        let middleEnd = shrinkRight(in: array, preStart: rightStart, maxIndex: maxIndexInLeftToMiddle)
        
        return (middleStart, middleEnd)
        
    }
    
    static func findLeftEndIndex(in array: [Int]) -> Int {
        for index in 1 ..< array.count {
            if array[index] < array[index - 1] {
                return index - 1
            }
        }
        
        return array.count - 1
    }
    
    static func findRightStartIndex(in array: [Int]) -> Int {
        for index in stride(from: array.count - 2, through: 0, by: -1) {
            if array[index] > array[index + 1] {
                return index + 1
            }
        }
        
        return 0
    }
    
    static func shrinkLeft(in array: [Int], preEnd: Int, minIndex: Int) -> Int {
        
        let value = array[minIndex]
        
        for index in stride(from: preEnd, through: 0, by: -1) {
            if array[index] <= value {
                return index + 1 // 这里index只左边的最后一个元素，中间的第一个元素就是 index + 1
            }
        }
        
        return 0
    }
    
    static func shrinkRight(in array: [Int], preStart: Int, maxIndex: Int) -> Int {
        
        let value = array[maxIndex]
        
        for index in stride(from: preStart, to: array.count, by: 1) {
            if array[index] >= value {
                return index - 1
            }
        }
        
        return array.count - 1
    }
    
    static func test() {
        
        let result = findUnsortSequence(in: [1,2,4,7,10,11,7,12,1,7,16,18,19])
        assert(result.start == 1)
        assert(result.end == 9)
        
        let result1 = findUnsortSequence(in: [1,2,4,7,10,11,7,12,6,7,16,18,19])
        assert(result1.start == 3)
        assert(result1.end == 9)
        
        
        print("\(self) OVER")
    }
}
