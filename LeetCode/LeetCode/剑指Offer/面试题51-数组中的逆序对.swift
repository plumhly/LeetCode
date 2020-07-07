//
//  面试题51-数组中的逆序对.swift
//  LeetCode
//
//  Created by Plum on 2020/7/1.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题51:数组中的逆序对
 
 P249
 
 题目:在数组中的两个数字,如果前面一个数字大于后面的数字, 则这两个数字组成一个逆序对。输入一个数组,求出这个数组中的逆序对的总数。例如,在数组{7,5,6,4}中,一共存在5个逆序对,分别是(7,6) 7,5)、(7,4)、(6,4)和(5,4)。
 
 分析：
 经过前面详细的讨论,我们可以总结出统计逆序对的过程:先把数组分隔成子数组,统计出子数组内部的逆序对的数目,然后再统计出两个相邻子数组之间的逆序对的数目。在统计逆序对的过程中,还需要对数组进行排序。如果对排序算法很熟悉,那么我们不难发现这个排序的过程实际上就是归并排序。我们可以基于归并排序写出如下代码:
 */

struct Topic51 {
    static func reversePaireCount(array: [Int]) -> Int? {
        guard array.count > 1 else {
            return nil
        }
        
        var array = array
        var copy = array
        
        return findReversePaire(array: &array, copy: &copy, start: 0, end: array.count - 1)
    }
    
    static func findReversePaire(array: inout [Int], copy: inout [Int], start: Int, end: Int) -> Int {
        guard start != end else {
            copy[start] = array[start]
            return 0
        }
        
        let middle = (start + end) >> 1
        
        // 交叉
        let left = findReversePaire(array: &copy, copy: &array, start: start, end: middle)
        let right = findReversePaire(array: &copy, copy: &array, start: middle + 1, end: end)
        
        var startIndex = middle
        var endIndex = end
        var copyIndex = end
        var count = 0
        // >= start
        while startIndex >= start, endIndex > middle {
            if array[startIndex] > array[endIndex] {
                // 那么之后的都是逆序对
                count += endIndex - middle
                copy[copyIndex] = array[startIndex]
                copyIndex -= 1
                startIndex -= 1
            } else {
                copy[copyIndex] = array[endIndex]
                copyIndex -= 1
                endIndex -= 1
            }
        }
        
        // >= start
        while startIndex >= start {
            copy[copyIndex] = array[startIndex]
            copyIndex -= 1
            startIndex -= 1
        }
        
        while endIndex > middle {
            copy[copyIndex] = array[endIndex]
            copyIndex -= 1
            endIndex -= 1
        }
        
        return count + left + right
    }
    
    static func test() {
        let a = [7, 5, 6, 4]
        assert(reversePaireCount(array: a) == 5)
        
        let b = [4]
        assert(reversePaireCount(array: b) == nil)
        
        let c = [5, 4]
        assert(reversePaireCount(array: c) == 1)
        
        print("Topic51 OVER")
    }
}
