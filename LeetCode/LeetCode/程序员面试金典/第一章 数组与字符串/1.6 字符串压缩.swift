//
//  1.6 字符串压缩.swift
//  算法
//
//  Created by Plum on 2020/8/4.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 1.6 字符串压缩
 
 利用字符串重复出现的次数，编写一种方法，实现基本的字符串压缩功能。比如字符串 aabbcc 会变为a2b2c2, 若压缩之后的字符串没有变短，这返回原先的字符串。你可以假设字符串只包含大小写英文字母（a-z）
 */
struct Interview_1_6 {
    struct Solution1 {
        static func compressString(_ str: String) -> String {
            guard !str.isEmpty else { return str }
            
            var result = ""
            var count = 1
            var preChar: Character? = nil
            for value in str {
                if preChar == nil {
                    preChar = value
                    continue
                }
                if value == preChar! {
                    count += 1
                } else {
                    result.append(preChar!)
                    result.append(Character("\(count)"))
                    
                    // 这里可以提前返回
                    if result.count >= str.count {
                        return str
                    } else {
                        count = 1
                        preChar = value
                    }
                }
            }
            
            if let pre = preChar {
                result.append(pre)
                result.append(Character("\(count)"))
            }
            
            return result.count < str.count ? result : str
        }
    }
    
    static func test() {
        assert(Solution1.compressString("") == "")
        assert(Solution1.compressString("abc") == "abc")
        assert(Solution1.compressString("aaabbbccc") == "a3b3c3")
        assert(Solution1.compressString("aaabbbccCCCC") == "a3b3c2C4")
        print("Interview_1_6 Solution1 OVER")
    }
}
