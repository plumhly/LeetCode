//
//  面试题65-不用加减乘除做加法.swift
//  LeetCode
//
//  Created by Plum on 2020/7/10.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题65:不用加减乘除做加法
 
 P311
 
 题目:写一个函数,求两个整数之和,要求在函数体内不得使用“+"”-”、“x”、“+”四则运算符号。
 
 分析：
 接下来我们试着把二进制的加法用位运算来替代。第一步不考虑进位对每一位相加。0加0、1加1的结果都是0,0加1、1加0的结果都是1 我们注意到,这和异或的结果是一样的。对异或而言,0和0、1和1的异或结果是0,而0和1、1和0的异或结果是1。接着考虑第二步进位,对0 加0、0加1、1加0而言,都不会产生进位,只有1加1时,会向前产生个进位。此时我们可以想象成两个数先做位与运算,然后再向左移动一位只有两个数都是1的时候,位与得到的结果是1,其余都是0。第三步把前两个步骤的结果相加。第三步相加的过程依然是重复前面两步,直到不产生进位为止。
 
 ***
 不使用新的变量,交换两个变量的值。比如有两个变量a、b,我们希望交换它们的值。有两种不同的方法:
 1. a = a + b, b = a - b, a = a - b
 2. a = a ^ b, b = a ^ b, a = a ^ b
 */

struct Topic65 {
    static func add(number1: Int, number2: Int) -> Int {
        
        var number1 = number1
        var number2 = number2
        
        var sum = 0
        var carry = 0
        repeat {
            sum = number1 ^ number2
            carry = (number1 & number2) << 1
            
            number1 = sum
            number2 = carry
            
        } while number2 != 0
        return sum
    }
    
    static func test() {
        assert(add(number1: 1, number2: 2) == 3)
        assert(add(number1: -1, number2: -1) == -2)
        print("Topic65 OVER")
    }
}
