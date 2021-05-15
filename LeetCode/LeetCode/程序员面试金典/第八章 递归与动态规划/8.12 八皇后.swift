//
//  8.12 八皇后.swift
//  算法
//
//  Created by Plum on 2021/5/15.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P306
 
 8.12八皇后。设计一种算法,打印八皇后在8×8棋盘上的各种摆法,其中每个皇后都不同行、
 不同列,也不在对角线上。这里的“对角线”指的是所有的对角线,不只是平分整个棋
 盘的那两条对角线。(提示:#308,#350,#371)
 
 */

struct Interview_8_12 {
    static let queueSize: Int = 8
    
    static func placeQueuen() -> [[Int]] {
        var result: [[Int]] = []
        
        placeQueue(row: 0, container: [], result: &result)
        
        return result
    }
    
    static func placeQueue(row: Int, container: [Int], result: inout [[Int]]) {
        guard row < queueSize else {
            result.append(container)
            return
        }
        
        // ⚠️ 区域是 0..<queueSize
        for colum in 0..<queueSize where isValid(row: row, column: colum, container: container)  {
            /// container放的位置
            var container = container
            container.append(colum)
            placeQueue(row: row + 1, container: container, result: &result)
        }
    }
    
    // ⚠️ row是将要填写的row
    static func isValid(row: Int, column: Int, container: [Int]) -> Bool {
        
        // ⚠️ 第一次空判断，方式【0】越界
        guard !container.isEmpty else {
            return true
        }
        
        for r in 0..<row {
            
            // 判断是否是一列
            let co = container[r]
            if co == column {
                return false
            }
            
            /// 判断对角线： 如果列之差等会行之差，那么就是对角线
            if abs(co - column) == row - r {
                return false
            }
        }
        
        return true
    }
    
    
    
    static func test() {
        
        print(placeQueuen())
     
        print("Interview_8_12 Over")
    }
}
