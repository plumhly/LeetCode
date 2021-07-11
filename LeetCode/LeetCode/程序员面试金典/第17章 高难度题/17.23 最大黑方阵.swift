//
//  17.23.swift
//  算法
//
//  Created by Plum on 2021/7/10.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P520
 
 17.23 最大黑方阵。给定一个方阵,其中每个单元(像素)非黑即白,设计一个算法,找出4条边皆为黑色像素的最大子方阵。
 
 (提示:63,=694.704713,720, 735)
 */

struct Interview_17_23 {
    
    /// O(N^4)
    struct Solution1 {
        static func findMaxSubSquar(in array: [[Int]]) -> (row: Int, column: Int, size: Int)? {
            guard array.count > 0 else {
                return nil
            }
            
            for size in stride(from: array.count, through: 1, by: -1) {
                if let result = findMaxMatrix(int: array, size: size) {
                    return result
                }
            }
            
            return nil
        }
        
        private static func findMaxMatrix(int array: [[Int]], size: Int) -> (row: Int, column: Int, size: Int)? {
            let count = array.count - size
            
            for row in 0...count {
                for column in 0...count {
                    if isSquar(in: array, row: row, column: column, size: size) {
                       return (row, column, size)
                    }
                }
            }
            
            return nil
        }
        
        private static func isSquar(in array: [[Int]], row: Int, column: Int, size: Int) -> Bool {
            for c in column...(column + size - 1) {
                /// 第一行/最后一行
                if array[row][c] == 0 || array[row + size - 1][c] == 0 {
                    return false
                }
            }
            
            for r in row...(row + size - 1) {
                if array[r][column] == 0 || array[r][column + size - 1] == 0 {
                    return false
                }
            }
            
            return true
        }
    }
    
    /// O(N^3)
    struct Solution2 {
        static func findMaxSubSquar(in array: [[Int]]) -> (row: Int, column: Int, size: Int)? {
            guard array.count > 0 else {
                return nil
            }
            
            let processResult = process(array: array)
            
            for size in stride(from: array.count, through: 1, by: -1) {
                if let result = findMaxMatrix(int: array, size: size, process: processResult) {
                    return result
                }
            }
            
            return nil
        }
        
        private static func findMaxMatrix(int array: [[Int]], size: Int, process: [[(Int, Int)]]) -> (row: Int, column: Int, size: Int)? {
        
            let count = array.count - size
            
            for row in 0...count {
                for column in 0...count {
                    if isSquar(row: row, column: column, size: size, process: process) {
                       return (row, column, size)
                    }
                }
            }
            
            return nil
        }
        
        private static func isSquar(row: Int, column: Int, size: Int, process: [[(Int, Int)]]) -> Bool {
            return process[row][column].0 >= size && process[row][column].1 >= size
        }
        
        private static func process(array: [[Int]]) -> [[(rightSize: Int, bellow: Int)]] {
            var result = Array<Array<(Int, Int)>>(repeating: Array<(Int, Int)>(repeating: (0, 0), count: array.count), count: array.count)
            
            for r in stride(from: array.count - 1, through: 0, by: -1) {
                for c in stride(from: array.count - 1, through: 0, by: -1) {
                    if array[r][c] == 1 {
                        /// 表明是在最边上,要考虑在单方面的row或者Column上叠加,
                        if r == array.count - 1, c == array.count - 1 {
                            /// 最右下角
                            result[r][c] = (1, 1)
                        } else if r == array.count - 1 {
                            /// 最后一行
                            let next = result[r][c + 1]
                            result[r][c] = (next.0 + 1, 1)
                        } else if c == array.count - 1 {
                            /// 最后一列
                            let next = result[r + 1][c]
                            result[r][c] = (1, next.1 + 1)
                        } else {
                            /// ⚠️，此处要用左边的元素和下边的元素来计算  
                            let nextRight = result[r][c + 1]
                            let nextBellow = result[r + 1][c]
                            result[r][c] = (nextRight.0 + 1, nextBellow.1 + 1)
                        }
                    }
                }
            }
            
            return result
        }
    }
    
    
    
    static func test() {
        
        let a = [
            [0, 0, 0, 0],
            [0, 1, 1, 1],
            [0, 1, 0, 1],
            [0, 1, 1, 1],
        ]
        
        assert(Solution1.findMaxSubSquar(in: a) ?? (0, 0, 0) == (1, 1, 3))
        assert(Solution2.findMaxSubSquar(in: a) ?? (0, 0, 0) == (1, 1, 3))
        print("\(self) OVER")
    }
}
