/*:

[上一页](@previous)

 # 描述
给你 n 个非负整数 a1，a2，...，an，每个数代表坐标中的一个点 (i, ai) 。在坐标内画 n 条垂直线，垂直线 i 的两个端点分别为 (i, ai) 和 (i, 0)。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。
 
链接：https://leetcode-cn.com/problems/container-with-most-water

### 示例:
    输入：[1,8,6,2,5,4,8,3,7]
    输出：49

[下一页](@next)
*/

import Foundation


class Solution {
    func maxArea(_ height: [Int]) -> Int {
        var left = 0
        var right = height.count - 1
        var size = 0
        while left < right {
            let tempSize = min(height[left], height[right]) * (right - left)
            size = max(tempSize, size)
            if height[left] <= height[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        return size
    }
}
