/*:

[上一页](@previous)

 # 描述
给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。

 ### 注意：
 答案中不可以包含重复的三元组。


### 示例:
       给定数组 nums = [-1, 0, 1, 2, -1, -4]，

       满足要求的三元组集合为：
       [
         [-1, 0, 1],
         [-1, -1, 2]
       ]

 
 [链接](https://leetcode-cn.com/problems/3sum)
 
[下一页](@next)
*/
import Foundation

class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 2 else {
            return []
        }

        // 排序
        let sortNums = nums.sorted()

        var result: [[Int]] = []
        for (index, value) in sortNums.enumerated() {

            if value > 0 {
                return result
            }
            // 去除重复值，前面已经计算了
            if index > 0, sortNums[index] == sortNums[index - 1] {
                continue
            }

            let current = value
            
            var left = index + 1
            var right = sortNums.count - 1
            
            while left < right {
                let temp = current + sortNums[left] + sortNums[right]
                if temp == 0 {
                    result.append([current, sortNums[left], sortNums[right]])
                    while left < right, sortNums[left] == sortNums[left + 1] {
                        left += 1
                    }
                    while left < right, sortNums[right] == sortNums[right - 1] {
                        right -= 1
                    }
                    left += 1
                    right -= 1
                } else if temp < 0 {
                    // 表面左边的数小了
                    left += 1
                } else {
                    // 表面u右边数大了
                    right -= 1
                }
            }
        }
        return result
    }
}

var nums = [-1,0,1,2,-1,-4]

var result = Solution().threeSum(nums)

