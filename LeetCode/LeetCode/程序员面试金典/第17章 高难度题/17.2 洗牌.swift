//
//  17.2 洗牌.swift
//  算法
//
//  Created by Plum on 2021/6/15.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation
/*
 P451
 
 
 17.2洗牌。设计一个用来洗牌的函数。要求做到完美洗牌,也就是说,这副牌52!种排列组合
 出现的概率相同。假设给定一个完美的随机数发生器。(提示:#482,#578,#633)
 */

struct Interview_17_2 {
    
    static func shuffle(array: [Int]) -> [Int] {
        func shuffle(array: inout [Int], index: Int) {
            guard index > 0 else {
                return
            }
            
            shuffle(array: &array, index: index - 1)
            let rand = Int.random(in: 0...index)
            
            array.swapAt(index, rand)
        }
        
        func random(low: Int, high: Int) -> Int {
            return Int.random(in: low...high)
        }
        
        guard array.count > 0 else {
            return array
        }
        
        var array = array
        shuffle(array: &array, index: array.count - 1)
        
        return array
    }
    
    static func shuffle2(array: [Int]) -> [Int] {
        var array = array
        for index in 0 ..< array.count {
            let random = Int.random(in: 0...index)
            array.swapAt(random, index)
        }
        
        return array
    }
    
    static func test() {
        
        print(shuffle(array: [1, 2, 3]))
        print(shuffle2(array: [1, 2, 3]))
        print("\(self) OVER")
    }
}
