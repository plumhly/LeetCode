//
//  16.2 单词频率.swift
//  算法
//
//  Created by Plum on 2021/6/4.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P389
 
 16.2单词频率,设计一个方法,找出任指词在一本书中的出现率,如果我们多次使
 用此方法,应该怎么办?(提示:#488, #535)
 */

struct Interview_16_2 {
    
    static func setupDictionary(from book: [String]) -> [String: Int] {
        var dic: [String: Int] = [:]
        
        for string in book {
            if !string.trimmingCharacters(in: CharacterSet(charactersIn: "")).isEmpty {
                let key = string.lowercased()
                if let value = dic[key] {
                    dic[key] = value + 1
                } else {
                    dic[key] = 1
                }
            }
        }
        
        return dic
    }
    
    static func test() {
        
        print("\(self) OVER")
    }
}
