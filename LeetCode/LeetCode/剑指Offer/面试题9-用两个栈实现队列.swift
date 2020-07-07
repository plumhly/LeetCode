//
//  面试题9-用两个栈实现队列.swift
//  LeetCode
//
//  Created by Plum on 2020/6/2.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

struct Topic9 {
    struct Queue_S<T> {
        var leftStack: Stack<T>
        var rightStack: Stack<T>
        
        init() {
            leftStack = Stack<T>()
            rightStack = Stack<T>()
        }
        
        mutating func dequeue() -> T? {
            if rightStack.isEmpty {
                while !leftStack.isEmpty {
                    if let value = leftStack.pop() {
                        rightStack.push(value: value)
                    }
                }
            }
            return rightStack.pop()
        }
        
        mutating func enqueue(value: T) {
            leftStack.push(value: value)
        }
    }
    
    struct Stack_Q<T> {
        var leftQueue: Queue<T>
        var rightQueue: Queue<T>
        
        init() {
            leftQueue = Queue<T>()
            rightQueue = Queue<T>()
        }
        
        mutating func pop() -> T? {
            if rightQueue.isEmpty {
                while leftQueue.size != 1 {
                    if let value = leftQueue.dequeue() {
                        rightQueue.enqueue(element: value)
                    }
                }
                return leftQueue.dequeue()
            } else if leftQueue.isEmpty {
                while rightQueue.size != 1 {
                    if let value = rightQueue.dequeue() {
                        leftQueue.enqueue(element: value)
                    }
                }
                return rightQueue.dequeue()
            }
            return nil
        }
        
        mutating func push(value: T) {
            if leftQueue.isEmpty {
                rightQueue.enqueue(element: value)
            } else if rightQueue.isEmpty {
                leftQueue.enqueue(element: value)
            }
            
        }
    }
    
    static func test() {
        print("-----Queue-----")
        
        var queue = Queue_S<Int>()
        queue.enqueue(value: 1)
        queue.enqueue(value: 2)
        queue.enqueue(value: 3)
        
        assert(queue.dequeue() == 1)
        assert(queue.dequeue() == 2)
        assert(queue.dequeue() == 3)
        
        print("-----Stack-----")
        
        var stack = Stack_Q<Int>()
        stack.push(value: 1)
        stack.push(value: 2)
        stack.push(value: 3)
        
        assert(stack.pop() == 3)
        assert(stack.pop() == 2)
        assert(stack.pop() == 1)
        
        print("-----Topic9 OVER-----")
    }
}
