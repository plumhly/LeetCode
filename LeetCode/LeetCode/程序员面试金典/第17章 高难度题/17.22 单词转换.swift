//
//  17.22 单词转换.swift
//  算法
//
//  Created by Plum on 2021/7/9.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P515
 
 17.22单词转换。给定字典中的两个词,长度相等。写一个方法,把一个词转换成另一个词，但是一次只能改变一个字符。每一步得到的新词都必须能在字典中找到
 
 示例:
  输入:DAMP,LIKE
  输出:DAMP -> LAMP -> LIMP -> LIME -> LIKE
 
 (提示:#505,534 555 579 597 617 737)

 */

struct Interview_17_22 {
    
    struct Solution1 {
        static func transform(start: String, stop: String, words: Set<String>) -> [String]? {
            
            guard start.count == stop.count, start.count > 0 else {
                return nil
            }
            
            var visited: Set<String> = []
            return transform(start: start, stop: stop, words: words, visited: &visited)
        }
        
        private static func transform(start: String, stop: String, words: Set<String>, visited: inout Set<String>) -> [String]? {
            guard words.contains(start), !visited.contains(start) else {
                return nil
            }
            
            if stop == start {
                return [start]
            }
            
            visited.insert(start)
            
            let changedWords = wordChangeOneCharactor(start: start)
            
            for word in changedWords {
                if var tempResult = transform(start: word, stop: stop, words: words, visited: &visited) {
                    tempResult.insert(start, at: 0)
                    return tempResult
                }
            }
            
            return nil
        }
        
        private static func wordChangeOneCharactor(start: String) -> [String] {
            let aCode = Character("a").asciiValue!
            let letters: [Character] = (0..<26).map {
                i in Character(UnicodeScalar(aCode + i))
            }
            
            var result: [String] = []
            for index in start.indices {
                for c in letters {
                    let distance = start.distance(from: index, to: start.startIndex)
                    let s = replace(myString: start, distance, c)
                    result.append(s)
                }
            }
            
            return result
        }
        
        private static func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
            var chars = Array(myString)     // gets an array of characters
            chars[index] = newChar
            let modifiedString = String(chars)
            return modifiedString
        }
    }
    
    struct Solution2 {
        static func transform(start: String, stop: String, words: Set<String>) -> [String]? {
            
            guard start.count == stop.count, start.count > 0 else {
                return nil
            }
            
            var visited: Set<String> = []
            let dicInfo = createWildCardInfo(from: words)
            return transform(start: start, stop: stop, words: dicInfo, visited: &visited)
        }
        
        private static func transform(start: String, stop: String, words: [String: [String]], visited: inout Set<String>) -> [String]? {
            guard !visited.contains(start) else {
                return nil
            }
            
            if stop == start {
                return [start]
            }
            
            visited.insert(start)
            
            let wordCards = createWordCard(start: start)
            
            for card in wordCards {
                if let values = words[card] {
                    for value in values where value != start {
                        if var tempResult = transform(start: value, stop: stop, words: words, visited: &visited) {
                            tempResult.insert(start, at: 0)
                            return tempResult
                        }
                    }
                }
            }
            
            return nil
        }
        
        private static func createWildCardInfo(from words: Set<String>) -> [String: [String]] {
            var result: [String: [String]] = [:]
            
            for word in words {
                for index in word.indices {
                    let distance = word.distance(from: index, to: word.startIndex)
                    let wordCard = replace(myString: word, distance, Character("_"))
                    
                    if var r = result[wordCard] {
                        r.append(word)
                        result[wordCard] = r
                    } else {
                        result[wordCard] = [word]
                    }
                }
            }
            
            return result
        }
        
        private static func createWordCard(start: String) -> [String] {
            
            var result: [String] = []
            for index in start.indices {
                let distance = start.distance(from: index, to: start.startIndex)
                let s = replace(myString: start, distance, Character("_"))
                result.append(s)
            }
            
            return result
        }
        
        private static func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
            var chars = Array(myString)     // gets an array of characters
            chars[index] = newChar
            let modifiedString = String(chars)
            return modifiedString
        }
    }
    
    /// 广度优先
    struct Solution3 {
        
    }
    
    static func test() {
        
        print("\(self) OVER")
    }
}
