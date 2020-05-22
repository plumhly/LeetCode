/*:

[上一页](@previous)

 # 描述
 分治
编写一个函数来查找字符串数组中的最长公共前缀。如果不存在公共前缀，返回空字符串 ""。

### 示例:
    示例 1:
        输入: ["flower","flow","flight"]
        输出: "fl"
       
    示例 2:
       输入: ["dog","racecar","car"]
       输出: ""
 
    解释: 输入不存在公共前缀。
    说明: 所有输入只包含小写字母 a-z 。

 
 ### 思路
    这个算法的思路来自于LCP操作的结合律。 我们可以发现：
    LCP(S1…Sn)=LCP(LCP(S1…Sk),LCP(Sk+1…Sn))LCP(S1…Sn)=LCP(LCP(S1…Sk),LCP(Sk+1…Sn))
    ，其中LCP(S1…
    Sn)LCP(S1…Sn) 是字符串
    [S1…Sn][S1…Sn] 的最长公共前缀，1<k<n1<k<n。
 
 ### 算法
 
 
 https://leetcode-cn.com/problems/longest-common-prefix/solution/zui-chang-gong-gong-qian-zhui-by-leetcode/

[下一页](@next)
*/

import Foundation


class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard !strs.isEmpty else { return "" }
        return longestCommonPrefix(strs, left: 0, right: strs.count - 1)
    }
    
    
    func longestCommonPrefix(_ strs: [String], left: Int, right: Int) -> String {
        guard left != right else { return strs[left] }
        
        let mid = (left + right) / 2
        let leftPre = longestCommonPrefix(strs, left: left, right: mid)
        let rightPre = longestCommonPrefix(strs, left: mid + 1, right: right)
        return commonPrefix(leftString: leftPre as NSString, rightString: rightPre as NSString)
    }
    
    func commonPrefix(leftString: NSString, rightString: NSString) -> String {
        let minCount = min(leftString.length, rightString.length)
        for i in 0 ..< minCount {
            if leftString.character(at: i) != rightString.character(at: i)  {
                return leftString.substring(to: i)
            }
        }
        return leftString.substring(to: minCount)
    }
}
