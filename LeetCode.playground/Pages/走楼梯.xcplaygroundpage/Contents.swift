/*:

[上一页](@previous)

 # 描述
    可以跨1步或者2步走楼梯，请问有多少种走法

 
### 解题思路
    分解问题：
        如果 结果为 f(n)
        如果第一次跨1步，那么后面有 f(n-1)种走法
        如果第一次跨2步，那么后面有 f(n-2)种走法
        所以有 f(n) = f(n-1) + f(n-2)
 
[链接](https://leetcode-cn.com/problems/valid-parentheses)

[下一页](@next)
*/

import Foundation

// 尾递归
//class Solution {
//    func climbStairs(_ n: Int) -> Int {
//        if n <= 2 {
//        return n
//        }
//        return _step(first: 1, second: 2, count: n)
//    }
//
//
//    func _step(first: Int, second: Int, count: Int) -> Int {
//
//        if count == 3 {
//            return first + second
//        }
//
//        return _step(first: second, second: first + second, count: count - 1)
//    }
//}

// 迭代

class Solution {
    func climbStairs(_ n: Int) -> Int {
        
        if n < 3 {
            return n
        }
        var first = 1
        var second = 2
        
        for _ in 3..<n {
            first = second
            second = first + second
        }
        return second
    }
}
