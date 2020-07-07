//
//  面试题39-数组中出现次数超过一半的数字.swift
//  LeetCode
//
//  Created by Plum on 2020/6/25.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation
/*
 面试题39:数组中出现次数超过一半的数字
 
 P205
 
 题目:数组中有一个数字出现的次数超过数组长度的一半,请找出这个数字。例如,输入一个长度为9的数组{1,2,3,2,2,2,5,4,2}。由于数字2在数组中出现了5次,超过数组长度的一半,因此输出2。
 
 分析：
 数组的特性:数组中有一个数字出现的次数超过了数组长度的一半。如果把这个数组排序,那么排序之后位于数组中间的数字一定就是那个出现次数超过数组长度一半的数字。也就是说,这个数字就是统计学上的中位数, 即长度为n的数组中第n2大的数字。我们有成熟的时间复杂度为O(n）的算法得到数组中任意第k大的数字。
 */

struct Topic39 {
    struct Solution1 {
        static func moreThanHalfNumber(array: [Int]) -> Int? {
            guard array.count > 0 else {
                return nil
            }
            
            var array = array
            let middle = array.count >> 1
            var start = 0
            var end = array.count - 1
            
            var index = partition(array: &array, start: start, end: end)
            
            while index != middle {
                if index < middle {
                    // 那么在右边
                    start = index + 1
                    index  = partition(array: &array, start: start, end: end)
                } else {
                    // 左边
                    end = index - 1
                    index = partition(array: &array, start: start , end: end)
                }
            }
            let result: Int = array[index]
            if isNumberMoreThanHalf(array: array, result: result) {
                return result
            }
            return nil
        }
        
        static func partition(array: inout [Int], start: Int, end: Int) -> Array<Int>.Index {
            var end = end
            let value = array[start]
            var start = start
            while start < end {
                while start < end, array[end] >= value {
                    end -= 1
                }
                array[start] = array[end]
                while start < end, array[start] < value {
                    start += 1
                }
                array[end] = array[start]
                // 这里不能用交换，原因在于 array[start] = array[end]会改变start的值，用swap那么就会让value赋值2次
            }
            
            // start == end
            array[start] = value
            return start
        }
        
        static func test() {
            let a = [1, 3, 3, 3, 3, 6]
            let b = [2, 2, 1, 3, 5, 2, 2]
            let c = [1, 1, 2, 2, 3, 3]
            
            assert(moreThanHalfNumber(array: a) == 3)
            assert(moreThanHalfNumber(array: b) == 2)
            assert(moreThanHalfNumber(array: c) == nil)
            print("Topic39 Solution1 OVER")
        }
    }
    
    static func isNumberMoreThanHalf(array: [Int], result: Int) -> Bool {
        return array.filter { $0 == result }.count > (array.count >> 1)
    }
    
    struct Solution2 {
        
        static func moreThanHalfNumber(array: [Int]) -> Int? {
            guard array.count > 0 else {
                return nil
            }
            
            var number = array[0]
            var times = 1
            
            for i in 1..<array.count {
                if times == 0 {
                    number = array[i]
                    times = 1
                } else {
                    if number == array[i] {
                        times += 1
                    } else {
                        times -= 1
                    }
                }
            }
            
            if isNumberMoreThanHalf(array: array, result: number) {
                return number
            }

            return nil
        }
        
        static func test() {
            let a = [1, 3, 3, 3, 3, 6]
            let b = [2, 2, 1, 3, 5, 2, 2]
            let c = [1, 1, 2, 2, 3, 3]
            
            assert(moreThanHalfNumber(array: a) == 3)
            assert(moreThanHalfNumber(array: b) == 2)
            assert(moreThanHalfNumber(array: c) == nil)
            print("Topic39 Solution2 OVER")
        }
    }
}
