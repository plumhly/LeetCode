//
//  16.19 水域大小.swift
//  算法
//
//  Created by Plum on 2021/6/12.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P425
 
 6.19
 水域大小。你有一个用于表示一片土地的整数矩阵,该矩阵中每个点的值代表对应地点的海拔高度若值为0则表示水域,由垂直、水平或对角连接的水域为池塘池塘的大小是指相连接的水域的个数。编写一个方法来计算阵中所有池塘的大小
 
 示例:
    输入:
        0 2 1 0
        0 1 0 1
        1 1 0 1
        0 1 0 1
    
    输出:2,4,1(任意顺序)
    
    (提示:673,686705,722)
 */

struct Interview_16_19 {
    
    
    static func findPools(int array:[[Int]]) -> [Int] {
        guard array.count > 0 else {
            return []
        }
        
        var array = array
        
        let maxRow = array.count
        let maxCol = array[0].count
        
        var result: [Int] = []
        
        for row in 0 ..< maxRow {
            for col in 0 ..< maxCol {
                if array[row][col] == 0 {
                    let size = computeSize(int: &array, row: row, col: col)
                    result.append(size)
                }
            }
        }
        
        return result
    }
    
    static func computeSize(int arry: inout [[Int]], row: Int, col: Int) -> Int {
        guard row >= 0, row < arry.count, col >= 0, col < arry[0].count, arry[row][col] == 0 else {
            return 0
        }
        
        // ⚠️ size = 1 而 不是等于 0
        var size = 1
        /// 计算四面八方
        arry[row][col] = -1
        for tRow in -1...1 {
            for tCol in -1...1 {
                size += computeSize(int: &arry, row: tRow + row, col: tCol + col)
            }
        }
        
        return size
    }
    
    static func test() {
        assert(findPools(int: []) == [])
        print(findPools(int: [[0, 2, 1, 0], [0, 1, 0, 1], [1, 1, 0, 1], [0, 1, 0, 1]]))
        print("\(self) OVER")
    }
}
