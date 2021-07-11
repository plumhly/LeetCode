//
//  17.11 单词距离.swift
//  算法
//
//  Created by Plum on 2021/6/21.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation
/*
 P
 
 17.11单词距离。有个内含单词的超大文本文件,给定任意两个单词,找出在这个文件中这两个单词的最短距离(相隔单词数)。
 如果寻找过程在这个文件中会重复多次,而每次寻找的单词不同,你能对此优化吗?
 
 (提示:485 500 537 557 632)
 */

struct Interview_17_11 {
    
    struct Solution {
        static func findMinDistance(in words: [String], w1: String, w2: String) -> Int? {
            guard words.count > 1 else {
                return nil
            }
            
            var minDistance = Int.max
            var w1Lcoation: Int? = nil
            var w2Lcoation: Int? = nil
            for (index, word) in words.enumerated() {
                if word == w1 {
                    w1Lcoation = index
                    if let w2Local = w2Lcoation, abs(index - w2Local) < minDistance {
                        minDistance = abs(index - w2Local)
                    }
                } else if word == w2 {
                    w2Lcoation = index
                    if let w1Local = w1Lcoation, abs(index - w1Local) < minDistance {
                        minDistance = abs(index - w1Local)
                    }
                }
            }
            
            return minDistance == Int.max ? nil : minDistance
        }
    }
    
    struct Advance {
        static func findMinDistance(in words: [String], w1: String, w2: String) -> Int? {
            let getMap = constructMap(in: words)
            
            
            guard let w1List = getMap[w1], let w2List = getMap[w2] else {
                return nil
            }
            
            return findMinDistance(w1IndexList: w1List as! [Int], w2IndexList: w2List as! [Int])
        }
        
        private static func constructMap(in words: [String]) -> [String: NSArray] {
            var result: [String: NSMutableArray] = [:]
            for (index, word) in words.enumerated() {
                if let values = result[word] {
                    values.add(index)
                } else {
                    let array = NSMutableArray()
                    array.add(index)
                    result[word] = array
                }
            }
            
            return result
        }
        
        private static func findMinDistance(w1IndexList: [Int], w2IndexList: [Int]) -> Int? {
            guard w1IndexList.count > 1, w2IndexList.count > 1 else {
                return nil
            }
            
            var w1Index = 0
            var w2Index = 0
            var min = Int.max
            
            while w1Index < w1IndexList.count, w2Index < w2IndexList.count {
                let w1Location = w1IndexList[w1Index]
                let w2Location = w2IndexList[w2Index]
                let distance = abs(w1Location - w2Location)
                if distance < min {
                    min = distance
                }
                
                if w1Location < w1Location {
                    w1Index += 1
                } else {
                    w2Index += 1
                }
            }
            
            return min
        }
    }
    
    
    static func test() {
        
        print("\(self) OVER")
    }
}
