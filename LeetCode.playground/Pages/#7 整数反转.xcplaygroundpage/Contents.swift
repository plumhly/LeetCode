/*: [Previous](@previous)
给出一个 32 位的有符号整数，你需要将这个整数中每位上的数字进行反转。

    示例 1:
        输入: 123
        输出: 321
 
     示例 2:
        输入: -123
        输出: -321
 
    示例 3:
        输入: 120
        输出: 21
 
    注意:
        假设我们的环境只能存储得下 32 位的有符号整数，则其数值范围为 [−231,  231 − 1]。请根据这个假设，如果反转后整数溢出那么就返回 0。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/reverse-integer
 
 ### 分析
 1. 2^31-1=2147483647,-2^31=-2147483648
 
 
[下一页](@next)
 */

import Foundation

class Solution {
    func reverse(_ x: Int) -> Int {
        var x = x
        let max = Int32.max
        let min = Int32.min
        var rev = 0
        while x != 0 {
            let pop = x % 10
            x /= 10
            if (rev > max / 10) || ((rev == max / 10) && (pop > 7)) {
                return 0
            } else if (rev < min / 10) || ((rev == min / 10) && (pop < -8)) {
                return 0
            }
            rev = rev * 10 + pop
        }
        return rev
    }
}
