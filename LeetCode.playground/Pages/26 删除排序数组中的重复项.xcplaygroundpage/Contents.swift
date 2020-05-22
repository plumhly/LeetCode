/*:

[上一页](@previous)

 # 描述
给定一个排序数组，你需要在 原地 删除重复出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。
不要使用额外的数组空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。

 
### 示例1：
    给定数组 nums = [1,1,2],
    函数应该返回新的长度 2, 并且原数组 nums 的前两个元素被修改为 1, 2。
    输出：1->1->2->3->4->4
        
### 示例2：
    给定 nums = [0,0,1,1,1,2,2,3,3,4],
    函数应该返回新的长度 5, 并且原数组 nums 的前五个元素被修改为 0, 1, 2, 3, 4。


[下一页](@next)
*/

import Foundation


// [0,0,1,1,1,2,2,3,3,4]
// [0,1,1,1,2,2,3,3,4]

class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        
        var i = 0
        
        for j in 1..<nums.count {
            if nums[i] != nums[j] {
                i += 1
                nums[i] = nums[j]
            }
        }
        return i + 1
    }
}

/** Round 1
 func removeDuplicates(_ nums: inout [Int]) -> Int {
     guard !nums.isEmpty else { return 0 }
     
     var preIndex = 0

     var pre: Int = Int.max
     
 
     for (index, value) in nums.enumerated() {
         if index == 0 {
             pre = value
             preIndex = index + 1
             continue
         }
         
         if value != pre {
             if preIndex < index {
                 nums[preIndex] = value
                 preIndex += 1
             } else {
                 preIndex = index + 1
             }
         }
         pre = value
     }
     
     return preIndex
 }
 */

func removeDepulate( nums: inout [Int]) -> Int {
    guard !nums.isEmpty else {
        return 0
    }
    
    var index = 1
    for i in 1..<nums.count {
        if nums[i] != nums[i - 1]  {
            nums[index] = nums[i]
            index += 1
        }
    }
    return index
}


var test = [0, 0 , 1, 2, 2, 3, 3, 4, 4]

removeDepulate(nums: &test)


