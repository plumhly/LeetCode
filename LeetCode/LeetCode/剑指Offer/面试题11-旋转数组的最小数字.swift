//
//  面试题11-旋转数组的最小数字.swift
//  LeetCode
//
//  Created by Plum on 2020/6/6.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/**
 面试题11:旋转数组的最小数字
 
 P83
 - 题目:把一个数组最开始的若干个元素搬到数组的末尾,我们称之为数组的旋转。输入一个递增排序的数组的一个旋转,输出旋转数组的最小元素。例如,数组{3,4,5,1,2}为{1,2,3,4,5}的一个旋转,该数组的最小值为1。
 
 分析：
 和二分査找法一样,我们用两个指针分别指向数组的第一个元素和最后一个元素。按照题目中旋转的规则,第一个元素应该是大于或者等于最后一个元素的(这其实不完全对,还有特例,后面再加以讨论)。
 */

struct Topic11 {
    static func minValue(in numbers: [Int]) -> Int {
        guard numbers.count > 1 else {
            return numbers[0]
        }
        
        // first 只能在左边数组游荡
        // last 只能在左边数组游荡
        var firstIndex = 0
        var lastIndex = numbers.count - 1
        var midIndex = firstIndex //考虑到有序数组
        
        // 这个条件不要忘记 numbers[firstIndex] >= numbers[lastIndex]
        while firstIndex <= lastIndex && numbers[firstIndex] >= numbers[lastIndex] {
            // 走完了
            if firstIndex + 1 == lastIndex {
                midIndex = lastIndex
                break
            }
            
             midIndex = (firstIndex + lastIndex) >> 1
            // 三数相等，就顺序遍历，[1, 0, 1, 1, 1], [1, 1, 1, 0, 1]
            if numbers[firstIndex] == numbers[lastIndex], numbers[midIndex] == numbers[lastIndex] {
                var min = numbers[firstIndex]
                for i in (firstIndex + 1)...lastIndex {
                    if numbers[i] < min {
                        min = numbers[i]
                    }
                }
                return min
            }
            
            /**移动别忘了相等的情况*/
            if numbers[midIndex] >= numbers[firstIndex] {
                // 左边
                firstIndex = midIndex
            } else if (numbers[midIndex] <= numbers[lastIndex]) {
                lastIndex = midIndex
            }
        }
        return numbers[midIndex]
    }
    
    static func test() {
        let a = [1, 2, 3, 4]
        let b = [4, 5, 1, 2]
        assert(minValue(in: a) == 1)
        assert(minValue(in: b) == 1)
        
        print("Topic11 OVER")
    }
    
}
