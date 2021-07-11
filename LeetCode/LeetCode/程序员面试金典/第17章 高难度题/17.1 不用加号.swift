//
//  17.1 不用加号.swift
//  算法
//
//  Created by Plum on 2021/6/15.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P450
 
 17.1不用加号的加法。设计一个函数把两个数字相加。不得使用+或者其他算术运算符
 
 (提示:#466,#543,#600 #627,641,#663,#691,#711,#723)
 */

struct Interview_17_1 {
    
    static func add(a: Int, b: Int) -> Int {
        guard b > 0 else {
            return a
        }
        
        let sum = a ^ b
        let carry = a & b << 1
        return add(a: sum, b: carry)
    }
    
    /// 递推
    static func add2(a: Int, b: Int) -> Int {
        guard b > 0 else {
            return a
        }
        var a = a
        var b = b
        while b != 0 {
            let sum = a ^ b
            let carry = a & b << 1
            a = sum
            b = carry
        }
        
        return a
    }
    
    static func test() {
        
        assert(add(a: 1, b: 2) == 3)
        assert(add2(a: 1, b: 2) == 3)
        print("\(self) OVER")
    }
}
