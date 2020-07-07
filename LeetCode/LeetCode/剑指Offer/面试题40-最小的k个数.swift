//
//  面试题40-最小的k个数.swift
//  LeetCode
//
//  Created by Plum on 2020/6/26.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题40:最小的k个数
 
 P209
 
 题目:输入n个整数,找出其中最小的k个数。例如,输入4、5、1 2、7、3、8这8个数字,则最小的4个数字是1、2、3、4。
 */

struct Topic40 {
    
    /*
     分析：从解决面试题39“数组中出现次数超过一半的数字”得到了启发,我们同样可以基于 Partition函数来解决这个问题。如果基于数组的第k个数字来调整,则使得比第k个数字小的所有数字都位于数组的左边,比第k个数字大的所有数字都位于数组的右边。这样调整之后,位于数组中左边的k 个数字就是最小的k个数字(这k个数字不一定是排序的)。下面是基于这种思路的参考代码
     */
    struct Solution1 {
        static func findSmallestNubmer(array: [Int], k: Int) -> [Int]? {
            guard array.count > k, k > 0 else {
                return nil
            }
            
            var start = 0
            var end = array.count - 1
            var array = array
            var index = Topic39.Solution1.partition(array: &array, start: start, end: end)
            while index != k - 1 {
                if index < k - 1 {
                    start = index + 1
                } else {
                    end = index - 1
                }
                index = Topic39.Solution1.partition(array: &array, start: start, end: end)
            }
            return check(array: array, k: index)
            
        }
        
        static func check(array: [Int], k: Int) -> [Int]? {
            var result: [Int] = []
            for (index, i) in array.enumerated() {
                if index <= k {
                    result.append(i)
                }
            }
            return result.count == k ? result : nil
        }
        
    }
    
    // 大顶堆 O(nlog(k))，适合大数据，因为数据不是一次性给完
    struct Solution2 {
        static func findMinus(array: [Int], k: Int) -> [Int]? {
            guard array.count >= k else {
                return nil
            }
            
            var result: [Int] = []
            
            for i in array {
                if result.count < k {
                    result.append(i)
                    result.sort()
                } else {
                    if i < result.last! {
                        result.removeLast()
                        result.append(i)
                        result.sort()
                    }
                }
            }
            
            if result.count != k {
                return nil
            }
            return result
        }
    }
    
    static func test() {
        let a = [4, 5, 1, 6, 2, 7, 3, 8]
        let a1 = Solution1.findSmallestNubmer(array: a, k: 4)
        
        let b = [4, 5, 1, 6, 2, 7, 3, 8]
        let b1 = Solution2.findMinus(array: b, k: 4)
        print("Topic40 Solution1 OVER")
    }
}
