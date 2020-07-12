//
//  面试题61-扑克牌中的顺子.swift
//  LeetCode
//
//  Created by Plum on 2020/7/9.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题61:扑克牌中的顺子
 
 P298
 
 题目:从扑克牌中随机抽5张牌,判断是不是一个顺子,即这5张牌是不是连续的。2~10为数字本身,A为1,J为11,Q为12,K为13,而大、小王可以看成任意数字。
 */
struct Topic61 {
    static func isContinuous(array: [Int]) -> Bool {
        guard !array.isEmpty else {
            return false
        }
        
        var array = array
        // 排序
        array.sort()
        
        // 看0的个数
        let numberOfZero = array.filter { $0 == 0 }.count
        var numberOfGap = 0
        var small = numberOfZero
        var big = small + 1
        while big < array.count {
            if array[small] == array[big] {
                return false
            }
            numberOfGap = array[big] - (array[small] + 1)
            small += 1
            big += 1
        }
        return numberOfZero >= numberOfGap
    }
    
    static func test() {
        let a = [2, 4, 5, 0 , 0]
        assert(isContinuous(array: a) == true)
        
        let b = [1, 2, 3, 0 ,0]
        assert(isContinuous(array: b))
        
        let c = [1, 3, 3, 2, 4]
        assert(isContinuous(array: c) == false)
        
        let d = [1, 2 ,3 ,4 ,5]
        assert(isContinuous(array: d))
        
        print("Topic61 OVER")
    }
}
