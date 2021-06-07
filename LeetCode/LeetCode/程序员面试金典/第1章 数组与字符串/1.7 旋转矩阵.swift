//
//  1.7 旋转矩阵.swift
//  算法
//
//  Created by Plum on 2020/8/4.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 1.7 旋转矩阵
 
 给定一幅由 NxN 矩阵表示的图像，其中每个像素的大小为4字节，编写一个方法，将图像旋转90度，不占用额外空间是否能做到。
 */

struct Interview_1_7 {
    // 旋转矩阵
    // 时间复杂度 O(N^2)
    // 空间复杂度 O(1)
    struct Solution1 {
        static func rotate(matrix: [[Int]]) -> [[Int]]? {
            guard !matrix.isEmpty, let first = matrix.first, first.count == matrix.count else {
                return nil
            }
            
            var matrix = matrix
            for layer in 0..<matrix.count / 2 {
                let first = layer
                let last = matrix.count - 1 - layer
                for i in first..<last {
                    let offset = i - first
                    
                    // 左上角
                    let leftTop = matrix[first][i]
                    
                    // 左下角 -> 左上角
                    matrix[first][i] = matrix[last - offset][first]
                    
                    // 右下角 -> 左下角
                     matrix[last - offset][first] = matrix[last][last - offset]
                    
                    // 右上角 -> 右下角
                    matrix[last][last - offset] = matrix[i][last]
                    
                    // 左上角 -> 右上角
                    matrix[i][last] = leftTop
                }
            }
            return matrix
        }
    }
    
    static func test() {
        let a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        let b = [[7, 4, 1], [8, 5, 2], [9, 6, 3]]
        assert(Solution1.rotate(matrix: [[1, 2], [3, 4]]) == [[3, 1], [4, 2]])
        assert(Solution1.rotate(matrix: [[1], [2, 3]]) == nil)
        assert(Solution1.rotate(matrix: a) == b)
        print("Interview_1_7 Solution1 test")
    }
}
