//
//  1.9 字符串轮转.swift
//  算法
//
//  Created by Plum on 2020/8/8.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 1.9 字符串轮转
 
 假定有一个isSubstring的方法，可以检查一个单词是否是另外一个单词的子串。给定两个字符串s1和s2，请编写一个算法检查s2是否是s1旋转而成，要求只能调用一次
 isSubstring。（比如 waterbottle是erbottlewat旋转后的字符串）
 */

/*
 自我思考：
 1. 寻找分割点
 
 总结：
 可以考虑两个s1拼成新的字符串，s1s1, 也就是 xyxy，那么s2 = yx，是他们的子串
 */

struct Interview_1_9 {
    
    // 👣足迹
    /*
    struct Solution1 {
        static func isRotateString(str1: String, str2: String) -> Bool {
            guard str1.count == str2.count, !str1.isEmpty else {
                return false
            }
            
            if str1 == str2, isAllSame(str: str1) {
                return true
            }
            
            // 寻找分割点
            var str1Index = str1.startIndex
            var str2Index = str2.startIndex
            
            var separationIndex = str1Index
            
            while str1Index < str1.endIndex {
                if str1[str1Index] == str2[str2Index] {
                    str1Index = str1.index(after: str1Index)
                    str2Index = str2.index(after: str2Index)
                } else {
                    str1Index = str1.index(after: separationIndex)
                    separationIndex = str1Index
                    str2Index = str2.startIndex
                }
            }
            
            if str1Index == str1.endIndex, str2Index == str2.endIndex {
                // 表示找到了分割点
            }
        }
        
        static func isAllSame(str: String) -> Bool {
        
            let sterial = str.first!
            var isAllSame = true
            for value in str {
                if value != sterial {
                    isAllSame = false
                    break
                }
            }
            return isAllSame
        }
    }
    */
    
    struct Solution1 {
        static func isRotateString(str1: String, str2: String) -> Bool {
            guard str1.count == str2.count, !str1.isEmpty else {
                return false
            }
            
            let newString = str1 + str1
            return newString.contains(str2)
        }
    }
    
    static func test() {
        assert(Solution1.isRotateString(str1: "", str2: "") == false)
        assert(Solution1.isRotateString(str1: "a", str2: "a"))
        assert(Solution1.isRotateString(str1: "waterbottle", str2: "erbottlewat"))
        assert(Solution1.isRotateString(str1: "afb", str2: "d") == false)
        print("Interview_1_9 Solution1 OVER")
    }
}
