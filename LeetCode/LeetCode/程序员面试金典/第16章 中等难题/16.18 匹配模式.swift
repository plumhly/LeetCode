//
//  16.8 匹配模式.swift
//  算法
//
//  Created by Plum on 2021/6/12.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P422
 
 5.18模式匹配,你有两个字符串,即 pattern和valve pattern字符由字母a和b组成
 用于描述字符串中的模式,例如,字符串catcatgocatego匹配模式 aabab(其中cat是a,go是b)。
 该字符串也匹配像a、ab和b这样的模式,编写一个方法判断value字符串是否匹配pattern字符串。
 
 */

struct Interview_16_18 {
    
    
    /// 暴力法
    struct Solution1 {
        
    }
    
    struct Solution2 {
        static func isMatch(value: String, pattern: String) -> Bool {
            guard pattern.count > 0, pattern.count <= value.count else {
                return value.count == pattern.count
            }
            
            guard value.count > 0 else {
                return pattern.count < 2
            }
            
            // pattern第一个开始的字符个数
            let mainChar = pattern.first!
            let altChar = mainChar == Character("a") ? Character("b") : Character("a")
            
            let mainCharCount = lengthOf(item: mainChar, in: pattern)
            let altCharCount = pattern.count - mainCharCount
            
            let mainCharMaxSize = value.count / mainCharCount
            
            /// 也就是前面几个mainChar
            let firstAltCharIndex = pattern.firstIndex(of: altChar)
            
            for mainSize in 1 ... mainCharMaxSize {
                let remainSize = value.count - mainSize * mainCharCount
                // 判断alt能否被整除
                if altCharCount == 0 || remainSize % altCharCount == 0 {
                    
                    let mainStartIndex = value.startIndex
                    
                    /*-1*/
                    let mainEndIndex = value.index(mainStartIndex, offsetBy: mainSize - 1)
                    let mianItem = String(value[mainStartIndex...mainEndIndex]) // string.index为闭区间
                    
                    var altItem = ""
                    // 找打alt代表的字符串
                    if let firstAltIndex = firstAltCharIndex {
                        let preMainCount = pattern.distance(from: pattern.startIndex, to: firstAltIndex)
                        
                        let altSize = remainSize / altCharCount
                        let altStartIndex = value.index(value.startIndex, offsetBy: preMainCount * mainSize)
                        
                        /*-1*/
                        let altEndIndex = value.index(altStartIndex, offsetBy: altSize - 1)
                        
                        altItem = String(value[altStartIndex...altEndIndex])
                        
                    }
                    
                    if value == judgeMatch(pattern: pattern, main: mianItem, alt: altItem) {
                        return true
                    }
                }
            }
            
            return false
        }
        
        private static func judgeMatch(pattern: String, main: String, alt: String) -> String {
            var result = ""
            let mainChar = pattern.first!
            for item in pattern {
                result.append(item == mainChar ? main : alt)
            }
            
            return result
        }
        
        private static func lengthOf(item: Character, in pattern: String) -> Int {
            return pattern.filter {$0 == item}.count
        }
    }
    
    static func test() {
        
        do {
            assert(Solution2.isMatch(value: "", pattern: "") == true)
            assert(Solution2.isMatch(value: "f2", pattern: "") == false)
            assert(Solution2.isMatch(value: "f2", pattern: "a") == true)
            assert(Solution2.isMatch(value: "f2", pattern: "b") == true)
            assert(Solution2.isMatch(value: "f2", pattern: "ab") == true)
            assert(Solution2.isMatch(value: "f2", pattern: "ba") == true)
            assert(Solution2.isMatch(value: "f2", pattern: "baa") == false)
            assert(Solution2.isMatch(value: "catcatgocatgo", pattern: "aabab") == true)
        }
        
        print("\(self) OVER")
    }
}
