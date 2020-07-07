//
//  面试题53-在排序数组中查找数字.swift
//  LeetCode
//
//  Created by Plum on 2020/7/4.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题53:在排序数组中查找数字
 
 P263
 

 */

struct Topic53 {
    
    /*
     题目一:数字在排序数组中出现的次数。
     统计一个数字在排序数组中出现的次数。例如,输入排序数组{1,2,3,3 4,5}和数字3,由于3在这个数组中出现了4次,因此输出4
     
     P263
     
     分析：
     1. 通过二分查找找到相等的树，然后前后遍历， 这方法 在遍历的时候是个O(n)的操作，而和从头遍历到尾的复杂度一样
     
     2.利用二分查找找到第一个index和最后一个index，时间复杂度2*O(logN) 也就是 O(logN)
     分析过程：我们先分析如何用二分査找算法在数组中找到第一个k。二分查找算法总是先拿数组中间的数字和k作比较。如果中间的数字比ん大,那么k只有可能出现在数组的前半段,下一轮我们只在数组的前半段查找就可以了。如果中间的数字比k小,那么k只有可能出现在数组的后半段,下轮我们只在数组的后半段査找就可以了。如果中间的数字和k相等呢?我们先判断这个数字是不是第一个k。如果中间数字的前面一个数字不是k, 那么此时中间的数字刚好就是第一个k;如果中间数字的前面一个数字也是k,那么第一个k肯定在数组的前半段,下一轮我们仍然需要在数组的前半段査找。
     */
    struct Topic1 {
        static func repeatCount(int array: [Int], number: Int) -> Int {
            guard !array.isEmpty else {
                return 0
            }
            
            var count = 0
            let firstIndex = findFirstIndex(array: array, number: number, start: 0, end: array.count - 1)
            let lastIndex = findLastIndex(array: array, number: number, start: 0, end: array.count - 1)
            
            if firstIndex + lastIndex != -2 {
                count = lastIndex - firstIndex + 1
            }
            return  count
        }
        
        static func findFirstIndex(array: [Int], number: Int, start: Int, end: Int) -> Int {
            guard start <= end else {
                return -1
            }
            let middle = (start + end) >> 1
            var endIndex = end
            var startIndex = start
            
            let middleValue = array[middle]
            if middleValue == number {
                if (middle > 0 && array[middle - 1] != number) || middle == 0 {
                    return middle
                } else {
                    endIndex = middle - 1
                }
            } else if middleValue > number {
                endIndex = middle - 1
            } else {
                // 小于
                startIndex = middle + 1
            }
            return findFirstIndex(array: array, number: number, start: startIndex, end: endIndex)
        }
        
        static func findLastIndex(array: [Int], number: Int, start: Int, end: Int) -> Int {
            guard start <= end else {
                return -1
            }
            let middle = (start + end) >> 1
            var endIndex = end
            var startIndex = start
            
            let middleValue = array[middle]
            let lastIndex = array.count - 1
            if middleValue == number {
                if (middle < lastIndex && array[middle + 1] != number) || middle == array.count - 1 {
                    return middle
                } else {
                    startIndex = middle + 1
                }
            } else if middleValue > number {
                endIndex = middle - 1
            } else {
                // 小于
                startIndex = middle + 1
            }
            return findLastIndex(array: array, number: number, start: startIndex, end: endIndex)
        }
        
        static func test() {
            let a = [1]
            assert(repeatCount(int: a, number: 8) == 0)
            let b = [1, 2, 2, 2, 4, 5]
            assert(repeatCount(int: b, number: 2) == 3)
            let c = [1, 3, 5, 6, 9]
            assert(repeatCount(int: c, number: 1) == 1)
            assert(repeatCount(int: c, number: 9) == 1)
            
            print("Topic53.Topic1 OVER")
        }
    }
    
    
    /*
     题目二:0~n-1中缺失的数字。计
     
     P266
     
     一个长度为n-1的递增排序数组中的所有数字都是唯一的,并且每个数字都在范围0~n-1之内。在范围0~n-1内的n个数字中有且只有一个数字不在该数组中,请找出这个数字。
     
     分析：
     1. 可以通过求和公式 n(n-1)/2 求出s1, 然后求数组的和s2, s1-s2就是缺的数字 时间复杂度：O(n)
     2. 利用二分查找找到第一个array[index] != index的值
     思路：
     我们可以基于二分査找的算法用如下过程查找:如果中间元素的值和下标相等,那么下一轮査找只需要査找右半边:如果中间元素的值和下标不相等,并且它前面一个元素和它的下标相等,这意味着这个中间的数字正好是第一个值和下标不相等的元素,它的下标就是在数组中不存在的数字;如果中间元素的值和下标不相等,并且它前面一个元素和它的下标不相等,这意味着下一轮查找我们只需要在左半边查找即可。
     */
    struct Topic2 {
        static func findLostValue(in array: [Int]) -> Int? {
            guard !array.isEmpty else {
                return nil
            }
            var start = 0
            var end = array.count - 1
            while start <= end {
                let middle = (start + end) >> 1
                if array[middle] != middle {
                    if middle == 0 || array[middle - 1] == middle - 1 {
                        return middle
                    } else {
                        end = middle - 1
                    }
                } else {
                    start = middle + 1
                }
            }
            return nil
        }
        
        static func test() {
            let a = [1, 2, 3, 4]
            assert(findLostValue(in: a) == 0)
            
            let b = [0, 1, 2, 3, 5, 6, 7]
            assert(findLostValue(in: b) == 4)
            
            let c = [0, 1, 2, 3, 4, 5, 6, 8]
            assert(findLostValue(in: c) == 7)
            
            let d = [0]
            assert(findLostValue(in: d) == nil)
            
            print("Topuic53.Topic2 OVER")
        }
    }
    
    /*
     题目三:数组中数值和下标相等的元素。
     
     P267
     
     假设一个单调递增的数组里的每个元素都是整数并且是唯一的。请编程实现一个函数,找出数组中任意一个数值等于其下标的元素。例如,在数组{-3,-1,1,3,5})中,数字3和它的下标相等
     
     分析：
     比较index和array[index], 若 array[index] > index, 那么右边的肯定不满足，只能去左边找；如果array[index] < index, 那么只能去右边找
     */
    struct Topic3 {
        static func findIndexEqualToValue(in array: [Int]) -> Int? {
            guard !array.isEmpty else {
                return nil
            }
            
            var start = 0
            var end = array.count - 1
            while start <= end {
                let middle = (start + end) >> 1
                if array[middle] > middle {
                    end = middle - 1
                } else if array[middle] < middle {
                    start = middle + 1
                } else {
                    return middle
                }
            }
            return nil
        }
        
        static func test() {
            let a = [0]
            assert(findIndexEqualToValue(in: a) == 0)
            
            let b = [1, 2, 3, 4]
            assert(findIndexEqualToValue(in: b) == nil)
            
            let c = [-2, -1, 0, 3]
            assert(findIndexEqualToValue(in: c) == 3)
            
            let d = [0, 2, 3, 4]
            assert(findIndexEqualToValue(in: d) == 0)
            
            print("Topic53.Tpoc3 OVER")
        }
    }
}
