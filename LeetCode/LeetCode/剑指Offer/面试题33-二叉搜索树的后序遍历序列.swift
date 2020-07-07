//
//  面试题33-二叉搜索树的后序遍历序列.swift
//  LeetCode
//
//  Created by Plum on 2020/6/21.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题33:二叉搜索树的后序遍历序列
 
 P179
 
 题目:输入一个整数数组,判断该数组是不是某二又搜索树的后序遍历结果。如果是则返回true,否则返回 false。假设输入的数组的任意两个
 数字都互不相同。例如,输入数组{5,7,6,9,11,10,8},则返回rue,因为这个整数序列是图4.,9二叉搜索树的后序遍历结果。如果输入的数组是(7 4,6,5},则由于没有哪棵二叉搜索树的后序遍历结果是这个序列,因此返回미 false。
 
 相关： 输入一个整数数组,判断该数组是不是某二又搜索树的前序遍历结果这和前面问题的后序遍历很类似,只是在前序遍历得到的序列中,第一个数字是根节点的值。
 
 */
struct Topic33 {
    static func isSearchBinaryPostTrvavel(array: [Int]) -> Bool {
        return isSearchBinaryPostOrder(array: array, start: 0, end: array.count - 1)
    }
    
    static func isSearchBinaryPostOrder(array: [Int], start: Int, end: Int) -> Bool {
        
        // **
        if start >= end {
            return true
        }
        
        let root = array[end]
        var startIndex = start
        
        for i in start...end {
            if array[i] > root {
                startIndex = i
                break
            }
        }
        
        // 判断右子树的所有值，是否都大于root
        for i in startIndex...end {
            if array[i] < root {
                return false
            }
        }
        
        let result = isSearchBinaryPostOrder(array: array, start: start, end: startIndex - 1) && isSearchBinaryPostOrder(array: array, start: startIndex, end: end - 1)
        return result
    }
    
    static func test() {
        let array1 = [5, 7, 6, 9, 11, 10, 8]
        assert(isSearchBinaryPostTrvavel(array: array1))
        
        let array2 = [7, 4, 6, 5]
        assert(isSearchBinaryPostTrvavel(array: array2) == false)
        
        let array3 = [1]
        assert(isSearchBinaryPostTrvavel(array: array3))
        print("Topic33 OVER")
    }
}
