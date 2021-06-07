//
//  16.4 井字游戏.swift
//  算法
//
//  Created by Plum on 2021/6/5.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P392
 
 16.4字游戏,设计一个算法,判断玩家是否了字(提示:709,731)
 */

struct Interview_16_4 {
    
    enum Piece: Int {
        case empty = 0, blue = 1, red = 2
    }
    
    /// 每次调用
    /// 把3^9 的棋盘类型转换成整数（3进制，蓝色1 红色2 空为0）
    struct Solution1 {
        
    }
    
    /// 知道最后一步
    struct Solution2 {
        static func hasWiner(table: [[Piece]], row: Int, column: Int) -> Piece {
            /// 是否是正方形
            guard !table.isEmpty, !table[0].isEmpty, table.count == table[0].count else {
                return .empty
            }
            
            // 判断行 // 判断列
            if findWin(table: table, row: row) || findWin(table: table, colum: column) {
                return table[row][column]
            }
         
            // 判断左对角线
            if row == column, findWin(table: table, isLeft: true) {
                return table[row][column]
            }
            
            // 判断右对角线
            if row == table.count - column - 1, findWin(table: table, isLeft: false) {
                return table[row][column]
            }
            
            return .empty
            
        }
        
        private static func findWin(table: [[Piece]], row: Int) -> Bool {
            let value = table[row][0]
            for item in table[row] {
                if item != value {
                    return false
                }
            }
            
            return true
        }
        
        private static func findWin(table: [[Piece]], colum: Int) -> Bool {
            let value = table[0][colum]
            for row in 1..<table[0].count {
                if table[row][colum] != value {
                    return false
                }
            }
            
            return true
        }
        
        private static func findWin(table: [[Piece]], isLeft: Bool) -> Bool {
            let startColumn = isLeft ? 0 : table.count - 1
            let diff = isLeft ? 1 : -1
            
            var column = startColumn
            
            let value = table[0][column]
            
            
            for row in 0..<table.count {
                if table[row][column] != value {
                    return false
                }
                
                column += diff
            }
            
            return true
        }
        
    }
    
    /// 直接遍历
    struct Solution3 {
        
    }
    
    /// NXN
    /// 按照 行、列、对角线、
    struct Solution4 {
        
    }
    
    static func test() {
        
        do {
            var table1 = Array<Array<Piece>>(repeating: [Piece](repeating: .empty, count: 3), count: 3)
            table1[0][0] = .blue
            table1[0][1] = .blue
            table1[0][2] = .blue
            
            table1[1][0] = .red
            
            table1[2][0] = .red
            
            assert(Solution2.hasWiner(table: table1, row: 0, column: 2) == .blue)
        }
        
        print("\(self) OVER")
    }
}
