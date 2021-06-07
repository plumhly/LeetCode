//
//  8.8 重复字符串的排列组合 .swift
//  算法
//
//  Created by Plum on 2021/4/17.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P300
 
 8.8重复字符串的排列组合。编写一种方法,计算字符串所有的排列组合,字符串中可能有
 字符相同,但结果不能有重复组合。(提示:#161,#190,#222,#255)
 */

struct Interview_8_8 {
    static func getPers(str: String) -> [String] {
        var result: [String] = []
        let map = getCharMap(str: str)
        getResult(perfix: "", map: map, remain: str.count, result: &result)
        return result
    }
    
    static func getCharMap(str: String) -> [Character : Int] {
        var result: [Character: Int] = [:]
        for item in str {
            if let count = result[item] {
                result[item] = count + 1
            } else {
                result[item] = 1
            }
        }
        
        return result
    }
    
    static func getResult(perfix: String, map: [Character: Int], remain: Int, result: inout [String]) {
        guard remain > 0 else {
            result.append(perfix)
            return
        }
        
        var map = map
        for item in map {
            if item.value > 0 {
                map.updateValue(item.value - 1, forKey: item.key)
                /// 当前charactor作为前面
                var perfix = perfix
                perfix.append(item.key)
                getResult(perfix: perfix, map: map, remain: remain - 1, result: &result)
                map.updateValue(item.value, forKey: item.key)
            }
        }
    }
    
    
    static func test() {
        
        print(getPers(str: "aba"))
        
        print(getPers(str: "abb"))
        
        print("Interview_8_8 OVER")
    }
}
