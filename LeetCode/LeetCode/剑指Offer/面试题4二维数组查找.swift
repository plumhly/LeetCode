//
//  面试题4二维数组查找.swift
//  LeetCode
//
//  Created by Plum on 2020/5/26.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/**
 # 题目:在一个二维数组中,每一行都按照从左到右递增的顺序排序, 每一列都按照从上到下递增的顺序排序。请完成一个函数,输入这样的一个二维数组和一个整数,判断数组中是否含有该整数。
 
- 解法： 从右上顶角开始查找
 
 */
func interview4_seachInTwoDimensionalArray(_ array: inout [[Int]], value: Int) -> (Bool, Int) {
    guard array.count > 0, array[0].count > 0 else {
        return (false, -1)
    }
    var row = 0
    let maxRow = array.count
    var column = array[0].count - 1
    
    while column >= 0, row < maxRow {
        if array[row][column] > value {
            column -= 1
        } else if array[row][column] < value {
            row += 1
        } else {
            return (true, value)
        }
    }
    return (false, -1)
}


func interview4_test() {
    var a = [[1, 2, 8, 9], [2, 4, 9, 12], [4, 7 , 10, 13], [6, 8, 11, 15]]
    let result = interview4_seachInTwoDimensionalArray(&a, value: 7)
    assert(result.0)
    print(result.1)
}
