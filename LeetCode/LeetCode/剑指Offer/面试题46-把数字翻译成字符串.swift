//
//  面试题46-把数字翻译成字符串.swift
//  LeetCode
//
//  Created by Plum on 2020/6/28.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题46:把数字翻译成字符串
 
 P231
 
 题目:给定一个数字,我们按照如下规则把它翻译为字符串:0翻译成“a"”,1翻译成“b”,…,11翻译成“1"”,…,25翻译成“z”。一个数字可能有多个翻译。例如,12258有5种不同的翻译,分别是“bcf”、“bwf”“bczi”、“mef”和“mzi”。请编程实现一个函数,用来计算一个数字有多少种不同的翻译方法
 */

struct Topic46 {
    static func translateCount(value: Int) -> Int {
        return translate(str: "\(value)")
    }
    
    static func translate(str: String) -> Int {
        var result = Array<Int>(repeating: 0, count: str.count)
        let zeroAsciiValue = Character("0").asciiValue!
        for i in str.indices.reversed() {
            var count = 0
            let index = str.distance(from: str.startIndex, to: i)
            if i < str.index(before: str.endIndex) {
                count = result[index + 1]
            } else {
                count = 1
            }
            
            if i < str.index(before: str.endIndex) {
                let min = str[str.index(after: i)].asciiValue! - zeroAsciiValue
                let max = str[i].asciiValue! - zeroAsciiValue
                let combination = max * 10 + min
                
                if combination >= 10, combination <= 25 {
                    if i < str.index(str.endIndex, offsetBy: -2) {
                        /// ⚠️这里之所以要找index + 2，是因为当前两位数可以被翻译，那么存在开始是两位数的翻译方式，需要加上index+2的结果
                        count += result[index + 2]
                    } else {
                        // 1是最后一个字符的组合情况
                        count += 1
                    }
                    
                }
            }
            result[index] = count
        }
        return result[0]
    }
    
    static func test() {
        assert(translateCount(value: 1) == 1)
        assert(translateCount(value: 12258) == 5)
        print( "Topic46 OVER ")
    }
}
