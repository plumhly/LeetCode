//
//  1.1 判定字符是否唯一.swift
//  算法
//
//  Created by Plum on 2020/7/30.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation


/*
 判定字符是否唯一。
 实现一个算法。确定一个字符串中的所有字符是否全都不相同，假设不能使用额外空间，该如何处理
 
 分析：
 1. 暴力法 O(N^2)
 2. 用map存储字符中的元素 时间复杂度 O(N)， 空间 O(N)
 
 */
struct Interview_1_1 {
    // 暴力法
    // 时间复杂度 O(n^2)
    // 空间复杂度 O(1)
    struct Solution1 {
        static func isNotContainSameCharactor(in string: String) -> Bool {
            var isNotContain = true
            for i in 0..<string.count {
                let firstIndex = string.index(string.startIndex, offsetBy: i)
                let next = i + 1
                for j in next..<string.count {
                    let secondIndex = string.index(string.startIndex, offsetBy: j)
                    if string[firstIndex] == string[secondIndex] {
                        isNotContain = false
                        return isNotContain
                    }
                }
            }
            return isNotContain
        }
    }
    
    // 字典法
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    struct Solution2 {
        static func isNotContainSameCharactor(in string: String) -> Bool {
            var set: Set<Character> = []
            var isNotContain = true
            for value in string {
                if set.contains(value) {
                    isNotContain = false
                    break
                }
                set.insert(value)
            }
            return isNotContain
        }
    }
    
    // 位向量 1
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    struct Solution3 {
        static func isNotContainSameCharactor(in string: String) -> Bool {
            var bitmap = BitMap(size: 128)
            var isNotContain = true
            for value in string {
                let asciiValue = value.asciiValue!
                if bitmap.contains(Int(asciiValue)) {
                    isNotContain = false
                    break
                }
                bitmap.add(Int(asciiValue))
            }
            return isNotContain
        }
    }
    
    // 位向量 2, 假设只有26个之母
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    struct Solution4 {
        static func isNotContainSameCharactor(in string: String) -> Bool {
            guard string.count <= 26 else {
                return false
            }
            var checker: Int32 = 0
            let startAsciiValue = Character("a").asciiValue!
            for value in string {
                let asciiValue = value.asciiValue!
                let distance = asciiValue - startAsciiValue
                if (checker & (1 << distance)) > 0 {
                    return false
                }
                checker |= 1 << distance
            }
            return true
        }
    }
    
    
    static func test() {
        assert(Solution1.isNotContainSameCharactor(in: "1bcsd") == true)
        assert(Solution1.isNotContainSameCharactor(in: "1bcsd1") == false)
        assert(Solution1.isNotContainSameCharactor(in: "1") == true)
        print("Interview_1_1 Solution1 OVER")
        
        assert(Solution2.isNotContainSameCharactor(in: "1bcsd") == true)
        assert(Solution2.isNotContainSameCharactor(in: "1bcsd1") == false)
        assert(Solution2.isNotContainSameCharactor(in: "1") == true)
        assert(Solution2.isNotContainSameCharactor(in: "") == true)
        print("Interview_1_1 Solution2 OVER")
        
        
        assert(Solution3.isNotContainSameCharactor(in: "1bcsd") == true)
        assert(Solution3.isNotContainSameCharactor(in: "1bcsd1") == false)
        assert(Solution3.isNotContainSameCharactor(in: "1") == true)
        assert(Solution3.isNotContainSameCharactor(in: "") == true)
        print("Interview_1_1 Solution3 OVER")
        
        assert(Solution4.isNotContainSameCharactor(in: "abcsd") == true)
        assert(Solution4.isNotContainSameCharactor(in: "abcsda") == false)
        assert(Solution4.isNotContainSameCharactor(in: "a") == true)
        print("Interview_1_1 Solution4 OVER")
        
    }
}
