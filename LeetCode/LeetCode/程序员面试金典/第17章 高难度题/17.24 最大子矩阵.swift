//
//  17.24 最大子矩阵.swift
//  算法
//
//  Created by Plum on 2021/7/11.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P523
 
 17.24 最大子矩阵。给定一个正整数和负整数组成的NN矩阵,编写代码找出元素总和最大的子矩阵。
 
 (提示:#468,510,#524,=538,564, 580,#594,#614,620)
 */

struct Interview_17_24 {
    
    struct SubMetri {
        let startRow: Int
        let endRow: Int
        let startColumn: Int
        let endColumn: Int
        let sum: Int
    }
    
    /// O(N^6)
    struct Solution1 {
        static func findMaxSubMetri(in array: [[Int]]) -> SubMetri? {
            guard array.count > 0 else {
                return nil
            }
            
            let count = array.count - 1
            var result: SubMetri? = nil
            
            for r1 in 0...count  {
                for r2 in r1...count {
                    for c1 in 0...count {
                        for c2 in c1...count {
                            let value = sum(row1: r1, row2: r2, c1: c1, c2: c2, in: array)
                            if result == nil || result!.sum < value.sum  {
                                result = value
                            }
                        }
                    }
                }
            }
            
            return result
        }
        
        private static func sum(row1: Int, row2: Int, c1: Int, c2: Int, in array: [[Int]]) -> SubMetri {
            var sum = 0
            for r in row1...row2 {
                for c in c1...c2 {
                    sum += array[r][c]
                }
            }
            
            return SubMetri(startRow: row1, endRow: row2, startColumn: c1, endColumn: c2, sum: sum)
        }
    }
    
    /// O(N^4)
    struct Solution2 {
        static func findMaxSubMetri(in array: [[Int]]) -> SubMetri? {
            guard array.count > 0 else {
                return nil
            }
            
            let process = preprocess(array: array)
            
            let count = array.count - 1
            var result: SubMetri? = nil
            
            for r1 in 0...count  {
                for r2 in r1...count {
                    for c1 in 0...count {
                        for c2 in c1...count {
                            let value = sum(row1: r1, row2: r2, c1: c1, c2: c2, in: array, process: process)
                            if result == nil || result!.sum < value.sum  {
                                result = value
                            }
                        }
                    }
                }
            }
            
            return result
        }
        
        private static func sum(row1: Int, row2: Int, c1: Int, c2: Int, in array: [[Int]], process: [[Int]]) -> SubMetri {
            
            /// ⚠️此处注意 -1
            let leftTop = row1 > 0 && c1 > 0 ? process[row1 - 1][c1 - 1] : 0
            let top = row1 > 0 ? process[row1 - 1][c2] : 0
            let left = c1 > 0 ? process[row2][c1 - 1] : 0
            
            let sum = process[row2][c2] - top - left + leftTop
            
            return SubMetri(startRow: row1, endRow: row2, startColumn: c1, endColumn: c2, sum: sum)
        }
        
        private static func preprocess(array: [[Int]]) -> [[Int]] {
            var result = [[Int]](repeating: [Int](repeating: 0, count: array.count), count: array.count)
            
            for r in 0...(array.count - 1) {
                for c in 0...(array.count - 1) {
                    /// 左上角的值
                    let leftTop = r > 0 && c > 0 ? result[r - 1][c - 1] : 0
                    
                    /// 正上边
                    let top = r > 0 ? result[r - 1][c] : 0
                    
                    /// 正左边
                    let left = c > 0 ? result[r][c - 1] : 0
                    
                    /// ⚠️此处 不要忘记 + array[r][c]
                    result[r][c] = top + left - leftTop + array[r][c]
                }
            }
            
            return result
            
        }
    }
    
    /// O(CR^2)
    struct Solution3 {
        
        struct Range {
            let start: Int
            let end: Int
            let value: Int
        }
        
        static func findMaxSubMetri(in array: [[Int]]) -> SubMetri? {
            guard array.count > 0 else {
                return nil
            }
            
            let count = array.count - 1
            var result: SubMetri? = nil
            
            for r1 in 0...count  {
                var partialSun = [Int](repeating: 0, count: array.count)
                
                for r2 in r1...count {
                    for c1 in 0...count {
                        partialSun[c1] += array[r2][c1]
                    }
                    
                    let range = maxSum(in: partialSun)
                    
                    if result == nil || result!.sum < range.value {
                        result = SubMetri(startRow: r1, endRow: r2, startColumn: range.start, endColumn: range.end, sum: range.value)
                    }
                }
            }
            
            return result
        }
        
        private static func maxSum(in array: [Int]) -> Range {
            var best: Range?
            var start = 0
            var sum = 0
            for (index, value) in array.enumerated() {
                sum += value
                if best == nil || best!.value < sum {
                    best = Range(start: start, end: index, value: sum)
                }
                
                if sum < 0 {
                    sum = 0
                    start = index + 1
                }
            }
            
            return best!
        }
    }
    
    static func test() {
        
        let a = [
            [1, 1, -1, -1],
            [1, 1, -1, -1],
            [1, 1, -1, -1],
            [-1, -1, -1, -1],
        ]
        
        assert(Solution1.findMaxSubMetri(in: a)!.sum == 6)
        assert(Solution2.findMaxSubMetri(in: a)!.sum == 6)
        assert(Solution3.findMaxSubMetri(in: a)!.sum == 6)
        
        print("\(self) OVER")
    }
}
