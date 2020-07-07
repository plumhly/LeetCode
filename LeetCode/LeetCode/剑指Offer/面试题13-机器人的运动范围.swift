//
//  面试题13-机器人的运动范围.swift
//  LeetCode
//
//  Created by Plum on 2020/6/6.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/**
 面试题13:机器人的运动范围
 
 P92
 
 题目:地上有一个m行n列的方格。一个机器人从坐标(0,0)的格子开始移动,它每次可以向左、右、上、下移动一格,但不能进入行坐标和列坐标的数位之和大于k的格子。例如,当k为18时,机器人能够进入方格(35,37),因为3+5+3+7=18。但它不能进入方格(35、,38),因为3+5+3+8=19。
 请问该机器人能够到达多少个格子?
 
 */

struct Topic13 {
    static func movingCount(threshold: Int, rows: Int, columns: Int) -> Int {
        guard threshold >= 0, rows > 0, columns > 0 else {
            return 0
        }
        
        var visits = Array<[Bool]>(repeating: Array<Bool>(repeating: false, count: columns), count: rows)
        return movingCountCore(threshold: threshold, row: 0,rows: rows, column: 0, columns: columns, visits: &visits)
        
    }
    
    static func movingCountCore(threshold: Int, row: Int, rows: Int, column: Int, columns: Int, visits: inout [[Bool]]) -> Int {
        var count = 0
        if check(threshold: threshold, row: row, rows: rows, column: column, columns: columns, visits: &visits) {
        
            visits[row][column] = true
            
            count = 1 + movingCountCore(threshold: threshold, row: row + 1, rows: rows, column: column, columns: columns, visits: &visits) + movingCountCore(threshold: threshold, row: row - 1, rows: rows, column: column, columns: columns, visits: &visits) + movingCountCore(threshold: threshold, row: row, rows: rows, column: column - 1, columns: columns, visits: &visits) + movingCountCore(threshold: threshold, row: row, rows: rows, column: column + 1, columns: columns, visits: &visits)
        }
        return count
    }
    
    static func check(threshold: Int, row: Int, rows: Int, column: Int, columns: Int, visits: inout [[Bool]]) -> Bool {
        if row >= 0 && row < rows && column >= 0 && column < columns && sum(of: row) + sum(of: column) <= threshold && !visits[row][column] {
            return true
        }
        return false
    }
    
    static func sum(of number: Int) -> Int {
        var sum = 0
        var number = number
    
        while number > 0 {
            sum += number % 10
            number /= 10
        }
        return sum
    }
    
    static func test() {
        
        assert(movingCount(threshold: 0, rows: 0, columns: 0) == 0)
        assert(movingCount(threshold: 1, rows: 3, columns: 3) == 3)
        assert(movingCount(threshold: 2, rows: 3, columns: 3) == 6)
        
        print("Topic13 OVER")
    }
}
