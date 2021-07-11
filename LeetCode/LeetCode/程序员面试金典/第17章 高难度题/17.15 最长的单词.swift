//
//  17.15 最长的单词.swift
//  算法
//
//  Created by Plum on 2021/6/29.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P488
 
 17.15最长单词。给定一组单词,编写一个程序,找出其中的最长单词,且该单词由这组单词中的其他单词组合而成。

 示例:
    输入:cat, banana,dog,nana,walk, walker, dogwalker
    输出: dogwalker
 (提示:#474,#498,#542,#588)
 */

struct Interview_17_15 {
    
    struct Solution1 {
        static func findMaxLengthString(in array: [String]) -> String? {
            guard array.count > 1 else {
                return nil
            }
            
            let array = array.sorted { $0.count > $1.count }
            var container: [String: Bool] = [:]
            for item in array {
                container[item] = true
            }
            
            var result: String? = nil
            
            for item in array {
                // 如果是由两个单词组成，那么可以这样判断： map[left], map[right]
                if judge(value: item, map: &container, isOriginalString: true) {
                    result = item
                    break
                }
            }
            
            return result
        }
        
        private static func judge(value: String, map: inout [String: Bool], isOriginalString: Bool) -> Bool {
            if !isOriginalString, let resultValue = map[value] {
                return resultValue
            }

            var result = false
            
            for index in value.indices {
                let left = String(value[...index])
                let rightIndex = value.index(after: index)
                let right = String(value[rightIndex...])
                if let isContain = map[left], isContain, judge(value: right, map: &map, isOriginalString: false) {
                    result = true
                    break
                }
            }
            
            map[value] = result
            
            return result
        }
    }
    
    
    static func test() {
        
        let a = ["cat", "banana","dog","nana","walk", "walker", "dogwalker"]
        assert(Solution1.findMaxLengthString(in: a) == "dogwalker")
        
        print("\(self) OVER")
    }
}
