//
//  17.13恢复空格.swift
//  算法
//
//  Created by Plum on 2021/6/23.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation
/*
 P480
 
 17.13恢复空格。哦,不!你不小心把一个长篇文章中的空格、标点都删掉了,并且大写也弄成了小写。
 像句子“I reset the computer. It still didn't' boot!”已经变成了“iresetthecomputeritstilldidntboot”。
 在处理标点符号和大小写之前,你得先把它断成词语。当然了,你有一本厚厚的词典,用一个 string的集合表示。不过,有些词没在词典里。
 假设文章用 string表示,设计一个算法,把文章断开,要求未识别的字符最少。
 
 示例:
    输入: Jesslookedjustliketimherbrother
    输出: jess looked just like tim her brother(7个未识别的字符)
 (提示:#495,#622,#655,#676,#738,#748)

 */

struct Interview_17_13 {
    
    /// O(2^N)
    struct Solution1 {
        struct ParseResult {
            var sentence: String
            var inValidCount: Int
        }
        
        static func parse(sentence: String) -> ParseResult? {
            guard sentence.count > 0 else {
                return nil
            }
            
            return parse(parseSet: [], sentence: sentence, start: sentence.startIndex)
        }
        
        private static func parse(parseSet: Set<String>, sentence: String, start: String.Index) -> ParseResult? {
            
            guard start < sentence.endIndex else {
                return nil
            }
            
            var index = start
            var bestInvalid = Int.max
            var resultString = ""
            
            while index < sentence.endIndex {
                let string = String(sentence[start...index])
                
                let inValidCount = parseSet.contains(string) ? 0 : string.count
                
                if inValidCount < bestInvalid {
                    if let nextResult = parse(parseSet: parseSet, sentence: sentence, start: string.index(after: start)) {
                        let currentInvalidCount = nextResult.inValidCount + inValidCount
                        if currentInvalidCount < bestInvalid {
                            bestInvalid = currentInvalidCount
                            resultString = string + "" + nextResult.sentence
                        }
                        if bestInvalid == 0 {
                            break
                        }
                    }
                }
                
                index = string.index(after: index)
            }
            
            return resultString.isEmpty ? nil : ParseResult(sentence: resultString, inValidCount: bestInvalid)
        }
    }
    
    /// O(N^2)
    struct Solution2 {
        struct ParseResult {
            var sentence: String
            var inValidCount: Int
        }
        
        static func parse(sentence: String) -> ParseResult? {
            guard sentence.count > 0 else {
                return nil
            }
            var mem: [String.Index: ParseResult] = [:]
            return parse(parseSet: [], sentence: sentence, start: sentence.startIndex, mem: &mem)
        }
        
        private static func parse(parseSet: Set<String>, sentence: String, start: String.Index, mem: inout [String.Index: ParseResult]) -> ParseResult {
            
            guard start < sentence.endIndex else {
                return ParseResult(sentence: "", inValidCount: 0)
            }
            
            if let result = mem[start] {
                return result
            }
            
            var index = start
            var bestInvalid = Int.max
            var resultString = ""
            
            while index < sentence.endIndex {
                let string = String(sentence[start...index])
                
                let inValidCount = parseSet.contains(string) ? 0 : string.count
                
                if inValidCount < bestInvalid {
                    let nextResult = parse(parseSet: parseSet, sentence: sentence, start: string.index(after: start), mem: &mem)
                    let currentInvalidCount = nextResult.inValidCount + inValidCount
                    if currentInvalidCount < bestInvalid {
                        bestInvalid = currentInvalidCount
                        resultString = string + "" + nextResult.sentence
                    }
                    if bestInvalid == 0 {
                        break
                    }
                }
                
                index = string.index(after: index)
            }
            
            let result: ParseResult
            if resultString.isEmpty {
                result = ParseResult(sentence: "", inValidCount: 0)
            } else {
                result = ParseResult(sentence: resultString, inValidCount: bestInvalid)
            }
            
            mem[start] = result
            
            return result
        }
    }
    
    
    static func test() {
        
        print("\(self) OVER")
    }
}
