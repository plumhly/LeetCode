//
//  面试题19-正则表达式匹配.swift
//  LeetCode
//
//  Created by Plum on 2020/6/12.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/**
 面试题19:正则表达式匹配
 
 P124
 
 题目:请实现一个函数用来匹配包含・'和*的正则表达式。模式中的字符!表示任意一个字符,而*表示它前面的字符可以出现任意次(含0次) 在本题中,匹配是指字符串的所有字符匹配整个模式。例如,字符串"a 与模式"a.a"和"ab*ac*a"匹配,但与"a.a"和"ab*a"均不匹配。
 
 c++实现在StringOperation.m
 
 */
struct Topic19 {
    static func match(string: String, pattern: String) -> Bool {
        return matchCore(string: string, stringIndex: string.startIndex, pattern: pattern, patternIndex: pattern.startIndex)
    }
    
    static func matchCore(string: String, stringIndex: String.Index, pattern: String, patternIndex: String.Index) -> Bool {
        
        if stringIndex == string.endIndex && pattern.endIndex == patternIndex {
            return true
        } else if stringIndex == string.endIndex || patternIndex == pattern.endIndex {
            return false
        }
        
        let patternNextIndex = pattern.index(after: patternIndex)
    
        if patternNextIndex == pattern.endIndex {
            let stringDistance = string.distance(from: stringIndex, to: string.endIndex)
            
            if stringDistance == 1 {
                if string[stringIndex] == pattern[patternIndex] || pattern[patternNextIndex] == "." {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        
        if pattern[patternNextIndex] == "*" {
            if string[stringIndex] == pattern[patternIndex] || (pattern[patternIndex] == "." && stringIndex != string.endIndex) {
                return matchCore(string: string, stringIndex: string.index(after: stringIndex), pattern: pattern, patternIndex: pattern.index(patternIndex, offsetBy: 2)) || matchCore(string: string, stringIndex: string.index(after: stringIndex), pattern: pattern, patternIndex: patternIndex) || matchCore(string: string, stringIndex: stringIndex, pattern: pattern, patternIndex: pattern.index(patternIndex, offsetBy: 2))
            } else {
                return matchCore(string: string, stringIndex: stringIndex, pattern: pattern, patternIndex: pattern.index(patternIndex, offsetBy: 2))
            }
        } else {
            if string[stringIndex] == pattern[patternIndex] || pattern[patternIndex] == "." {
                return matchCore(string: string, stringIndex: string.index(after: stringIndex), pattern: pattern, patternIndex: pattern.index(after: patternIndex))
            } else {
                return false
            }
        }
    }
    
    static func test() {
        
        assert(match(string: "", pattern: "a*"))
        assert(match(string: "aaa", pattern: "a.a"))
        assert(match(string: "aaa", pattern: "ab*ab*a"))
        print("Topic19 OVER")
    }
}
