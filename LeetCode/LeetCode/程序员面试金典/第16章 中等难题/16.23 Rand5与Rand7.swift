//
//  16.26 Round5与Round7.swift
//  算法
//
//  Created by Plum on 2021/6/13.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P439
 
 16.23 Rand5与Rand7。给定 rand5(),实现一个方法rand7(),即给定一个生成0到4(含0和4)随机数的方法,编写一个生成0到6(含0和6)随机数的方法。
 
 (提示:#504#573,#636,#667,#696,#719)
 */

struct Interview_16_23 {
    
    static func rand5() -> Int {
         return Int.random(in: 0..<5)
     }
    
    // ⚠️ 概率要一样
    struct Solution1 {
       static func rand7() -> Int {
            while true {
                let value = 5 * rand5() + rand5()
                if value < 21 {
                    return value % 7
                }
            }
        }
    }
    
    struct Solution2 {
       static func rand7() -> Int {
            while true {
                var r1 = 2 * rand5()
                var r2 = rand5()
                if r2 < 4 { // 保证奇偶正常
                    r2 %= 2
                    r1 += r2
                    if r1 < 7 {
                        return r1
                    }
                }
            }
        }
        
      
    }
    
    static func test() {
        
        print(Solution1.rand7())
        print(Solution2.rand7())
        print("\(self) OVER")
    }
}
