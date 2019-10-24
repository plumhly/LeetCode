/*:

[上一页](@previous)

# 描述
给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。


### 示例:
       输入: "abcabcbb"
       输出: 3
       解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。

[下一页](@next)
*/

import Foundation

func lengthOfLongestSubstring(_ s: String) -> Int {
    var map = [Character: Int]()
    var lowerBound = 0
    var length = 0
    for (index, c) in s.enumerated() {
        if let _ = map[c] {
            //这里之所以要用 max，是因为可能会出现滑窗下线之前的重复字符，比如"abba"
            lowerBound = max(map[c]!, lowerBound)
        }
        length = max(length, index - lowerBound + 1)
        map[c] = index + 1
    }
    return length
}

let s = "abba"

let result = lengthOfLongestSubstring(s)

