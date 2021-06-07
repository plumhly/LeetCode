//
//  16.7 最大数值.swift
//  算法
//
//  Created by Plum on 2021/6/6.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 16.7最大数值,编写一个方法,找出两个数字中最大的那一个,不得使用 if-else或其他比较运算符(提示: #472, #512 #706 #727)
 */

/*
分析：
 ·1. 考虑溢出
 2. 结论：a与b符号不同，结果和a的符号相同, 若相同，和a-b相同
 */
struct Interview_16_7 {
    
    static func findMax(a: Int, b: Int) -> Int {
        let c = a &- b
        
        let signA = sign(value: a)
        let signB = sign(value: b)
        let signC = sign(value: c)
        
        
        let userA = signA ^ signB
        let useC = flip(sign: userA)
        let finalSign = userA * signA + useC * signC
        let reverseSign = flip(sign: finalSign)
        
        return a * finalSign + reverseSign * b
    }
    
    static func sign(value: Int) -> Int {
        return flip(sign: (value >> 63)) & 1 // 0 是 整数，1是负数
    }
    
    static func flip(sign: Int) -> Int {
        return sign ^ 1
    }
    
    static func test() {
        
        assert(findMax(a: 1, b: 2) == 2)
        assert(findMax(a: 1, b: 1) == 1)
        assert(findMax(a: -1, b: 2) == 2)
        
        assert(findMax(a: 1, b: -2) == 1)
        
        assert(findMax(a: Int.max - 2, b: -15) == Int.max - 2)
        assert(findMax(a: Int.min + 2, b: 15) == 15)
        
        print("\(self) OVER")
    }
}
