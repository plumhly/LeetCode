//
//  面试题21-调整数组顺序使奇数位于偶数前面.swift
//  LeetCode
//
//  Created by Plum on 2020/6/14.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题21:调整数组顺序使奇数位于偶数前面
 使得所有奇教位于数组的前半部分,所有偶数位于数组的后半部分。く题目:输入一个整数数组,实现一个函数来调整该数组中数字的顺序
 
 P129
 
 双指针法，
 
 */
struct Topic21 {
    static func reoder(array: inout [Int], compare: (Int) -> Bool) {
        guard array.count > 1 else {
            return
        }
        
        var start = 0
        var end = array.count - 1
        
        while start < end {
            
            while compare(array[start]) {
                start += 1
            }
            
            while start < end, !compare(array[end]) {
                end -= 1
            }
            
            if start < end {
                array.swapAt(start, end)
            }
            
        }
    }
    
    static func reorderOddEven(array: inout [Int]) {
        reoder(array: &array) { $0 & 1 != 0 }
    }
    
    static func test() {
        var a = [1, 2, 3, 4]
        reorderOddEven(array: &a)
        assert(a == [1, 3, 2, 4])
        
        var b: [Int] = []
        reorderOddEven(array: &b)
        assert(b == [])
        
        var c = [1, 3, 2, 4]
        reorderOddEven(array: &c)
        assert(c == [1, 3, 2, 4])
        
        var d = [2, 4, 1, 3]
        reorderOddEven(array: &d)
        assert(d == [3, 1, 4, 2])
        
        print("Topic21 OVER")
    }
}
