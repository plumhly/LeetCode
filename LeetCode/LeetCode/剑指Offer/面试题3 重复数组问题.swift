//
//  面试题3 重复数组问题.swift
//  LeetCode
//
//  Created by Plum on 2020/5/24.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

// p 39

/*
 # 题目一:找出数组中重复的数字。
 在一个长度为n的数组里的所有数字都在0~n-1的范围内。数组中某些数字是重复的,但不知道有几个数字重复了,也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。例如,如果输入长度为7的数组{2,3,1,0,2,5,3},那么对应的输出是重复的数字2或者3。
 
 
 # 算法过程：
 现在让我们重排这个数组。从头到尾依次扫描这个数组中的每个数字。
 当扫描到下标为的数字时,首先比较这个数字(用m表示)是不是等于。
 如果是,则接着扫描下一个数字;如果不是,则再拿它和第m个数字进行比较。如果它和第m个数字相等,就找到了一个重复的数字(该数字在下标为i和m的位置都出现了);如果它和第m个数字不相等,就把第i个数字和第m个数字交换,把m放到属于它的位置。接下来再重复这个比较、交换的过程,直到我们发现一个重复的数字。
 
 
 时间复杂度：O(n)
 空间复杂度：O(1)
 
 其他解法：
 1. 排序后在遍历， O(NlogN)
 2. 哈希表 时间O(N)， 空间：O(N)
 */
struct Topic1 {
   static func depucateElement(in array: [Int]) -> (Bool, Int) {
        
        guard !array.isEmpty else {
            return (false, -1)
        }
        
        // 元素是否满足要求: 长度为n的数组里的所有数字都在0~n-1的范围内
        for i in array {
            if i < 0 || i > array.count - 1 {
                return (false, -1)
            }
        }
        
        var tempArray = array
        var value = 0
        
        /*
         0-(n-1)
         这个n个数字在没有重复数字的情况下最多需要交换n-1次就可以让所有数字找到自己的位置；而对于有重复数字的数组，这个值小于n-1。那么平均到每个数字其移动次数为n/(n-1)。由于n为自然数，因此这个公式的最大值为2。
         */
        for i in 0...tempArray.count {
            while tempArray[i] != i {
                value = tempArray[i]
                if tempArray[value] == value {
                    return (true, value)
                } else {
                    tempArray.swapAt(i, value)
                }
            }
        }
        return (false, -1)
    }
}



/*
 题目二:不修改数组找出重复的数字。
 在一个长度为n+1的数组里的所有数字都在1~n的范围内,所以数组中至少有一个数字是重复的。请找出数组中任意一个重复的数字,但不能修改输入的数组。例如,如果输入长度为8的数组{2,3,5,4,3,2,6,7),那么对应的输出是重复的数字2或者3。
 
 # 算法过程
    我们把从1~n的数字从中间的数字m分为两部分,前面一半为1~m,后面一半为m+1~n。如果1~m的数字的数目超过,m,那么这一半的区间里一定包含重复的数字:否则,另一半m+1~n的区间里一定包含重复的数字。我们可以继续把包含重复数字的区间一分为二,直到找到一个重复的数字。这个过程和二分査找算法很类似,只是多了一步统计区间里数字的数目
 
 时间复杂度：O(NlogN), 空间复杂度：O(1)
 
 # 其他解法
    用一个长度为 n+1 的数组把数字重写入新数组当中,如m的数字写入m的下标
 
 */
struct Topic2 {
    static func getDupicateElement(in array: [Int]) -> (Bool, Int) {
        guard array.count > 1 else {
            return (false, -1)
        }
        
        // 数字，要求1 ~ n-1
        var start = 1
        var end = array.count - 1
        
        while end >= start {
            let middle = (start + end) >> 1
            let count = self.count(with: array, start: start, end: middle)
            
            // 缩到一点
            if start == end {
                if count > 1 {
                    return (true, start)
                } else {
                    break
                }
            }
            
            if count > (middle - start + 1)  {
                // 重复数字子左半步
                end = middle
            } else {
                // 重复数字在右半部
                start = middle + 1
            }
        }
        return (false, -1)
    }
    
    static func count(with array: [Int], start: Int, end: Int) -> Int {
        var count = 0
        array.forEach { value in
            if value >= start, value <= end {
                count += 1
            }
        }
        return count
    }
}
