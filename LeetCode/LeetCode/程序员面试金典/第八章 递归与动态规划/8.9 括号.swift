//
//  8.9 括号.swift
//  算法
//
//  Created by Plum on 2021/5/8.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 p302
 
 8.9括号。设计一种算法,打印n对括号的所有合法的(例如,开闭一一对应)组合
 示例:
 输入:3
 输出:((())),(()()),(())(),()(()),()()()
 (提示:#138,#174,#187,#209,#243,#265,#295)
 
 */

struct Interview_8_9 {
    static func printParen(count: Int) -> [String] {
        guard count > 0 else {
            return []
        }
        
        var result: [String] = []
        addParen(container: &result, left: count, right: count, str: "")
        
        return result
    }
    
    static func addParen(container: inout [String], left: Int, right: Int, str: String) {
        
        guard left >= 0, left <= right else {
            return
        }
        
        if left == 0 && right == 0 {
            container.append(str)
            return
        }
        
        if left > 0 {
            var str = str
            str.append("(")
            addParen(container: &container, left: left - 1, right: right, str: str)
        }
        
        if right > 0 {
            var str = str
            str.append(")")
            addParen(container: &container, left: left, right: right - 1, str: str)
        }
    }
    
    static func test() {
        let result1 = printParen(count: 1)
        print(result1)
        
        let result2 = printParen(count: 2)
        print(result2)
        
        let result3 = printParen(count: 3)
        print(result3)
        
        print("Interview_8_9 OVER")
    }
}
