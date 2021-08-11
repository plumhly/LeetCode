//
//  面试题 67 写一个string转Int的方法.swift
//  LeetCode
//
//  Created by Plum on 2020/7/11.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题 67 写一个string转Int的方法
 */

struct Topic67 {
    static func stringToInt(str: String) -> Int? {
        // 排除空字符
        guard !str.isEmpty else {
            return nil
        }
        
        // 排除非法字符, + - 在有数是后面是正常的字符
        let max = Character("9").asciiValue!
        let min = Character("0").asciiValue!
        var index = str.startIndex
        
        let isSign = [Character("+"), Character("-")].contains(str[index])
        // 判断是否只有 + -
        if str.count == 1, isSign {
            return nil
        }
        
        // 判断符号，
        
        let isMinus = str[index] == Character("-")
        if isSign {
            index = str.index(after: index)
        }
        
        var number = 0
        while index < str.endIndex {
            let value = str[index].asciiValue!
            if value >= min, value <= max {
                
                // 考虑溢出
                let isValid: Bool
                if isMinus {
                    
                    /// ⚠️ 因为number要被赋值  Int(number * 10) - Int(value - min) >= Int.min
                    /// 转化后就是 （Int.min + Int(value - min)）/ 10 >= number, 下边同理
                    isValid = (Int.min + Int(value - min)) / 10 <= number
                    if isValid {
                        number = Int(number * 10) - Int(value - min)
                    }
                } else {
                    isValid = (Int.max - (Int(value - min))) / 10 >= number
                    if isValid {
                        number = Int(number * 10) + Int(value - min)
                    }
                }
                
                if !isValid {
                    return nil
                }
                
                // 修改
                index = str.index(after: index)
            } else {
                return nil
            }
        }
        
        return number
    }
    
    
    static func test() {
        assert(stringToInt(str: "") == nil)
        assert(stringToInt(str: "abc") == nil)
        assert(stringToInt(str: "+") == nil)
        assert(stringToInt(str: "-") == nil)
        assert(stringToInt(str: "1") == 1)
        assert(stringToInt(str: "+1") == 1)
        assert(stringToInt(str: "-1") == -1)
        assert(stringToInt(str: "-1304") == -1304)
        assert(stringToInt(str: String(Int.max)) == Int.max)
        assert(stringToInt(str: String(Int.min)) == Int.min)
        
        assert(stringToInt(str: "9223372036854775808") == nil)
        assert(stringToInt(str: "-9223372036854775809") == nil)
        print("Topic67 VOER")
    }
}
