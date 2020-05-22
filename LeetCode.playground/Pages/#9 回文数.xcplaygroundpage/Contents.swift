/*:
 [Previous](@previous)


 ### 描述
 判断一个整数是否是回文数。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。

    示例 1:
        输入: 121
        输出: true
 
    示例 2:
        输入: -121
        输出: false
        解释: 从左向右读, 为 -121 。 从右向左读, 为 121- 。因此它不是一个回文数。
    
    示例 3:
        输入: 10
        输出: false
        解释: 从右向左读, 为 01 。因此它不是一个回文数。
 
 
 ### 思路
 第二个想法是将数字本身反转，然后将反转后的数字与原始数字进行比较，如果它们是相同的，那么这个数字就是回文。
 但是，如果反转后的数字大于
 int.MAX
 int.MAX，我们将遇到整数溢出问题。

 按照第二个想法，为了避免数字反转可能导致的溢出问题，为什么不考虑只反转
 int
 int 数字的一半？毕竟，如果该数字是回文，其后半部分反转后应该与原始数字的前半部分相同。

https://leetcode-cn.com/problems/palindrome-number/

 [Next](@next)
*/

import Foundation

class Solution {
    func isPalindrome(_ x: Int) -> Bool {
        
        if x < 0 || (x % 10 == 0 && x != 0) {
            return false
        }
        
        var number = x
        var result = 0
        while number > result {
            result *= 10
            result += number % 10
            number /= 10
        }
        // 当数字长度为奇数时，我们可以通过 revertedNumber/10 去除处于中位的数字。
        // 例如，当输入为 12321 时，在 while 循环的末尾我们可以得到 x = 12，revertedNumber = 123，
        // 由于处于中位的数字不影响回文（它总是与自己相等），所以我们可以简单地将其去除。
        return number == result || number == result / 10
    }
}
