//
//  面试题57-和为s的数字.swift
//  LeetCode
//
//  Created by Plum on 2020/7/5.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题57:和为s的数字
 
 P280
 
 */

struct Topic57 {
    
    /*
     题目一:和为s的两个数字。
     
     P280
     
     输入一个递増排序的数组和一个数字s,在数组中査找两个数,使得它门的和正好是s。如果有多对数字的和等于s,则输出任意一对即可。
     
     分析：
     接着我们寻找更好的算法。我们先在数组中选择两个数字,如果它们的和等于输入的s,那么我们就找到了要找的两个数字。如果和小于s呢? 我们希望两个数字的和再大一点。由于数组已经排好序了,我们可以考虑选择较小的数字后面的数字。因为排在后面的数字要大一些,那么两个数字的和也要大一些,就有可能等于输入的数字s了。同样,当两个数字的和大于输入的数字的时候,我们可以选择较大数字前面的数字,因为排在数组前面的数字要小一些。
     */
    struct Topic1 {
        
        static func findNumbers(in array: [Int], sum: Int) -> (Int, Int)? {
            guard array.count > 1 else {
                return nil
            }
            
            var start = 0
            var end = array.count - 1
            var currentSum = 0
            
            while start < end {
                currentSum = array[start] + array[end]
                
                if currentSum == sum {
                    return (array[start], array[end])
                } else if currentSum > sum {
                    end -= 1
                } else {
                    start += 1
                }
            }
            return nil
        }
        
        static func test() {
            
            let a = [1, 2, 4, 7, 11, 15]
            let b = findNumbers(in: a, sum: 15)
            assert(b?.0 == 4)
            assert(b?.1 == 11)
            
            let c = findNumbers(in: a, sum: 20 )
            assert(c == nil)
            
            print("Topic57.Topic1 OVER")
        }
    }
    
    /*
     题目二:和为s的连续正数序列。
     
     P282
     
     输入一个正数s,打印出所有和为s的连续正数序列(至少含有两个数)。例如,输入15,由于1+2+3+45-4+5+6=7+8=15,所以打印出3个连运续序列1~5、4~6和7~8
     
     分析：
     有了解决前面问题的经验,我们也考虑用两个数 small 7和big分别表示序列的最小值和最大值。首先把smal初始化为1,big初始化为2。如果从small 3到big的序列的和大于s,则可以从序列中去掉较小的值,也就是增大small f的值。如果从smal到big的序列的和小于s,则可以增大big,让这个序列包含更多的数字。因为这个序列至少要有两个数字,我们一直增加small 4到(1+s)2为止。
     */
    struct Topic2 {
        static func findContinuousSequence(sum: Int) -> [[Int]]? {
            guard sum > 2 else {
                return nil
            }
            
            var start = 1
            var end = 2
            var currentSum = start + end
            
            var result: [[Int]] = []
            // *
            let middle = (sum + 1) / 2
            
            while start < middle {
                if currentSum == sum {
                    result.append(Array(start...end))
                }
                
                while currentSum > sum, start < middle {
                     // 这里就是表示start + 1 到 end的和了
                    currentSum -= start
                    start += 1
                     // 这里不用再加了
                    if currentSum == sum {
                        result.append(Array(start...end))
                        end += 1
                        currentSum += end
                    }
                }
                
                // 满了增大 start, 途径就是增大end, 这里有两个条件1. currentsum < sum 和 currentsum = sum
                end += 1
                currentSum += end
            }
            return result
        }
        
        static func test() {
            let a = findContinuousSequence(sum: 15)
            assert(a?.count == 3)
            assert(a?[0] == [1, 2, 3, 4, 5])
            assert(a?[1] == [4, 5, 6])
            assert(a?[2] == [7, 8])
            print("Topic57.Topic2 OVER")
        }
    }
}
