//
//  面试题44-数字序列中某一位的数字.swift
//  LeetCode
//
//  Created by Plum on 2020/6/27.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题44:数字序列中某一位的数字
 
 P225
 
 题目:数字以0123456789101112131415…的格式序列化到一个字符序列中。在这个序列中,第5位(从0开始计数)是5,第13位是1,第19 位是4,等等。请写一个函数,求任意第n位对应的数字。
 
 分析：序列的前10位是0~9这10个只有一位的数字。显然第1001位在这10个数字之后,因此这10个数字可以直接跳过。我们再从后面紧跟着的序列中找第91(991-=1001-10)位的数字。
 接下来180位数字是90个10~99的两位数。由于991>180,所以第991位在所有的两位数之后。我们再跳过90个两位数,继续从后面找881 (881-991-180)位。
 接下来的2700位是900个100~999的三位数。由于811<2700,所以第811位是某个三位数中的一位。由于811=270×3+1,这意味着第811位是从100开始的第270个数字即370的中间一位,也就是7。
 */

struct Topic44 {
    static func numberOf(index: Int) -> Int? {
        guard index >= 0 else {
            return nil
        }
        
        var digit = 1
        var index = index
        while true {
            let numbers = allNumberOf(digit: digit)
            if index > numbers {
                index -= numbers
                digit += 1
            } else {
                // 找到了范围
                return finalNumber(index: index, digit: digit)
            }
        }
    }
    
    static func allNumberOf(digit: Int) -> Int {
        if digit == 1 {
            return 10
        }
        
        var result = 1
        for _ in 0..<digit - 1 {
            result *= 10
        }
        return 9 * result * digit
    }
    
    static func beginNumberOf(digit: Int) -> Int {
        if digit == 1 {
            return 0
        }
        return Int(pow(10, Double(digit - 1)) as Double)
    }
    
    static func finalNumber(index: Int, digit: Int) -> Int {
        var finalIndex = beginNumberOf(digit: digit) + index / digit
        let indexFromRight = digit - index % digit
        // 这里从1开始，第一个数组index是0
        for _ in 1..<indexFromRight {
            finalIndex /= 10
        }
        return finalIndex % 10
    }
    
    static func test() {
        assert(numberOf(index: 0) == 0)
        assert(numberOf(index: 9) == 9)
        assert(numberOf(index: 1001) == 7)
        assert(numberOf(index: 1000) == 3)
        assert(numberOf(index: 1002) == 0)
        print("Tpic44 OVER")
    }
    
}
