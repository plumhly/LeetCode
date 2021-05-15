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
 

 8.12八皇后。设计一种算法,打印八皇后在8×8棋盘上的各种摆法,其中每个皇后都不同行、
 不同列,也不在对角线上。这里的“对角线”指的是所有的对角线,不只是平分整个棋
 盘的那两条对角线。(提示:#308,#350,#371)
 8.13堆箱子给你一堆n个箱子,箱子宽w高h、深d。箱子不能翻转,将箱子堆起来时,
 下面箱子的宽度、高度和深度必须大于上面的箱子。实现一种方法,搭出最高的一堆箱子。
 箱堆的高度为每个箱子高度的总和。(提示:#155,#194,#214,#260,#322,#368,#378)
 8.14布尔运算给定一个布尔表达式和一个期望的布尔结果 result,布尔表达式由e、1、&、
 和符号组成。实现一个函数,算出有几种可使该表达式得出 result值的括号方法。
 该表达式要用全括号(如()^(1))表示,而不能包含半括号(如(()^(1))
 示例:
  counteval("1el1", false)->2
  counteval(e&ee&^le",true)->10
 (提示:#148,#168,#197,#305,#327)

 
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
