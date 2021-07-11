//
//  17.19 消失的两个数字.swift
//  算法
//
//  Created by Plum on 2021/7/4.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P505
 
 17.19消失的两个数字。给定一个数组,包含从1到N所有的整数,但其中缺了一个。
 你能在O(N)时间内只用O(1)的空间找到它吗?
 如果是缺了两个数字呢?
 
 
 (提示:502,589、608,625,648,671,688,695,701,716)
 */

struct Interview_17_19 {
    
    
    /// 计算
    /// 计算两数之和 sum(1-n) - sum(数组) = 和
    /// 计算两个数平方之和 sum(1^2..n^2) - sum(数组^2) = 和
    /// a+b = sum
    /// a^2 + b^2 = sum
    static func test() {
        
        print("\(self) OVER")
    }
}
