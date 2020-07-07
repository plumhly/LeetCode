//
//  面试题20-表示数值的字符串.swift
//  LeetCode
//
//  Created by Plum on 2020/6/13.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题20:表示数值的字符串
 
 P127
 
 表示数值的字符串遵循模式A.[ Blleec]或者.BcEC],其中A为数值的整数部分,B紧跟着小数点为数值的小数部分,C紧跟着e或者E为数值的指数部分。在小数里可能没有数值的整数部分。例如,小数.123等于0.123。
 因此A部分不是必需的。如果一个数没有整数部分,那么它的小数部分不能为空。
 
 
 
 */

struct Topic20 {
    static func isNumber(string: String) -> Bool {
        guard !string.isEmpty else {
            return false
        }
        var index = string.startIndex
        var isNumber = scanInteger(string: string, index: &index)
        if index < string.endIndex, string[index] == "." {
            index = string.index(after: index)
            // 这里用 或 运算，是因为 isNumber 为false,可能是因为.23的情况
            isNumber = scanUsignInteger(string: string, index: &index) || isNumber
        }
        
        // e只能在小数点后面，科学技术法
        if index < string.endIndex, ["e", "E"].contains(string[index]) {
            index = string.index(after: index)
            isNumber = scanInteger(string: string, index: &index) && isNumber
        }
        return isNumber && index == string.endIndex
    }
    
    static func scanInteger(string: String, index: inout String.Index) -> Bool {
        if string[index] == "+" || string[index] == "-" {
            index = string.index(after: index)
        }
        return scanUsignInteger(string: string, index: &index)
    }
    
    static func scanUsignInteger(string: String, index: inout String.Index) -> Bool {
        
        let tempIndex = index
        let charZeroAssciValue = Character("0").asciiValue!
        let charnineAssciValue = Character("9").asciiValue!
        while index < string.endIndex, let assc1 = string[index].asciiValue, assc1 >= charZeroAssciValue, let assc2 = string[index].asciiValue, assc2 <= charnineAssciValue {
            index = string.index(after: index)
        }
        return string.distance(from: tempIndex, to: index) > 0
    }
    
    
    static func test() {
        assert(isNumber(string: "") == false)
        assert(isNumber(string: "1") == true)
        assert(isNumber(string: ".2") == true)
        assert(isNumber(string: "-.2") == true)
        assert(isNumber(string: "+1") == true)
        assert(isNumber(string: "1.3") == true)
        assert(isNumber(string: "+10.2e10") == true)
        assert(isNumber(string: "+1.2e-10") == true)
        assert(isNumber(string: "+1.2e-10c") == false)
        print("Topic20 OVER")
    }
}
