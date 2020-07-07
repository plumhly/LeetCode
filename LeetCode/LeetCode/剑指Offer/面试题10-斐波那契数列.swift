//
//  面试题10-斐波那契数列.swift
//  LeetCode
//
//  Created by Plum on 2020/6/3.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation


/**
 题目一:求斐波那契数列的第n项。
 写一个函数,输入n,求斐波那契( Fibonacci)数列的第n项。斐波那契数列的定义如下:
 
 题目二:青蛙跳台阶问题。
 一只青蛙一次可以跳上1级台阶,也可以跳上2级台阶。求该青蛙跳上一个n级的台阶总共有多少种跳法。
 
 扩展：
 1. 在青蛙跳台阶的问题中,如果把条件改成:一只青蛙一次可以跳上1 级台阶,也可以跳上2级…它也可以跳上n级,此时该青蛙跳上一个n 级的台阶总共有多少种跳法?我们用数学归纳法可以证明An)=2"l。
 
 2. 我们可以用2×1(图2.12的左边)的小矩形横着或者竖着去覆盖更大的矩形。请问用8个2x1的小矩形无重叠地覆盖一个2×8的大矩形(图2.12 的右边),总共有多少种方法?
 
 我们先把2x8的覆盖方法记为f(8)。用第一个2x1的小矩形去覆盖大矩形的最左边时有两种选择:竖着放或者横着放。当竖着放的时候,右边还剩下2×7的区域
 ,这种情形下的覆盖方
 法记为f(7)。
 接下来考虑横着放的情况。当2x1的小矩形横着放在左上角的时候,左下角必须和横着放一个2×1的小矩形,而在右边还剩下2x6的区域,这种情形下的覆盖方法记为f(6), 因此f8)=f(7)+f(6)。此时我们可以看出,这仍然是斐波那契数列。
 
 
 */

struct Topic10 {
    
    static func fabonacci_base(n: Int) -> Int {
        if n < 2 {
            return n
        }
        return fabonacci_base(n: n - 1) + fabonacci_base(n: n - 2)
    }
    
    static func fabonacci_iterate(n: Int) -> Int {
        
        guard n > 1 else {
            return n
        }
        var first = 0
        var second = 1

        for _ in 2...n {
            second = first + second
            first = second - first
        }
        
        return second
    }
    
    // 忽略
    static func fibonacci_format(n: Int) -> Int {
        let root = sqrt(5)
        
        return Int((pow((1 + root) / 2.0, Double(n))  - pow((1 - root) / 2.0, Double(n))) / root)
    }
    
    // 尾递归
    
    static func fibonacci_recurve(n: Int) -> Int {
        return _fibonacci_recurve(n: n)
    }
    
    static func _fibonacci_recurve(n: Int, f0: Int = 0, f1: Int = 1) -> Int {
        if n == 0 {
            return f0
        }
        return _fibonacci_recurve(n: n - 1, f0: f1, f1: f0 + f1)
    }
    
    
    static func test() {
        assert(fabonacci_iterate(n: 0) == 0)
        assert(fabonacci_iterate(n: 1) == 1)
        assert(fabonacci_iterate(n: 5) == 5)
        
        assert(fibonacci_format(n: 0) == 0)
        assert(fibonacci_format(n: 1) == 1)
        assert(fibonacci_format(n: 5) == 5)
        
        assert(fibonacci_recurve(n: 0) == 0)
        assert(fibonacci_recurve(n: 1) == 1)
        assert(fibonacci_recurve(n: 5) == 5)
        
        print("Topic10 OVER")
    }
    
    static func timeTest() {
//        var time = CFAbsoluteTimeGetCurrent()
//        fabonacci_base(n: )
//        print("TIME1: \((CFAbsoluteTimeGetCurrent() - time) / 1000) ms")
        
       var  time = CFAbsoluteTimeGetCurrent()
        fabonacci_iterate(n: 60)
        print("TIME2: \((CFAbsoluteTimeGetCurrent() - time) / 1000) ms")
        
        time = CFAbsoluteTimeGetCurrent()
        fibonacci_recurve(n: 60)
        print("TIME3: \((CFAbsoluteTimeGetCurrent() - time) / 1000) ms")
    }
}
