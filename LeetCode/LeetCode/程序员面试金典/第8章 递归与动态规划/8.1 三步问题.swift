//
//  8.1 三步问题.swift
//  算法
//
//  Created by Plum on 2021/3/4.
//  Copyright © 2021 Plum. All rights reserved.
//

/*
 8.1三步问题。有个小孩正在上楼梯，楼梯有n台阶，小孩一次可以上1阶、2阶或3阶。

 实现一种方法，计算小孩有多少种上楼梯的方式。（提示：#152，#178，#217，#237，#262,#359)

 */

import Foundation

//struct Interview_8_1 {
//    struct Recursive {
//        static func fibonacci(n: Int) -> Int {
//            return finonacci(with: n, arg1: 0, arg2: 1)
//        }
//
//        static private func finonacci(with n: Int, arg1: Int, arg2: Int) -> Int {
//            guard n > 0 else {
//                return arg1
//            }
//
//            return finonacci(with: n - 1, arg1: arg2, arg2: arg1 + arg2)
//        }
//    }
//
//    struct Iterator {
//        <#fields#>
//    }
//}


/*
 分析：思考最后一步需要跨多少阶梯
 
 f(n) = f(n-1) + f(n-2) + f(n-3) (n >= 3)
 */

struct Interview_8_1 {
    static func threeStairs(n: Int) -> Int {
        var values = Array<Int>(repeating: -1, count: n + 1)
        return threeStairs(n: n, array: &values)
    }
    
    private static func threeStairs(n: Int, array: inout [Int]) -> Int {
        if n < 0 {
            return 0
        } else if n == 0 {
            return 1
        } else if array[n] > -1 {
            return array[n]
        } else {
            array[n] = threeStairs(n: n - 1, array: &array) + threeStairs(n: n - 2, array: &array) + threeStairs(n: n - 3, array: &array)
        }
        return array[n]
    }
    
    struct Other {
        static func threeStairs(n: Int) -> Int {
            if n < 3 {
                return n
            } else if n == 3 {
                return 4
            }
            
            var f = 1
            var s = 2
            var t = 4
            
//            for _ in 4...n {
//                let sum = t + f + s
//                f = s
//                s = t
//                t = sum
//            }
//
//            return t
            
            /// 尾递归
            return threeStairs(n: n - 3, first: f, secod: s, third: t)
        }
        
        private static func threeStairs(n: Int, first: Int, secod: Int, third: Int) -> Int {
            guard n > 0 else {
                return third
            }
            
            return threeStairs(n: n - 1, first: secod, secod: third, third: first + secod + third)
        }
    }
    
    static func test() {
        assert(threeStairs(n: 1) == 1)
        assert(threeStairs(n: 2) == 2)
        assert(threeStairs(n: 3) == 4)
        
        assert(Other.threeStairs(n: 8) == threeStairs(n: 8))
        print("Interview_8_1 OVER")
    }
    
}
