//
//  8.5 递归乘法.swift
//  算法
//
//  Created by Plum on 2021/4/10.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 8.5递归乘法。写一个递归函数,不使用运算符,实现两个正整数的相乘。可以使用加号、
 减号、位移,但要吝啬一些。(提示:#166,#203,#227,#234,#246,#280)
 */

struct Interview_8_5 {
    struct Solution1 {
        static func miniProduct(a: Int, b: Int) -> Int {
            let smaller = min(a, b)
            let bigger = max(a, b)
            return miniProductHelper(smaller: smaller, bigger: bigger)
        }
        
        static func miniProductHelper(smaller: Int, bigger: Int) -> Int {
            if smaller == 0 {
                return 0
            } else if(smaller == 1) {
                return bigger
            }
            
            let half = smaller >> 1
            let result1 = miniProductHelper(smaller: half, bigger: bigger)
            var result2 = result1
            if (smaller % 2 == 1) {
                result2 = miniProductHelper(smaller: smaller - half, bigger: bigger)
            }
            
            return result1 + result2
        }
    }
    
    struct Solution2 {
        static func miniProduct(a: Int, b: Int) -> Int {
            let smaller = min(a, b)
            let bigger = max(a, b)
            var result: [Int: Int] = [:]
            return miniProductHelper(smaller: smaller, bigger: bigger, resultDic: &result)
        }
        
        static func miniProductHelper(smaller: Int, bigger: Int, resultDic: inout [Int: Int]) -> Int {
            if smaller == 0 {
                return 0
            } else if(smaller == 1) {
                return bigger
            } else if let res = resultDic[smaller] {
                return res
            }
            
//            let half = smaller >> 1
//            var result1 = 0
//            if let sum = resultDic[half] {
//                result1 = sum
//            } else {
//                result1 = miniProductHelper(smaller: half, bigger: bigger, resultDic: &resultDic)
//                resultDic[half] = result1
//            }
//            var result2 = result1
//            if (smaller % 2 == 1) {
//                if let sum = resultDic[smaller - half] {
//                    result2 = sum
//                } else {
//                    result2 = miniProductHelper(smaller: smaller - half, bigger: bigger, resultDic: &resultDic)
//                    resultDic[smaller - half] = result2
//                }
//            }
            
            let half = smaller >> 1
            let result1 = miniProductHelper(smaller: half, bigger: bigger, resultDic: &resultDic)
            var result2 = result1
            if (smaller % 2 == 1) {
                result2 = miniProductHelper(smaller: smaller - half, bigger: bigger, resultDic: &resultDic)
            }
            
            return result1 + result2
        }
    }
    
    struct Solution3 {
        static func miniProduct(a: Int, b: Int) -> Int {
            let smaller = min(a, b)
            let bigger = max(a, b)
            return miniProductHelper(smaller: smaller, bigger: bigger)
        }
        
        static func miniProductHelper(smaller: Int, bigger: Int) -> Int {
            if smaller == 0 {
                return 0
            } else if(smaller == 1) {
                return bigger
            }
            
            let half = smaller >> 1
            var result1 = miniProductHelper(smaller: half, bigger: bigger)
            if (smaller % 2 == 1) {
                result1 = result1 + result1 + bigger
            } else {
                result1 += result1
            }
            
            return result1
        }
    }
    
    static func test() {
        assert(Solution1.miniProduct(a: 1, b: 0) == 0)
        assert(Solution1.miniProduct(a: 1, b: 2) == 2)
        assert(Solution1.miniProduct(a: 5, b: 3) == 15)
        assert(Solution1.miniProduct(a: 3, b: 3) == 9)
        
        
        assert(Solution2.miniProduct(a: 1, b: 0) == 0)
        assert(Solution2.miniProduct(a: 1, b: 2) == 2)
        assert(Solution2.miniProduct(a: 5, b: 3) == 15)
        assert(Solution2.miniProduct(a: 3, b: 3) == 9)
        
        assert(Solution3.miniProduct(a: 1, b: 0) == 0)
        assert(Solution3.miniProduct(a: 1, b: 2) == 2)
        assert(Solution3.miniProduct(a: 5, b: 3) == 15)
        assert(Solution3.miniProduct(a: 3, b: 3) == 9)
        
        print("Interview_8_5 over")
        
    }
}
