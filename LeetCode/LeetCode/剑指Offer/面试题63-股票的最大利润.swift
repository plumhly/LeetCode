//
//  面试题63-股票的最大利润.swift
//  LeetCode
//
//  Created by Plum on 2020/7/10.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题63:股票的最大利润
 
 P304
 
 题目:假设把某股票的价格按照时间先后顺序存储在数组中,请问买卖该股票一次可能获得的最大利润是多少?例如,一只股票在某些时间节点的价格为{9,11,8,5,7,12,16,14号。如果我们能在价格为5的时候买入并在价格为16时卖出,则能收获最大的利润11
 
 分析：
 1.蛮力法： 时间复杂度O(n^2)
 
 2.也就是说,如果在扫描到数组中的第i个数字时,只要我们能够记住之前的1个数字中的最小值,就能算出在当前价位卖出时可能得到
 */

struct Topic63 {
    static func maxDiff(values: [Int]) -> Int {
        guard values.count > 1 else {
            return 0
        }
        
        var min = values[0]
        var maxDiff = values[1]
        for i in 2..<values.count {
            let value = values[i]
            if value < min {
                min = value
            }
            let diff = value - min
            if diff > maxDiff {
                maxDiff = diff
            }
        }
        return maxDiff
    }
    
    static func test() {
        let a = [9, 11, 8, 5, 7, 12, 16, 14]
        assert(maxDiff(values: a) == 11)
        print("Topic63 OVER")
    }
}
