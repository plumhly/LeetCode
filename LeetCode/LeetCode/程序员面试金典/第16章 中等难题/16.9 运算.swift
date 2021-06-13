//
//  16.9 运算.swift
//  算法
//
//  Created by Plum on 2021/6/7.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P403
 
 
 16.9运算,请实现整数数字的乘法、减法和除法运算,运算结果均为整数数字,程序中只允许使用加法运算符
 */

struct Interview_16_9 {
    
    static func reduce(a: Int, b: Int) -> Int {
        
        return a + negative(value: b)
    }
    
   static func negative(value: Int) -> Int {
        let dalt = value > 0 ? -1 : 1
        
        var value = value
        var newValue = 0
        
//            // round1 时间复杂度O(value)
//            while value != 0 {
//                newValue += dalt
//                value += dalt
//            }
        
        // round2 时间复杂度O((log(value))^2)
        var diff = dalt
        while value != 0 {
            let isOverflow = (diff + value > 0) != (value > 0) // 这是关键，表示dalt过大或者过小
            if value + diff != 0, isOverflow {
                diff = dalt
            }
            
            newValue += diff
            value += diff
            diff += diff
        }
        
        return newValue
    }
    
    static func multiply(a: Int, b: Int) -> Int {
        
        if b > a {
            return multiply(a: b, b: a)
        }
        
        var sum = 0
        for _ in 0..<abs(value: b) {
            sum += a
        }
        
        if b < 0 {
            sum = negative(value: sum)
        }
        
        return sum
    }
    
    static  func abs(value: Int) -> Int {
        return value > 0 ? value : negative(value: value)
    }
    
    enum Invalid: Error {
        case cantBeZero
    }
    
    static func divide(a: Int, b: Int) throws -> Int {
        guard b != 0 else {
            throw Invalid.cantBeZero
        }
        
        let absA = abs(value: a)
        let absB = abs(value: b)
        var value = 0
        var sum = 0
        while absB + sum <= absA {
            sum += absB
            value += 1
        }
        
        if (a < 0 && b < 0) || (a > 0 && b > 0) {
            return value
        } else {
            return negative(value: value)
        }
    }
    
    static func test() {
        
        do {
            assert(reduce(a: 0, b: 1) == -1)
            assert(reduce(a: 1, b: 1) == 0)
            assert(reduce(a: 1, b: -1) == 2)
        }
        
        do {
            assert(multiply(a: 0, b: 1) == 0)
            assert(multiply(a: 1, b: 1) == 1)
            assert(multiply(a: 1, b: -1) == -1)
            assert(multiply(a: -1, b: -1) == 1)
        }
        
        do {
            assert(try! divide(a: 1, b: 1) == 1)
            assert(try! divide(a: 8, b: 3) == 2)
            assert(try! divide(a: 8, b: 4) == 2)
            assert(try! divide(a: 8, b: -3) == -2)
            assert(try! divide(a: 8, b: -4) == -2)
        }
        
        
        print("\(self) OVER")
    }
}
