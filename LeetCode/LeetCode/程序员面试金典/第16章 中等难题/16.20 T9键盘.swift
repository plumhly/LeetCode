//
//  File.swift
//  算法
//
//  Created by Plum on 2021/6/12.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 T9键盘,在老式手机上,用户通过数字键盘输入,手机将提供与这些数字相配的单词列表。每个数字映射到0至4个字母,给定一个数字序列,实现一个算法来返回匹配单词的列表,
 你会得到一张含有有效单词的列表(存储你想要的任何数据结构)映射如下图所示
    
    示例:
        输入:8733
        输出:tree,used
 (提示:470,=486,653,*702,725743)
 */

struct Interview_16_20 {
    
    static let charSets: [[Character]] = [[], [], ["a", "b", "c"], ["d", "e", "f"], ["g", "h", "i"],  ["j", "k", "l"], ["m", "n", "o"], ["p", "q", "r", "s"], ["t", "u", "v"], ["w", "x", "y", "z"],]
    
    // O(4^N), N = input.cout
    struct Solution1 {
        
        static func printValidWorld(input: [Int], wordMap: [String: String]) -> [String] {
            guard input.count > 0 else {
                return []
            }
            
            var result: [String] = []
            iterate(input: input, index: 0, value: "", result: &result, wordMap: wordMap)
            
            return result
        }
        
        static func iterate(input: [Int], index: Int, value: String, result: inout [String], wordMap: [String: String]) {
            if index == input.count, let _ = wordMap[value]  {
                result.append(value)
                return
            }
            
            for char in charSets[input[index]] {
                var value = value
                value.append(char)
                
                iterate(input: input, index: index + 1, value: value, result: &result, wordMap: wordMap)
            }
        }
    }
    
    struct Solution2 {
        // 在递归方法使用Trie，判断但是的开始组成部分，是否有对应的单词
    }
    
    /// 将单词转成number序列
    struct Solution3 {
        
        static func printValidWorld(input: String, wordMap: [String: String]) -> [String] {
            
            /// 移除input中的 0 1
            
            let wordMap = getMap()
            return wordMap[input] ?? []
        }
        
        static func getMap() -> [String: [String]] {
            let charMap = getCharMap()
            
            let allWords: [String] = []
            
            var result: [String : [String]] = [:]
            
            for word in allWords {
                let key = changeStringToT9(value: word, charMap: charMap)
                if var list = result[key] {
                    list.append(word)
                    result.updateValue(list, forKey: key)
                } else {
                    result[key] = [word]
                }
            }
            
            return result
        }
        
        static func changeStringToT9(value: String, charMap: [Character: Character]) -> String {
            var result = ""
            for item in value where charMap[item] != nil {
                result.append(charMap[item]!)
            }
            
            return result
        }
        
        static func getCharMap() -> [Character: Character] {
            var result: [Character : Character] = [:]
            
            for (index, values) in charSets.enumerated() {
                for char in values {
                    result[char] = Character("\(index)")
                }
            }
            
            return result
        }
        
    }
    
    static func test() {
        
        print("\(self) OVER")
    }
}
