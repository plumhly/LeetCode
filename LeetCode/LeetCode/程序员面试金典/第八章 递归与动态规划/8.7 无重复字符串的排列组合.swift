//
//  8.7 无重复字符串的排列组合.swift
//  算法
//
//  Created by Plum on 2021/4/17.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P298
 
 8.7无重复字符串的排列组合。编写一种方法,计算某字符串的所有排列组合,字符串每个
 字符均不相同。(提示:#150,#185,#200,#267,#278,#309,#335,#356)
 */

struct Interview_8_7 {
    
    struct Solution1 {
        static func getPers(str: String) -> [String] {
            
            guard str.count > 1 else {
                return [str]
            }
            
            // 第一个字符
            let firsChar = str.first!
            
            // 剩下的
            let substring = str[str.index(after: str.startIndex)...]
            
            let preResult = getPers(str: String(substring))
            
            var result: [String] = []
            
            for item in preResult {
                for position in 0...item.count {
                    var i = item
                    let index = item.index(item.startIndex, offsetBy: position)
                    i.insert(firsChar, at: index)
                    result.append(i)
                }
            }
            
            return result
        }
    }
    
    struct Solution2 {
        static func getPers(str: String) -> [String] {
            
            guard str.count > 1 else {
                return [str]
            }
            
            var result: [String] = []
            // 移除一个字符，作为子串
            for i in 0..<str.count {
                var temp = str
                let index = str.index(str.startIndex, offsetBy: i)
                let char = temp.remove(at: index)
                
                for var item in getPers(str: temp) {
                    item.insert(char, at: item.startIndex)
                    result.append(item)
                }
                
            }
            
            return result
        }
    }
    
    
    static func test() {
        let f = "a"
        assert(Solution1.getPers(str: f) == ["a"])
        print(Solution1.getPers(str: "ab"))
        print(Solution1.getPers(str: "abc"))
        
        assert(Solution2.getPers(str: f) == ["a"])
        print(Solution2.getPers(str: "ab"))
        print(Solution2.getPers(str: "abc"))
        
        print("Interview_8_7 Over")
    }
}
