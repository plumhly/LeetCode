//
//  1.2 判断是否互为字符串重排.swift
//  算法
//
//  Created by Plum on 2020/8/1.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation


/*
 1.2 判断是否互为字符串重排
 
 给定两个字符串，请编写程序，确定其中一个字符串的字符重新排列之后，是否能变成另外一个字符串
 
 分析：
 1. 用额外空间 数组和字典
 2. 排序后对比
 */

struct Interview_1_2 {
    
    // 字典或者数组
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    struct Solution1 {
        static func canStringEqualWhenOneRearrangement(first: String, second: String) -> Bool {
            guard first.count == second.count else { return false }
            var countDic: [Character: Int] = [:]
            for value in first {
                if let count = countDic[value] {
                    countDic[value] = count + 1
                } else {
                    countDic[value] = 1
                }
            }
            
            // 遍历第二个字符
            for value in second {
                if let count = countDic[value] {
                    countDic[value] = count - 1
                } else {
                    return false
                }
            }
            
            // 检查字典是否为0
            return countDic.values.reduce(0, +) == 0
        }
    }
    
    
    // 排序后对比
    // 时间复杂度 O(NlogN)
    // 空间复杂度 O(1)
    struct Solution2 {
        static func canStringEqualWhenOneRearrangement(first: String, second: String) -> Bool {
            guard first.count == second.count else {
                return false
            }
            
            // firs排序
            let sortedfirst = first.sorted()
            
            // second排序
            let sortedSecond = second.sorted()
            
            // 双指针
            return sortedfirst == sortedSecond
        }
    }
    
    
    static func test() {
        assert(Solution1.canStringEqualWhenOneRearrangement(first: "1", second: "12") == false)
        assert(Solution1.canStringEqualWhenOneRearrangement(first: "", second: ""))
        assert(Solution1.canStringEqualWhenOneRearrangement(first: "321", second: "123"))
        assert(Solution1.canStringEqualWhenOneRearrangement(first: "351", second: "123") == false)
        print("Interview_1_2 Solution1 VOER")
        
        assert(Solution2.canStringEqualWhenOneRearrangement(first: "1", second: "12") == false)
        assert(Solution2.canStringEqualWhenOneRearrangement(first: "", second: ""))
        assert(Solution2.canStringEqualWhenOneRearrangement(first: "321", second: "123"))
        assert(Solution2.canStringEqualWhenOneRearrangement(first: "351", second: "123") == false)
        print("Interview_1_2 Solution2 VOER")
    }
}
