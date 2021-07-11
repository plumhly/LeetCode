//
//  17.10 主要元素.swift
//  算法
//
//  Created by Plum on 2021/6/21.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P472
 
 17.10主要元素,如果数组中多一半的数都是同一个,则称之为主要元素给定一个正数数组,
 找到它的主要元素,若没有,返回-1,要求时间复杂度为O(N).空间复杂度为O(1)

 示例:
    输入:1 2 5 9 5 9 5 5 5
    输出:5
 (提示:521 565 603.619.649)
 */

struct Interview_17_10 {
    
    static func findMainElement(in array: [Int]) -> Int? {
        func findMajor(in array: [Int]) -> Int {
            var count = 0
            var major = 0
            for item in array {
                if count == 0 {
                    major = item
                }
                if item == major {
                    count += 1
                } else {
                    count -= 1
                }
            }
            
            return major
        }
        
        func validate(value: Int, in array: [Int]) -> Bool {
            var count = 0
            for item in array {
                if item == value {
                    count += 1
                }
            }
            
            return count > array.count / 2
        }
        
        let value = findMajor(in: array)
        
        return validate(value: value, in: array) ? value : nil
    }
    
    
    
    static func test() {
        
        let a = [1, 2, 5, 9, 5, 9, 5, 5, 5]
        assert(findMainElement(in: a) == 5)
        
        print("\(self) OVER")
    }
}
