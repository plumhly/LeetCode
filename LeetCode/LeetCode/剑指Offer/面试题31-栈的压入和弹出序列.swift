//
//  面试题31-栈的压入和弹出序列.swift
//  LeetCode
//
//  Created by Plum on 2020/6/19.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题31:栈的压入、弹出序列
 
 P167
 
 题目:输入两个整数序列,第一个序列表示栈的压入顺序,请判断第二个序列是否为该栈的弹出顺序。假设压入機的所有数字均不相等。例如, 序列{1,2,3,4,5}是某栈的压栈序列,序列{45,321}是该压栈序列对应的一个弹出序列,但{4,3,5,1,2}就不可能是该压栈序列的弹出序列。
 */

struct Topic31 {
    static func isPopOrder(input: [Int], out: [Int]) -> Bool {
        guard input.count == out.count else {
            return false
        }
        
        var stack = Stack<Int>()
        
        var inIndex = 0
        var outIndex = 0
        
        while outIndex < out.count {
            if stack.isEmpty || stack.peek() != out[outIndex] {
                if inIndex >= input.count {
                    return false
                }
                stack.push(value: input[inIndex])
                inIndex += 1
            } else {
                // 不为空，且相等
                outIndex += 1
                _ = stack.pop()
            }
        }
        
        return stack.isEmpty
    }
    
    static func test() {
        let inArray = [1, 2, 3, 4, 5]
        let out1 = [4 , 5 ,3 ,2 ,1]
        let out2 = [5, 4, 3, 2, 1]
        let out3 = [5, 4, 3, 1, 2]
        
       let inArray1 = [1, 1, 1, 1, 1]
        let out4 = [1, 1, 1, 1, 1]
        
        assert(isPopOrder(input: inArray, out: out1))
        assert(isPopOrder(input: inArray, out: out2))
        assert(isPopOrder(input: inArray, out: out3) == false)
        assert(isPopOrder(input: inArray1, out: out4))
        print("Topic31 OVER")
    }
}
