//
//  1.5 一次编辑.swift
//  算法
//
//  Created by Plum on 2020/8/3.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 1.5 一次编辑
 
 字符串中有三种操作：插入、删除、替换一个字符串。给定两个字符串，编写一个函数判断他们是否需要一次（或者0次）编辑
 
 */

struct Interview_1_5 {
    struct Solution1 {
        static func isOnlyEditLessThanOneCanMekeTwoStringSame(str1: String, str2: String) -> Bool {
            guard isLengthSatisfied(str1, str2) else {
                return false
            }
            
            // round 1
            // 字符长度一样
            // 那么双指针同时移动，比较完字符串只有一个不一样
//            var differenceCount = 0
//            if str1.count == str2.count {
//                for i in 0..<str1.count {
//                    let str1Index = str1.index(str1.startIndex, offsetBy: i)
//                    let str2Index = str2.index(str2.startIndex, offsetBy: i)
//                    if str1[str1Index] != str2[str2Index] {
//                        differenceCount += 1
//                        if differenceCount > 1 {
//                            break
//                        }
//                    }
//                }
//            } else {
//                // 字符长度不一样
//                let smallerStr: String
//                let longerStr: String
//                if str1.count > str2.count {
//                    smallerStr = str2
//                    longerStr = str1
//                } else {
//                    smallerStr = str1
//                    longerStr = str2
//                }
//                
//                var smallIndex = smallerStr.startIndex
//                var longIndex = longerStr.startIndex
//                while smallIndex < smallerStr.endIndex, longIndex < longerStr.endIndex {
//                    if smallerStr[smallIndex] != longerStr[longIndex] {
//                        differenceCount += 1
//                        if differenceCount > 1 {
//                            break
//                        }
//                        
//                        // 如果不相等，尝试寻找长的字符串的下一个
//                        longIndex = longerStr.index(after: longIndex)
//                    } else {
//                        smallIndex = smallerStr.index(after: smallIndex)
//                        longIndex = longerStr.index(after: longIndex)
//                    }
//                }
//                if differenceCount <= 1 {
//                    if smallIndex < smallerStr.endIndex {
//                        let distance = smallerStr.distance(from: smallIndex, to: smallerStr.index(before: smallerStr.endIndex))
//                        differenceCount += distance
//                    }
//                    
//                    if longIndex < longerStr.endIndex {
//                        let distance = smallerStr.distance(from: longIndex, to: longerStr.index(before: smallerStr.endIndex))
//                        differenceCount += distance
//                    }
//                }
//                
//            }
//            return differenceCount <= 1
            
            // round 2
            // 分析， 只有短字符是长字符的子集时，短字符才先遍历完，其他时候都是长字符遍历完
            
            let smallerStr = str1.count > str2.count ? str2 : str1
            let longerStr = str1.count > str2.count ? str1 : str2
            
            var smallIndex = smallerStr.startIndex
            var longIndex = longerStr.startIndex
            
            var findDifferentValue = false
            
            while smallIndex < smallerStr.endIndex, longIndex < longerStr.endIndex {
                if smallerStr[smallIndex] != longerStr[longIndex] {
                    if findDifferentValue {
                        return false
                    }
                    findDifferentValue = true
                    if smallerStr.count == longerStr.count {
                        smallIndex = smallerStr.index(after: smallIndex)
                    }
                } else {
                  smallIndex = smallerStr.index(after: smallIndex)
                }
                longIndex = longerStr.index(after: longIndex)
            }
            
            return true
        }
        
        static func isLengthSatisfied(_ str1: String, _ str2: String) -> Bool {
            return abs(str1.count - str2.count) <= 1
        }
    }
    
    static func test() {
        assert(Solution1.isOnlyEditLessThanOneCanMekeTwoStringSame(str1: "pale", str2: "ple"))
        assert(Solution1.isOnlyEditLessThanOneCanMekeTwoStringSame(str1: "pales", str2: "pale"))
        assert(Solution1.isOnlyEditLessThanOneCanMekeTwoStringSame(str1: "pale", str2: "bale"))
        assert(Solution1.isOnlyEditLessThanOneCanMekeTwoStringSame(str1: "pale", str2: "pale"))
        assert(Solution1.isOnlyEditLessThanOneCanMekeTwoStringSame(str1: "pale", str2: "bake") == false)
        assert(Solution1.isOnlyEditLessThanOneCanMekeTwoStringSame(str1: "pale", str2: "be") == false)
        print("Interview_1_5 Solution1 OVER")
    }
}
