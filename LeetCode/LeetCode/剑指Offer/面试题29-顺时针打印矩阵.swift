//
//  面试题29-顺时针打印矩阵.swift
//  LeetCode
//
//  Created by Plum on 2020/6/17.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题29:顺时针打印矩阵
 
 P161
 
 题目:输入一个矩阵,按照从外向里以顺时针的顺序依次打印出每个数字。例如,如果输入如下矩阵:
 */

struct Topic29 {
    static func printMatrixClockwise(_ array: [[Int]]) -> [Int]? {
        guard array.count > 0, array[0].count > 0 else {
            return nil
        }
        let row = array.count
        let columns = array[0].count
        var start = 0
        var result: [Int] = []
        // ⚠️，规律：每圈的起始点满足 2 * start < row, 2 * start < column
        while row > 2 * start, columns > 2 * start  {
            let r = printCircle(array, start: start)
            result.append(contentsOf: r)
            start += 1
        }
        return result
    }
    
    static func printCircle(_ array: [[Int]], start: Int) -> [Int] {
        let row = array.count
        let columns = array[0].count
        
        let maxRow = row - 1 - start
        let maxColumn = columns - 1 - start
        
        var result: [Int] = []
        
        // 第一步总是需要的
        // 左->右
        for i in start...maxColumn {
            result.append(array[start][i])
        }
        
        //要第二步的前提条件是终止行号大于起始行号
        // 上 -> 下
        if start + 1 <= maxRow {
            for i in start+1...maxRow {
                result.append(array[i][maxColumn])
            }
        }
        
        //除了要求终止行号大于起始行号,还要求终止列号大于起始列号
        // 右 -> 左
        if start < maxColumn && start < maxRow {
            for i in stride(from: maxColumn - 1, through: start, by: -1) {
                result.append(array[maxRow][i])
            }
        }
        
        //需要打印第四步的前提条件是至少,因此要求终止行号比起始行号至少大2,同时终止列号大于起始行号
        // 下 -> 上
        if start <= maxRow - 2 && start < maxColumn {
            for i in stride(from: maxRow - 1, through: start + 1, by: -1) {
                result.append(array[i][start])
            }
        }
        return result
    }
    
    static func test() {
        // 一行
        let a = [[1, 2, 3]]
        assert(printMatrixClockwise(a) == [1, 2, 3])
        // 1列
        let b = [[1], [2], [3]]
        assert(printMatrixClockwise(b) == [1, 2, 3])
        // 1行1列
        let c = [[1]]
        assert(printMatrixClockwise(c) == [1])
        
        let d = [[1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]]
        assert(printMatrixClockwise(d) == [1, 2, 3, 4, 4, 4, 4, 3, 2, 1, 1,1, 2, 3,3,2])
        
        print("Topic29 OVER")
    }
}
