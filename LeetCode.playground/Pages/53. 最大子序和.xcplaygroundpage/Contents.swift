/*:

[上一页](@previous)

 # 描述
给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

 
### 示例1：
    输入: [-2,1,-3,4,-1,2,1,-5,4],
    输出: 6
    解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
        

[下一页](@next)
*/


import Foundation

class Solution {
    
    // 分治
    func maxSubArray(_ nums: [Int]) -> Int {
        return _max(left: 0, right: nums.count - 1, nums)
    }
    
    func _max(left: Int, right: Int, _ nums: [Int]) -> Int {
        if left == right {
            return nums[left]
        }
        let mid = (left + right) / 2
        
        // 左边
        let leftMax = _max(left: left, right: mid, nums)
        
        // 右边
        let rightMax = _max(left: mid + 1, right: right, nums)
        
        // 中间
        let midMax = crossSum(left: left, right: right, nums)
        
        return max(midMax, max(leftMax, rightMax))
    }
    
    
    func crossSum(left: Int, right: Int, _ nums: [Int]) -> Int {
        if left == right {
            return nums[left]
        }
        
        let mid = (left + right) / 2
        
        var leftSum = 0
        var leftSumMax = Int.min
        
        for i in stride(from: mid, to: left - 1, by: -1) {
            
            leftSum += nums[i]
            leftSumMax = max(leftSumMax, leftSum)
        }
        
        var rightSum = 0
        var rightSumMax = Int.min
        
        for i in stride(from: mid + 1, to: right + 1, by: 1) {
            
            rightSum += nums[i]
            rightSumMax = max(rightSumMax, rightSum)
        }
        
        return leftSumMax + rightSumMax
    }
}

// 贪心
//func maxSubArray(_ nums: [Int]) -> Int {
//    guard !nums.isEmpty else { return 0 }
//
//    var maxVal = nums[0]
//    var currentMax = nums[0]
//
//    for i in 1..<nums.count {
//        /**
//         如果前面的和加起来比该位置的元素 大，那么后面就有希望得出最大的值。如果比该元素还小，那么就取该元素
//         */
//        currentMax = max(nums[i], currentMax + nums[i])
//        maxVal = max(currentMax, maxVal)
//    }
//    return maxVal
//}

// 动态规划
// [1, 2, 3, 4, 5, 6]
// [[1, 2, 3, 4, 5] 6]
// [[[1, 2, 3, 4] 5] 6]
func maxSubArray(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    
    var otherNums = nums
    var maxVal = nums[0]
    
    for i in 1..<otherNums.count {
        if otherNums[i - 1] > 0 {
            otherNums[i] = otherNums[i] + otherNums[i - 1]
        }
        maxVal = max(maxVal, otherNums[i])
    }
    return maxVal
}




let test = [1, 3, -4, 8, -1, 1, 2, -3]

//Solution().maxSubArray(test)
maxSubArray(test)


func step(n: Int) -> Int {
    if n <= 2 {
        return n
    }
    return _x(first: 1, second: 2, count: n)
}

func _x(first: Int, second: Int, count: Int) -> Int {
    
    if count == 3 {
        return first + second
    }
    
    return _x(first: second, second: first + second, count: count - 1)
}


step(n: 6)
