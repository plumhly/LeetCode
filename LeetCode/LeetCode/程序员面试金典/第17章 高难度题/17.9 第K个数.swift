//
//  17.9 第K个数.swift
//  算法
//
//  Created by Plum on 2021/6/20.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P467
 
 17.9第k个数,有些数的素因子只有3、5、7.请设计一个算法找出第k个数。注意不是，必须有这些素因子,而是必须不包含其他的素因子,
 例如,前几个数按顺序应该是1，3，5，7，9，15，21
 
 (提示 487 507 549 590 621 659 685
 */

struct Interview_17_9 {
    
    /// 暴力法：3^k * 5^k * 7^k。k属于 0 - k,计算排序，就可以找到k值, O(K^3LogK)
    struct Solution1 {
        
    }
    
    
    // O(K^2)
    struct Solution2 {
        static func findNumber(at index: Int) -> Int? {
            
            guard index > 0 else {
                return nil
            }
            
            func add(number: Int, in queue: inout MyQueue<Int>) {
                queue.enqueue(element: number * 3)
                queue.enqueue(element: number * 5)
                queue.enqueue(element: number * 7)
            }
            
            func findMin(in queue: inout MyQueue<Int>) -> Int {
                var min = Int.max
                for item in queue.array {
                    if item < min {
                        min = item
                    }
                }
                
                queue.remove(element: min)
                
                return min
            }
            
            var que = MyQueue<Int>()
            que.enqueue(element: 1)
            
            var value: Int = 1
            for _ in 0..<index {
                value = findMin(in: &que)
                add(number: value, in: &que)
            }
            
            
            return value
        }
    }
    
    // O(K)
    struct Solution3 {
        static func findNumber(at index: Int) -> Int? {
            
            guard index > 1 else {
                return index > 0 ? index : nil
            }
            
            var q3 = MyQueue<Int>()
            var q5 = MyQueue<Int>()
            var q7 = MyQueue<Int>()
            
            q3.enqueue(element: 3)
            q5.enqueue(element: 5)
            q7.enqueue(element: 7)
            
            var result: Int = 1
            for _ in 1..<index {
                
                let value3 = q3.peek!
                let value5 = q5.peek!
                let value7 = q7.peek!
                result = min(value3, min(value5, value7))
                if result == value3 {
                    _ = q3.dequeue()
                    q3.enqueue(element: result * 3)
                    q5.enqueue(element: result * 5)
                    
                } else if result == value5 {
                    _ = q5.dequeue()
                    q5.enqueue(element: result * 5)
                    
                } else {
                    _ = q7.dequeue()
                }
                q7.enqueue(element: result * 7)
            }
            
            
            return result
        }
    }
    
    
    static func test() {
        
        assert(Solution2.findNumber(at: 1) == 1)
        assert(Solution2.findNumber(at: 7) == 21)
        assert(Solution2.findNumber(at: 11) == Solution3.findNumber(at: 11))
        
        assert(Solution2.findNumber(at: 110) == Solution3.findNumber(at: 110))
        
        print("\(self) OVER")
    }
}
