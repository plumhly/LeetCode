//
//  17.6 2出现的次数.swift
//  算法
//
//  Created by Plum on 2021/6/17.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P458
 
 17.6 2出现的次数,编写一个方法,计算从0到n(含n)中数字2出现的次数。

 示例:
    输入:25
    输出:9(2,12,20,21,22,23,24,25)(注意22应该算作两次)
    (提示:#572,611,640)
 */

struct Interview_17_6 {
    
    /// 暴力法
    struct Solution1 {
        
    }
    
    
    struct Solution2 {
        static func find2Count(to number: Int) -> Int {
            var count = 0
            var digit = 0
            var temp = number
            while temp > 0 {
                count += find2Count(to: number, digit: digit)
                digit += 1
                /// ⚠️ 这里是/ 不是%
                temp /= 10
            }
            
            return count
        }
        
        private static func find2Count(to number: Int, digit: Int) -> Int {
            let powerOfDigit = Int(pow(Double(10),Double(digit)))
            let nextPower = powerOfDigit * 10
            let rightNumber = number % powerOfDigit
            
            let downNumber = number - number % nextPower
            let upNumber = downNumber + nextPower
            
            let currentDigit = number / powerOfDigit % 10
            
            var count = 0
            if currentDigit < 2 {
                count = downNumber / 10
            } else if currentDigit > 2 {
                count = upNumber / 10
            } else {
                count = downNumber / 10 + rightNumber + 1
            }
            
            return count
        }
    }
    
    static func test() {
        assert(Solution2.find2Count(to: 25) == 9)
        print("\(self) OVER")
    }
}
