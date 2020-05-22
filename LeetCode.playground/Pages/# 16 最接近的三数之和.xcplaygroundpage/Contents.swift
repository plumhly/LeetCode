/*:

[上一页](@previous)

 # 描述
给定一个包括 n 个整数的数组 nums 和 一个目标值 target。找出 nums 中的三个整数，使得它们的和与 target 最接近。返回这三个数的和。假定每组输入只存在唯一答案。

### 示例：
    例如，给定数组 nums = [-1，2，1，-4], 和 target = 1.
    与 target 最接近的三个数的和为 2. (-1 + 2 + 1 = 2).


 
### 解题思路
    双指针
 
[链接](https://leetcode-cn.com/problems/3sum-closest)

[下一页](@next)
*/

import Foundation

class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        
        if nums.count < 3 {
            return 0
        }
        
        let numbers = nums.sorted()
        var distance = Int.max
        var result: Int = 0
        
        for (index, value) in numbers.enumerated() {
            
            var left = index + 1
            var right = numbers.count - 1
            
            while left < right {
                
                let sum = value + numbers[left] + numbers[right]
                
                let temp = sum - target
                
                if abs(temp) < distance {
                    result = sum
                    distance = abs(temp)
                }
                if temp > 0 {
                    // 向左移动right
                    right -= 1
                } else if temp < 0 {
                    // 向右移动left
                    left += 1
                } else {
                    // 相等
                    return target
                }
            }
        }
        return result
    }
}
