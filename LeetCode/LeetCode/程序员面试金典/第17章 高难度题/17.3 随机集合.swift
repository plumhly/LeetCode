//
//  17.3 随机集合.swift
//  算法
//
//  Created by Plum on 2021/6/15.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P452
 
 17.3随机集合。编写一个方法,从大小为n的数组中随机选出m个整数。要求每个元素被选
 中的概率相同。(提示:#493,#595)
 */

struct Interview_17_3 {
    
    
    static func randomSequence(array: [Int], length: Int) -> [Int]? {
        
        func randomSeqence(array: [Int], length: Int, index: Int, result: inout [Int]) {
            guard index + 1  > length else {
                result.append(contentsOf: array[..<length])
                return
            }
            
            randomSeqence(array: array, length: length, index: index - 1, result: &result)
            
            let random = Int.random(in: 0...index)
            if random < length {
                result[random] = array[index]
            }
        }
        
        guard array.count > length else {
            return nil
        }
        
        var result: [Int] = []
        randomSeqence(array: array, length: length, index: array.count - 1, result: &result)
        
        return result
    }
    
    static func randomSequence2(array: [Int], length: Int) -> [Int]? {
        guard array.count > length else {
            return nil
        }
        
        var result = Array(array[0..<length])
        
        for index in length..<array.count {
            let random = Int.random(in: 0...index)
            if random < length {
                result[random] = array[index]
            }
        }
        
        return result
    }
    
    static func test() {
        
        print(randomSequence(array: [1, 2, 3, 4, 5, 6, 7, 8, 9], length: 4))
        print(randomSequence2(array: [1, 2, 3, 4, 5, 6, 7, 8, 9], length: 4))
        
        print("\(self) OVER")
    }
}
