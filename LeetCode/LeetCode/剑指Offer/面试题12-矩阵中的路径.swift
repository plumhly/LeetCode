//
//  面试题12-矩阵中的路径.swift
//  LeetCode
//
//  Created by Plum on 2020/6/6.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/**
 面试题12:矩阵中的路径
 
 P89
 
 题目:请设计一个函数,用来判断在一个矩阵中是否存在一条包含某字符串所有字符的路径。路径可以从矩阵中的任意一格开始,每一步可以在矩阵中向左、右、上、下移动一格。如果一条路径经过了矩阵的某一格, 那么该路径不能再次进入该格子。例如,在下面的3x4的矩阵中包含一条字符串“bfce”的路径(路径中的字母用下画线标出)。但矩阵中不包含字符串“abfb”的路径,因为字符串的第一个字符b占据了矩阵中的第一行第二个格子之后,路径不能再次进入这个格子。
 
 */

struct Topic12 {
    static func findPath(mattrix: [[String]], string: String) -> Bool {
        guard !mattrix.isEmpty, string.count > 0 else {
            return false
        }
        
        // 判断每一行是否一样
        var count = -1
        var isSameColumn = true
        mattrix.forEach { (value) in
            if count == -1 {
                count = value.count
                return
            }
            if count != value.count {
                isSameColumn = false
            }
        }
        
        guard isSameColumn else {
            return false
        }
        
        let rows = mattrix.count
        let colums = mattrix.first!.count
        
        var index = string.startIndex
        
        var visits = mattrix.map { $0.map { _ in false } }
        
        /// 寻找起点
        for row in 0..<rows {
            for column in 0..<colums {
                if hasPath(mattrix: mattrix, string: string, visted: &visits, row: row, column: column, index: &index) {
                    return true
                }
            }
        }
        
        
        return false
    }
    
    static func hasPath(mattrix: [[String]], string: String, visted: inout [[Bool]], row: Int, column: Int, index: inout String.Index) -> Bool {
        
        if index == string.endIndex {
            return true
        }
        
        let rows = mattrix.count
        let colums = mattrix.first!.count
        var haspath = false
        
        /// ⚠️ row 和 column 的限制
        if row < rows && row >= 0 && column < colums && column >= 0 && mattrix[row][column] == String(string[index]) && !visted[row][column] {
            
            /// ⚠️ 延长index
            index = string.index(after: index)
            /// ⚠️记录访问但
            visted[row][column] = true
            
            haspath = hasPath(mattrix: mattrix, string: string, visted: &visted, row: row + 1, column: column, index: &index) || hasPath(mattrix: mattrix, string: string, visted: &visted, row: row - 1, column: column, index: &index) || hasPath(mattrix: mattrix, string: string, visted: &visted, row: row, column: column + 1, index: &index) || hasPath(mattrix: mattrix, string: string, visted: &visted, row: row, column: column - 1, index: &index)
            
            ///
            if !haspath {
                /// ⚠️还原
                index = string.index(before: index)
                visted[row][column] = false
            }
        }
        
        
        return haspath
    }
    
    static func test() {
        let a = [["p", "a", "b", "c"], ["l", "u", "m", "d"]]
        assert(findPath(mattrix: a, string: "plum"))
        print("Topic12 OVER")
    }
}
