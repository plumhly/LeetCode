//
//  面试题47-礼物的最大价值.swift
//  LeetCode
//
//  Created by Plum on 2020/6/29.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题47:礼物的最大价值
 
 P233
 
 题目:在一个mxn的棋盘的每一格都放有一个礼物,每个礼物都有一定的价值(价值大于0)。你可以从棋盘的左上角开始拿格子里的礼物,并每次向左或者向下移动一格,直到到达棋盆的右下角。给定一个棋盘及其上面的礼物,请计算你最多能拿到多少价值的礼物?
 */

struct Topic47 {
    struct Solution1 {
        static func maxGiftValue(array: [[Int]]) -> Int {
            guard isValide(array: array) else {
                return 0
            }
            
            let row = array.count
            let col = array[0].count
            var result = Array<[Int]>(repeating: Array<Int>(repeating: 0, count: col), count: row)
            
            for i in 0..<row {
                var left = 0
                var up = 0
                for j in 0..<col {
                    if i > 0 {
                        up = result[i-1][j]
                    }
                    if j > 0 {
                        left = result[i][j - 1]
                    }
                    result[i][j] = max(left, up) + array[i][j]
                }
            }
            return result[row - 1][col - 1]
        }
        
       
    }
    
    static func isValide(array: [[Int]]) -> Bool {
        guard array.count > 0 else { return false }
        var isValid = true
        let count = array[0].count
        for i in 1..<array.count {
           if array[i].count != count {
               isValid = false
               break
           }
        }
        return isValid
    }

    static func test() {
        let a = [[1, 10, 3, 8], [12, 2, 9, 6], [5, 7, 4, 11], [3, 7, 16, 5]]
        assert(Solution1.maxGiftValue(array: a) == 53)
        assert(Solution2.maxGiftValue(array: a) == 53)
        
        print("Topic47 OVER")
    }
    
    /*
     接下来我们考虑进一步的优化。前面我们提到,到达坐标为(:の的格子时能够拿到的礼物的最大价值只依赖坐标为(iー1)和(i,-1)的两个格子,因此第-2行及更上面的所有格子礼物的最大价值实际上没有必要保存下来。
     */
    struct Solution2 {
        static func maxGiftValue(array: [[Int]]) -> Int {
            guard isValide(array: array) else {
                return 0
            }
            
            let row = array.count
            let col = array[0].count
            var result = Array<Int>(repeating: 0, count: col)
            
            for i in 0..<row {
                var left = 0
                var up = 0
                for j in 0..<col {
                    if i > 0 {
                        up = result[j]
                    }
                    if j > 0 {
                        left = result[j - 1]
                    }
                    result[j] = max(left, up) + array[i][j]
                }
            }
            return result[col - 1]
        }
    }
}
