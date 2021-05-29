//
//  9.1 合并排序的数组.swift
//  算法
//
//  Created by Plum on 2021/5/25.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation
/*
 P332
 
 10.1合并排序的数组。给定两个排序后的数组A和B,其中A的末端有足够的缓冲空间容纳B
 编写一个方法,将B合并入A并排序。(提示:#332)

 */


struct Interview_10_1 {
    
    static func merge(array1: inout [Int], array2: [Int]) {
        
        /// 查找末尾index
        var lastIndex = array2.count
        var aMaxIndex = findIndex(array: array1)
        if aMaxIndex != -1 {
            lastIndex += aMaxIndex
        }
        
        var bMaxIndex = array2.count - 1
        
        /// 可以只考虑b的index, 不用管a，因为我们是把b->a转移
        /// Round 2
        while bMaxIndex >= 0 {
            if aMaxIndex >= 0 && array1[aMaxIndex] >= array2[bMaxIndex] {
                array1[lastIndex] = array1[aMaxIndex]
                lastIndex -= 1
                aMaxIndex -= 1
            } else {
                array1[lastIndex] = array2[bMaxIndex]
                lastIndex -= 1
                bMaxIndex -= 1
            }
        }
        
        /// ROUND1
        /*
        while aMaxIndex >= 0 && bMaxIndex >= 0 {
            let elementA = array1[aMaxIndex]
            let elementB = array2[bMaxIndex]
            
            if elementA >= elementB {
                array1[lastIndex] = elementA
                lastIndex -= 1
                aMaxIndex -= 1
            } else {
                array1[lastIndex] = elementB
                lastIndex -= 1
                bMaxIndex -= 1
            }
        }
        
        while aMaxIndex >= 0 {
            array1[lastIndex] = array1[aMaxIndex]
            lastIndex -= 1
            aMaxIndex -= 1
        }
        
        while bMaxIndex >= 0 {
            array1[lastIndex] = array2[aMaxIndex]
            lastIndex -= 1
            bMaxIndex -= 1
        }
 */
    }
    
    private static func findIndex(array: [Int]) -> Int {
        
        guard let index = array.firstIndex(of: -1) else {
            return -1
        }
        
        return index - 1
    }
    
    static func test() {
        var a = Array<Int>(repeating: -1, count: 20)
        a[0] = 1
        a[1] = 2
        a[2] = 7
        a[3] = 8
        
        var a2 = [3, 7, 9, 10]
        
        merge(array1: &a, array2: a2)
        print(a)
    }
}
