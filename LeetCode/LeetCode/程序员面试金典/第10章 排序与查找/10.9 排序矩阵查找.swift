//
//  10.9 排序矩阵查找.swift
//  算法
//
//  Created by Plum on 2021/5/30.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P342
 
 10.9排序矩阵查找,给定MN矩阵,每一行、每一列都按升序排列,请编写代码找出某元素
 (提示:#193,#211.#229,#251,#266,#279 #288 #291 #303 #317 #330
 */

struct Interview_10_9 {
    
    struct Solution1 {
        static func find(value: Int, in array: [[Int]]) -> (Int, Int)? {
            guard !array.isEmpty, let c = array.first?.count else {
                return nil
            }
            
            var row = 0
            var column = c - 1
            
            var index: (Int, Int)?
            while row < array.count, column >= 0 {
                if array[row][column] == value {
                    index = (row, column)
                    break
                } else if array[row][column] > value {
                    column -= 1
                } else {
                    row += 1
                }
            }
            
            return index
        }
    }
    
    struct Solution2 {
        
        struct Coordinate {
            var row: Int
            var column: Int
            
            init(row: Int, column: Int) {
                self.row = row
                self.column = column
            }
            
            mutating func next() {
                row += 1
                column += 1
            }
            
            mutating func pre() {
                row -= 1
                column -= 1
            }
            
            mutating func setAverage(start: Coordinate, end: Coordinate) {
                row = (start.row + end.row) / 2
                column = (start.column + end.column) / 2
            }
            
            func isBefore(other: Coordinate) -> Bool {
                return row <= other.row && column <= other.column
            }
            
            func isInBound(array: [[Int]]) -> Bool {
                return !array.isEmpty && row < array.count && column < array[0].count
            }
            
        }
        
        static func find(value: Int, in array: [[Int]]) -> Coordinate? {
            guard !array.isEmpty else {
                return nil
            }
            return find(value: value, in: array, origin: Coordinate(row: 0, column: 0), ended: Coordinate(row: array.count - 1, column: array[0].count - 1))
        }
        
        /// 找到分割线
        private static func find(value: Int, in array: [[Int]], origin: Coordinate, ended: Coordinate) -> Coordinate? {
            guard origin.isBefore(other: ended), origin.isInBound(array: array), ended.isInBound(array: array) else {
                return nil
            }
            
            var index: Coordinate?
            if array[origin.row][origin.column] == value {
                index = origin
            } else if array[ended.row][ended.column] == value {
                index = ended
            } else {
                /// 2分查找对角线元素
                
                let diff = min(ended.row - origin.row, ended.column - origin.column)
                var start = origin
                var end = Coordinate(row: start.row + diff, column: start.column + diff)
                var av = start
                
                while start.isBefore(other: end) {
                    av.setAverage(start: start, end: end)
                    if value == array[av.row][av.column] {
                        index = av
                        break
                    } else if value > array[av.row][av.column] {
                        // 右下角
                        start.row = av.row + 1
                        start.column = av.column + 1
                    } else {
                        end.row = av.row - 1
                        end.column = av.column - 1
                    }
                }
                
                if index == nil {
                    index = binarySearch(array: array, start: origin, end: ended, av: start, value: value)
                }
            }
            
            return index
        }
        
        static private func binarySearch(array: [[Int]], start: Coordinate, end: Coordinate, av: Coordinate, value: Int) -> Coordinate? {
            // 左下角区域
            let leftOrigin = Coordinate(row: av.row, column: start.column)
            let leftEnd = Coordinate(row: end.row, column: av.column - 1)
            
            // 右上角
            let rightOrigin = Coordinate(row: start.row, column: av.column)
            let rightEnd = Coordinate(row: av.row - 1, column: end.column)
            
            var index = find(value: value, in: array, origin: leftOrigin, ended: leftEnd)
            if index == nil {
                index = find(value: value, in: array, origin: rightOrigin, ended: rightEnd)
            }
            
            return index
        }
    }
    
    static func test() {
        let a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        assert(Solution1.find(value: 4, in: a)! == (1, 0))
        
        assert(Solution2.find(value: 1, in: []) == nil)
        print(Solution2.find(value: 3, in: a))
        print(Solution2.find(value: 5, in: a))
        
        print("\(self) OVER")
    }
}
