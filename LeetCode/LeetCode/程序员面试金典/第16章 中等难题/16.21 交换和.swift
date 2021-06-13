//
//  16.21 交换和.swift
//  算法
//
//  Created by Plum on 2021/6/12.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P431
 
 16.21交换和。给定两个整数数组,请交换一对数值(每个数组中取一个数值)使得两个数组所有元素的和相等
 
 示例
    输入: {4,1,2,1,1,2}和{3,6,3,3}
    输出: {1,3}
 
 (提示:544,=556,563,×570,52.591,=601,605,=634)
 */

struct Interview_16_21 {
    
    static func target(first: [Int], second: [Int]) -> Int? {
        let sum1 = first.reduce(0, +)
        let sum2 = second.reduce(0, +)
        
        let diff = sum1 - sum2
        
        return diff % 2 == 0 ? diff / 2 : nil
    }
    
    /// 暴力法 O(AxB)
    struct Solution1 {
        
        static func swpaToMakeSumEqual(first: [Int], second: [Int]) -> [Int]? {
            let sum1 = first.reduce(0, +)
            let sum2 = second.reduce(0, +)
            
            for fItem in first {
                for sItem in second {
                    let s1 = sum1 - fItem + sItem
                    let s2 = sum2 - sItem + fItem
                    if s1 == s2 {
                        return [fItem, sItem]
                    }
                }
            }
            
            return nil
        }
        
        
        // sum1 - a + b = sum2 - b + a
        static func swpaToMakeSumEqual2(first: [Int], second: [Int]) -> [Int]? {
            
            guard let diff = target(first: first, second: second) else {
                return nil
            }
            
            for fItem in first {
                for sItem in second {
                    if fItem - sItem == diff {
                        return [fItem, sItem]
                    }
                }
            }
            
            return nil
        }
        
    }
    
    // O(A+B)
    struct Solution2 {
        static func swpaToMakeSumEqual(first: [Int], second: [Int]) -> [Int]? {
           
            guard let diff = target(first: first, second: second) else {
                return nil
            }
            
            // 将second转成set
            var secondSet: [Int: Int] = [:]
            for item in second {
                secondSet[item] = item
            }
            
            // 遍历first
            for item in first {
                if let secondItem = secondSet[item - diff] {
                    return [item, secondItem]
                }
            }
            
            return nil
        }
    }
    
    // O(Alog(A)+Blog(B))
    struct Solution3 {
        static func swpaToMakeSumEqual(first: [Int], second: [Int]) -> [Int]? {
           
            guard let diff = target(first: first, second: second) else {
                return nil
            }
            
            // 排序
            let newF = first.sorted()
            let newS = second.sorted()
            
            var aIndex = 0
            var bIndex = 0
            
            while aIndex < newF.count, bIndex < newS.count {
                let di = newF[aIndex] - newS[bIndex]
                if di < diff {
                    /// 移动 first
                    aIndex += 1
                } else if di > diff {
                    // 移动 second
                    bIndex += 2
                } else {
                    return [newF[aIndex], newS[bIndex]]
                }
            }
            
            return nil
        }
    }
    
    static func test() {
        
        do {
            let a = [4, 1, 2, 1, 1, 2]
            let b = [3, 6, 3, 3]
            
            assert(Solution1.swpaToMakeSumEqual(first: a, second: b) == [4, 6])
            assert(Solution1.swpaToMakeSumEqual2(first: a, second: b) == [4, 6])
            assert(Solution2.swpaToMakeSumEqual(first: a, second: b) == [4, 6])
            assert(Solution3.swpaToMakeSumEqual(first: a, second: b) == [1, 3])
        }
        
        print("\(self) OVER")
    }
}
