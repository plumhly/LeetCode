//
//  面试题62-圆圈中最后剩下的数字.swift
//  LeetCode
//
//  Created by Plum on 2020/7/9.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题62-圆圈中最后剩下的数字
 
 P300
 
 题目:0,1,…n-1这n个数字排成一个圆圈,从数字0开始,每次从这圆圈里删除第m个数字。求出这个圆圈里剩下的最后一个数字
 
 */

struct Topic62 {
    struct Solution1 {
        static func lastRemain(n: Int, m: Int) -> Int? {
            guard n > 0, m > 0 else {
                return nil
            }
            
            var array = Array(0..<n)
            var currentIndex = 0
            while array.count > 1 {
                for _ in 1..<m {
                    currentIndex += 1
                    if currentIndex == array.count {
                        currentIndex = 0
                    }
                }
                array.remove(at: currentIndex)
                // ***
                if currentIndex == array.count {
                    currentIndex = 0
                }
            }
            return array.first
        }
        
        static func test() {
            assert(lastRemain(n: 5, m: 3) == 3)
            
            assert(lastRemain(n: 7, m: 5) == 5)
            print("Topic62 Solution1 OVERE")
        }
    }
    
    /*
     
     分析
     ：
     302
     */
    
    struct Solution2 {
        static func lastRemain(n: Int, m: Int) -> Int? {
            guard n > 0, m > 0 else {
                return nil
            }
            
            var last = 0
            for i in 2...n {
                last = (last + m) % i
            }
            return last
        }
        
        static func test() {
            assert(lastRemain(n: 5, m: 3) == 3)
                       
            assert(lastRemain(n: 7, m: 5) == 5)
            print("Topic62 Solution2 OVERE")
        }
    }
}
