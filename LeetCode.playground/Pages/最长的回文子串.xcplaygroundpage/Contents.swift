/*:

[上一页](@previous)

 # 描述
 给定一个字符串 s，找到 s 中最长的回文子串。你可以假设 s 的最大长度为 1000。
 
 ### 示例:
    输入: "babad"
    输出: "bab"
    注意: "aba" 也是一个有效答案
 
# 分析
暴力法采用双指针两边夹，验证是否是回文子串，时间复杂度比较高，除了枚举字符串的左右边界以外，比较容易想到的是枚举可能出现的回文子串的“中心位置”，从“中心位置”尝试尽可能扩散出去，得到一个回文串。

因此，中心扩散法的思路是：遍历每一个索引，以这个索引为中心，利用“回文串”中心对称的特点，往两边扩散，看最多能扩散多远。
枚举“中心位置”时间复杂度为O(N)，从“中心位置”扩散得到“回文子串”的时间复杂度为O(N)，因此时间复杂度可以降到O(N^2)。

在这里要注意一个细节：回文串在长度为奇数和偶数的时候，“回文中心”的形式是不一样的。
* 奇数回文串的“中心”是一个具体的字符，例如：回文串 "aba" 的中心是字符 "a"；
* 偶数回文串的“中心”是位于中间的两个字符的“空隙”，例如：回文串串 "abba" 的中心是两个 "b" 中间的那个“空隙”。

![](2.jpg)
![](1.jpg)


[下一页](@next)
*/


import Foundation
//: [Next](@next)

func longestPalindrome(_ s: String) -> String {
    
    func expandCenter(s: String, leftIndex: String.Index, rightIndex: String.Index) -> String {
        var left = leftIndex
        var right = rightIndex
        var containerStartIndex = false
        while left >= s.startIndex && right != s.endIndex && s[left] == s[right] {
            if left == s.startIndex {
                containerStartIndex = true
                break
            } else {
                left = s.index(before: left)
                right = s.index(after: right)
            }
        }
        let range = containerStartIndex ? left ..< s.index(after: right) : s.index(after: left) ..< right
        return  String(s[range])
    }
    
    if s.count <= 1 {
        return s
    }
    
    var startIndex = s.startIndex
    var res = String(s[startIndex])
    
    while startIndex != s.endIndex {
        let oddString = expandCenter(s: s, leftIndex: startIndex, rightIndex: startIndex)
        let evenString = expandCenter(s: s, leftIndex: startIndex, rightIndex: s.index(after: startIndex))
        let result = oddString.count > evenString.count ? oddString : evenString
        if result.count > res.count {
            res = result
        }
        startIndex = s.index(after: startIndex)
    }
    return res
}


let s = "cbbd"
//let s = "abcbabde"
let result = longestPalindrome(s)
print(result)

