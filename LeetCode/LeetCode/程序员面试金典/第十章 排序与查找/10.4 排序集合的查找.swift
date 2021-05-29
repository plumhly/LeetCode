//
//  10.4 排序集合的查找.swift
//  算法
//
//  Created by Plum on 2021/5/29.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation


/**
 P336
 
 10.4排序集合的查找,给定一个类似数组的长度可变的数据结构它有 elementat()
 方法,可以在1)的时间内返回下标为的值,但越界会返回1因此,该数据结构只
 支持正整数。给定一个好序的正整数 Listy找到值为x的下标、如果x多次出现
 任选一个返回,(提示:320.337,48)
 
 
 
 10.6大文件排序。设想你有个20GB的文件,每行有一个字符串,请述一下将如何对这个
 文件进行排序。(提示:207)
 10.7失踪的整数,给定一个输文件,包含4亿个非负整数,请设计一种算法,生成一个不
 包含在该文件中的整数,假定你有1GB内存来完成这项任务
 进阶:如果只有10MB内存可用,该怎么办?假设所有值均不同,且有不超过10亿个
 非负整数。
 (提示:#235254.281)
 10.8寻找重复数,给定一个数组,包含1到N的整数,N最大为32000数可能含有重复
 的值,且N的取值不定。若只有4KB内存可用,该如何打印数组中所有重复的元素
 (提示:#289,#315)
 10.9排序矩阵查找,给定MN矩阵,每一行、每一列都按升序排列,请编写代码找出某元素
 (提示:193,211.229,251,266,*279,288291#303317.=330
 0.10数字流的秩假设你正在读取一串整数,每隔一段时间,你希望能找出数字x的秩(小
 于或等于x的值的个数),请实现数据结构和算法来支持这些操作,也就是说实现
  track(intx)方法,每读入一个数字都会调用该方法实现 getranikofnumber(intx)
 方法,返回小于或等于x(x除外)的值的个数
 示例:
 数据流为(按出现的先后顺序)5,1,4,4,5,9,7,13,3
  getrankofn
 r(1)=e
  getrankofnunber(3)=1
  getrankofnumber()=3
 (提示:#301,#376,392)
 1峰与谷。在一个整数数组中,“峰”是大于或等于相邻整数的元素,相应地“谷”是
 小于或等于相邻整数的元素。例如,在数组{5,8,6,2,3,4,6}中,(8,6}是峰
 5,2}是谷。现在给定一个整数数组,将该数组按峰与谷的交替顺序排序

 */

struct Interview_10_4 {
    
    static func find(array: [Int], value: Int) -> Int? {
        guard !array.isEmpty else {
            return nil
        }
        
        let index = findIndexMaybe(array: array, value: value)
        
        /// 这里 start = index / 2 是个优化点
        return binarySearch(array: array, start: index / 2, end: index, value: value)
    }
    
    private static func findIndexMaybe(array: [Int], value: Int) -> Int {
        var index = 1
        while array[index] != -1 && array[index] <= value {
            index *= 2
        }
        
        return index
    }
    
    private static func binarySearch(array: [Int], start: Int, end: Int, value: Int) -> Int? {
        guard start <= end else {
            return nil
        }
        
        let middleIndex = (start + end) / 2
        let middleValue = array[middleIndex]
        
        var index: Int?
        if middleValue > value {
            // 左部分查找
            index = binarySearch(array: array, start: start, end: middleIndex - 1, value: value)
        } else if middleValue < value {
            // 右边
            index = binarySearch(array: array, start: middleIndex + 1, end: end, value: value)
        } else {
            index = middleIndex
        }
        
        return index
    }
    
    static func test() {
        let a1 = [1, -1, -1, -1, -1]
        assert(find(array: a1, value: 1) == 0)
        
        let a2 = [1, 3, 5, 7, 9, 10, 14, 15, -1, -1, -1, -1, -1, -1, -1]
        assert(find(array: a2, value: 5) == 2)
        
        print("Interview_10_4 OVERT")
    }
}
