//
//  17.4 消失的数字.swift
//  算法
//
//  Created by Plum on 2021/6/15.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation
/*
 P453
 
 17.4 消失的数字。数组A包含从0到n的所有整数,但其中缺了一个。在这个问题中,只用一次操作无法取得数组A里某个整数的完整内容此外,数组A的元素皆以二进制表示,
 唯一可用的访问操作是“从A[i]中取出第j位数据”,该操作的时间复杂度为常量。请编写代码找出那个缺失的整数。你有办法在O(n)时间内完成吗?
 
 (提示:1609,658,682)
 */

struct Interview_17_4 {
    
    static func findMissingNumber(in array: [Int]) -> Int? {
        guard array.count > 0 else {
            return nil
        }
        return findMissingNumber(in: array, column: 0)
    }
    
    
    static func findMissingNumber(in array: [Int], column: Int) -> Int {
        guard column < Int.bitWidth else {
            return 0
        }
        
        var zeroSize: [Int] = []
        var oneSize: [Int] = []
        
        for item in array {
            if (item >> column) & 1 == 0 {
                zeroSize.append(item)
            } else {
                oneSize.append(item)
            }
        }
        
        if zeroSize.count <= oneSize.count {
            // 移除当前的指定位非0的数字
            let v = findMissingNumber(in: zeroSize, column: column + 1)
            return (v << 1) | 0
        } else {
            let v = findMissingNumber(in: oneSize, column: column + 1)
            return (v << 1) | 1
        }
    }
    
    static func test() {
        
        assert(findMissingNumber(in: [0, 1, 2, 4]) == 3)
        
        print("\(self) OVER")
    }
}
