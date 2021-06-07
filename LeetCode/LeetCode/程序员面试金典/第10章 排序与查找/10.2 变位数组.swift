//
//  10.2 变位数组.swift
//  算法
//
//  Created by Plum on 2021/5/29.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P333
 
 10.2变位词组。编写一种方法,对字符串数组进行排序,将所有变位词排在相邻的位置。
 (提示:#177,#182,#263,#342)
 */

/**
 * 只是把变位词放在一起
 * 解决办法
 * 1. 重写comparator函数，将单词排查后，查看是否相同，相同即为变位词
 * 2. 用[string: [string]], 其中key是sort后的字符串
 */
struct Interview_10_2 {
    
    
    static func test() {
        
    }
}
