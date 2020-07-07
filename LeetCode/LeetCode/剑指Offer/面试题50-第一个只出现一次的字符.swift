//
//  面试题50-第一个只出现一次的字符.swift
//  LeetCode
//
//  Created by Plum on 2020/7/1.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题50:第一个只出现一次的字符
 
 P243
 
 在字符串中找出第一个只出现一次的字符。如输入" abaccdeff'",则输出b。
 */

struct Topic50 {
    struct Topic1 {
        static func firstNotRepeatChar(str: String) -> Character? {
            guard !str.isEmpty else {
                return nil
            }
            var charDic: [Character: Int] = [:]
            for i in str {
                if var count = charDic[i] {
                    count += 1
                    charDic[i] = count
                } else {
                    charDic[i] = 1
                }
            }
            
            var result: Character? = nil
            for i in str {
                if let count = charDic[i], count == 1 {
                    result = i
                    break
                }
            }
            return result
        }
        
        static func test() {
            let str = "abaccdeft"
            assert(firstNotRepeatChar(str: str) == Character("b"))
            print("Topic1 test")
        }
    }
    
    /*题目二:字符流中第一个只出现一次的字符。
     
     请实现一个函数,用来找出字符流中第一个只出现一次的字符。例如,当从字符流中只读出前两个字符"go"时,第一个只出现一次的字符是g;当从该字符流中读出前6个字符" google"时,第一个只出现一次的字符是"。
     
     分析：字符只能一个接着一个从字符流中读出来。可以定义一个数据容器来保存字符在字符流中的位置。当一个字符第一次从字符流中读出来时,把它在字符流中的位置保存到数据容器里。当这个字符再次从字符流中读出来时,那么它就不是只出现一次的字符,也就可以被忽略了。这时把它在数据容器里保存的值更新成一个特殊的值(如负数值)
     */
    
    struct Topic2 {
        enum Flag: Int {
            case valid  = -1
            case invalid = -2
        }
        var result: [Int]
        var characters: [Character]
        init() {
            result = Array<Int>(repeating: -1, count: 256)
            characters = []
        }
        
        mutating func insert(char: Character) {
            let index = Int(char.asciiValue!)
            
            // 表示没有重复
            if result[index] == Flag.valid.rawValue {
                result[index] = characters.count
            } else if result[index] >= 0 {
                result[index] = Flag.invalid.rawValue
            }
            
            characters.append(char)
            
        }
        
        func findFirst() -> Character? {
            if characters.isEmpty {
                return nil
            }
            var minIndex = Int.max
            (0..<256).forEach { index in
                if result[index] >= 0, result[index] < minIndex {
                    minIndex = result[index]
                }
            }
            return characters[minIndex]
        }
        
        static func test() {
            var t2 = Topic50.Topic2()
            assert(t2.findFirst() == nil)
            
            t2.insert(char: Character("g"))
            t2.insert(char: Character("o"))
            assert(t2.findFirst() == Character("g"))
            
            t2.insert(char: Character("o"))
            t2.insert(char: Character("g"))
            t2.insert(char: Character("l"))
            t2.insert(char: Character("e"))
            assert(t2.findFirst() == Character("l"))
            
            
            print("Topic2 OVER")
        }
    }
}
