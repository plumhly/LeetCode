//
//  1.8 零矩阵.swift
//  算法
//
//  Created by Plum on 2020/8/8.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 1.8 零矩阵
 
 编写一种算法，若MxN矩阵中的某个数是0，则清空行列
 */

struct Interview_1_8 {
    
    /*
    如果新发现的0的行或者列的数字已经存了，那么它就没有必要存取的。
    1. 用一个新的矩阵存放需要清空的行和列，最坏情况需要O(MxN)的空间。而且查找还要耗费时间。
    2. 用一个O(N)，一个存放行，一个存放列
    3. 用 O(1), 存放在原矩阵的首行或者首列当中
    */
    
    // 时间复杂度 O(MxN)
    // 空间复杂度 O(MxN)
    struct Solution1 {
        static func clearRowAndColumnWhenElementIsZero(in matrix: [[Int]]) -> [[Int]]? {
            guard validate(array: matrix) else {
                return nil
            }
            
            // 寻找0
            let rows = matrix.count
            let columns = matrix[0].count
            
            var indexMatrix: [[Int]] = Array<[Int]>(repeating: Array<Int>(repeating: 0, count: columns), count: rows)
            
            for row in 0..<rows {
                for column in 0..<columns {
                    if matrix[row][column] == 0 {
                        indexMatrix[row][column] = 1
                    }
                }
            }
            
            // 清零
            var matrix = matrix
            for row in 0..<rows {
                for column in 0..<columns {
                    if matrix[row][column] == 0 && indexMatrix[row][column] == 1 {
                        clear(matrix: &matrix, row: row)
                        clear(matrix: &matrix, column: column)
                    }
                }
            }
            return matrix
        }
    }
    
    // 用两个数组分别存储行和列
    // 时间复杂度 O(MxN)
    // 空间复杂度 O(M+N)
    struct Solution2 {
        static func clearRowAndColumnWhenElementIsZero(in matrix: [[Int]]) -> [[Int]]? {
            guard validate(array: matrix) else {
                return nil
            }
            
            // 寻找0
            let rowCount = matrix.count
            let columnCount = matrix[0].count
            
            var rows: [Int] = []
            var columns: [Int] = []
            
            for row in 0..<rowCount {
                for column in 0..<columnCount {
                    if matrix[row][column] == 0 {
                        rows.append(row)
                        columns.append(column)
                    }
                }
            }
            
            // 清零
            var matrix = matrix
            for row in rows {
                clear(matrix: &matrix, row: row)
            }
            
            for column in columns {
                clear(matrix: &matrix, column: column)
            }
            return matrix
        }
    }
    
    // 存放在原矩阵的首行或者首列当中
    // 时间复杂度 O(MxN)
    // 空间复杂度 O(1)
    struct Solution3 {
        static func clearRowAndColumnWhenElementIsZero(in matrix: [[Int]]) -> [[Int]]? {
            guard validate(array: matrix) else {
                return nil
            }
            
            var matrix = matrix
            let rowCount = matrix.count
            let columnCount = matrix[0].count
            
            // 记录首行和首列是否有0
            var isFirstRowHasZero = false
            var isFirstColumnsHasZero = false
            
            for i in matrix[0] {
                if i == 0 {
                    isFirstRowHasZero = true
                    break
                }
            }
            
            
            for row in 0..<rowCount {
                if matrix[row][0] == 0 {
                    isFirstColumnsHasZero = true
                    break
                }
            }
            
            // 寻找0
            for row in 1..<rowCount {
                for column in 1..<columnCount {
                    if matrix[row][column] == 0 {
                        // 把数据移动到第一行和第一列
                        matrix[0][column] = 0
                        matrix[row][0] = 0
                    }
                }
            }
            
            // 清零
            // 清列
            for column in 1..<columnCount {
                if matrix[0][column] == 0 {
                    clear(matrix: &matrix, column: column)
                }
            }
            
            // 清行
            for row in 1..<rowCount {
                if matrix[row][0] == 0 {
                    clear(matrix: &matrix, row: row)
                }
            }
            
            // 是否有必要清第一行和第一列
            if isFirstRowHasZero {
                clear(matrix: &matrix, row: 0)
            }
            
            if isFirstColumnsHasZero {
                clear(matrix: &matrix, column: 0)
            }
            return matrix
        }
    }
    
    static func clear(matrix: inout [[Int]], column: Int) {
       let allRow = matrix.count
       for i in 0..<allRow {
           matrix[i][column] = 0
       }
    }
    
    static func clear(matrix: inout [[Int]], row: Int) {
        let allColumns = matrix[0].count
        for j in 0..<allColumns {
            matrix[row][j] = 0
        }
    }

    static func validate(array: [[Int]]) -> Bool {
       guard !array.isEmpty else {
           return false
       }
       let count = array.first!.count
       return array.filter { $0.count != count }.count == 0
    }
    
    static func test() {
        let a1 = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
        let a2 = [[0, 0, 0], [0, 4, 5], [0, 7, 8]]
        assert(Solution1.clearRowAndColumnWhenElementIsZero(in: [[1], [1, 2]]) == nil)
        assert(Solution1.clearRowAndColumnWhenElementIsZero(in: a1) == a2)
        print("Interview_1_8 Solution1 test")
        
        assert(Solution2.clearRowAndColumnWhenElementIsZero(in: [[1], [1, 2]]) == nil)
        assert(Solution2.clearRowAndColumnWhenElementIsZero(in: a1) == a2)
        print("Interview_1_8 Solution2 test")
        
        assert(Solution3.clearRowAndColumnWhenElementIsZero(in: [[1], [1, 2]]) == nil)
        assert(Solution3.clearRowAndColumnWhenElementIsZero(in: a1) == a2)
        print("Interview_1_8 Solution3 test")
    }
}
