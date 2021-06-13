//
//  16.1 交换数字.swift
//  算法
//
//  Created by Plum on 2021/6/4.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P388
 
 16.1交换数字,编写一个函数,不用临时变量,直接交换两个数(提示:91.715.736)
 
 */

struct Interview_16_1 {
    
    static func swap1() {
        
        /// 减法也一样
        var a = 2
        var b = 5
        a = a + b
        b = a - b
        a = a - b
        
        
        print("a: \(a), b: \(b)")
    }
    
    // 不限于整数
    static func swap2() {
        var a = 2
        var b = 5
        a = a ^ b
        b = a ^ b
        a = a ^ b
        
        
        print("a: \(a), b: \(b)")
    }
    
    static func test() {
        swap1()
        swap2()
        print("\(self) OVER")
    }
}
