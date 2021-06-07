//
//  1.4 回文排列.swift
//  算法
//
//  Created by Plum on 2020/8/2.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation


/*
 1.4 回文排列
 
 给定一个字符串，编写一个函数判断其是否为某个回文串的排列之一，回文串是指正反两个方向都一样的单词或者短语，排列是指字母的重新排列，回文串不一定是字典当中的单词。
 实例：
    输入： Tact Coa
    输出：true (toco cat)
 
 
分析：
 1. 要满足回文串，那么至多有2个字符只出现一次
    a. 1 个字符串出现单次，其他字符串出现双次
    b. 2 个字符出现单次，其中一个是" ", 其他字符出现双次
 */

struct Interview_1_4 {
    
    // 字典法
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    struct Solution1 {
        static func isBeARecycleStringComponent(str: String) -> Bool {
            guard !str.isEmpty else {
                return false
            }
            
            var resultDic: [Character : Int] = [:]
            for value in str.lowercased() {
                if let count = resultDic[value] {
                    resultDic[value] = count + 1
                } else {
                    resultDic[value] = 1
                }
            }
            
            // 这里牺牲了一些性能，因为全部遍历的字典
            let keys = resultDic.filter { $0.value % 2 == 1 }.map { $0.key }
            
            //
//            var keys: [Character] = []
//            for pair in resultDic {
//                if pair.value % 2 == 1 {
//                    if keys.count < 2 {
//                        keys.append(pair.key)
//                    } else {
//                        return false
//                    }
//                }
//
//            }
            
            return keys.count == 1 || keys.contains(" ")
        }
    }
    
    // 位向量法（）
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    struct Solution2 {
        static func isBeARecycleStringComponent(str: String) -> Bool {
            guard !str.isEmpty else {
                return false
            }
            
            var bitMap = BitMap(size: 128)
            str.lowercased().forEach { value in
                let asciiValue = Int(value.asciiValue!)
                if bitMap.contains(asciiValue) {
                    bitMap.remove(asciiValue)
                } else {
                    bitMap.add(asciiValue)
                }
            }
            
            var sum = 0
            let blankAsciiValue = Int(Character(" ").asciiValue!)
            for value in bitMap {
                sum += value
                if sum > 2 {
                    return false
                }
            }
            return sum < 2 || bitMap.value(blankAsciiValue) == 1
        }
    }
    
    static func test() {
        assert(Solution1.isBeARecycleStringComponent(str: "") == false)
        assert(Solution1.isBeARecycleStringComponent(str: "a"))
        assert(Solution1.isBeARecycleStringComponent(str: "a "))
        assert(Solution1.isBeARecycleStringComponent(str: " a "))
        assert(Solution1.isBeARecycleStringComponent(str: "aabc") == false)
        assert(Solution1.isBeARecycleStringComponent(str: "Tact Coa"))
        print("Interview_1_4 Solution1 OVER")
        
        assert(Solution2.isBeARecycleStringComponent(str: "") == false)
        assert(Solution2.isBeARecycleStringComponent(str: "a"))
        assert(Solution2.isBeARecycleStringComponent(str: "a "))
        assert(Solution2.isBeARecycleStringComponent(str: " a "))
        assert(Solution2.isBeARecycleStringComponent(str: "aabc") == false)
        assert(Solution2.isBeARecycleStringComponent(str: "Tact Coa"))
        print("Interview_1_4 Solution2 OVER")
    }
}
