//
//  16.5 阶乘尾数.swift
//  算法
//
//  Created by Plum on 2021/6/5.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 16.5 阶乘尾数,设计一个算法,算出n阶乘有多少个尾随0
 */

/*
 分析：
 算出结果除以10，缺点：数字很大， 我们可以算多少个2和5的因子，又因为2的因子肯定比5多，因此计算5的个数就是了
 */

struct Interview_16_5 {
    
    
    /// 算出结果除以10，缺点：数字很大
    struct Solution1 {
        
    }
    
    struct Solution2 {
        static func zeroNumber(of number: Int) -> Int {
            guard number > 0 else {
                return 0
            }
            
            var count = 0
            for i in 1...number {
                count += factorsOf5(number: i)
            }
            
            return count
        }
        
        private static func factorsOf5(number: Int) -> Int {
            var count = 0
            var number = number
            while number % 5 == 0 {
                count += 1
                number /= 5
            }
            
            return count
        }
    }
    
    /// 直接寻找5、25、125...的倍数
    struct Solution3 {
        static func zeroNumber(of number: Int) -> Int {
            var start = 5
            var count = 0
            while start <= number {
                count += number / start
                start *= 5
            }
            
            return count
        }
    }
    
    static func test() {
        
        do {
            assert(Solution2.zeroNumber(of: 0) == 0)
            assert(Solution2.zeroNumber(of: 4) == 0)
            assert(Solution2.zeroNumber(of: 5) == 1)
            assert(Solution2.zeroNumber(of: 10) == 2)
        }
        
        do {
            assert(Solution3.zeroNumber(of: 0) == 0)
            assert(Solution3.zeroNumber(of: 4) == 0)
            assert(Solution3.zeroNumber(of: 5) == 1)
            assert(Solution3.zeroNumber(of: 10) == 2)
        }
        
        print("\(self) OVER")
    }
}
