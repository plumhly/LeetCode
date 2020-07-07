//
//  printMatrixClockwise(d).swift
//  LeetCode
//
//  Created by Plum on 2020/6/19.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题30:包含min函数的栈
 
 P165
 
 题目:定义栈的数据结构,请在该类型中实现一个能够得到栈的最小元素的min函数。在该栈中,调用min、push及pop的时间复杂度都是O(1)
 
 分析：是不是可以把每次的最小元素(之前的最小元素和新压入栈的元素两者的较小值)都保存起来放到另外一个辅助栈里呢?我们不妨举几个例子来分析一下把元素压入或者弹出栈的过程,如表4.1所示。
 */

struct Topic30 {
    struct MinStack {
        var dataStack = Stack<Int>()
        var minStack = Stack<Int>()
        var minvalue: Int = Int.max
        
        mutating func pop() -> Int? {
            if dataStack.size > 0 {
                _ = minStack.pop()
                return dataStack.pop()
            } else {
                return nil
            }
        }
        
        mutating func push(value: Int)  {
            if value < minvalue {
                minvalue = value
            }
            dataStack.push(value: value)
            minStack.push(value: minvalue)
        }
        
        mutating func min() -> Int? {
            if !minStack.isEmpty {
                return minStack.peek()
            } else {
                return nil
            }
        }
    }
    
    static func test() {
        
        var stack = MinStack()
        
        assert(stack.min() == nil)
        
        stack.push(value: 4)
        assert(stack.min() == 4)
        
        stack.push(value: 2)
        assert(stack.min() == 2)
        
        stack.push(value: 3)
        assert(stack.min() == 2)
        
        stack.pop()
        stack.pop()
        
        assert(stack.min() == 4)
        
        print("Topic30 OVER")
    }
}
