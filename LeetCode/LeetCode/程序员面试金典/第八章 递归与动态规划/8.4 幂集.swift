//
//  8.4 幂集.swift
//  算法
//
//  Created by Plum on 2021/3/20.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation
/*
 8.4幂集。编写一种方法,返回某集合的所有子集。(提示:#273,#290,#338,#354,#373)
 */

struct Interview_8_4 {
    
    /*
     中添加a3
     P(2)={},{a},{a2},{a1,a2}
     P(2)+a3={a3},{a1,a3},{a2,a3},{a1,a2,a3
     两者合并在一起,即可产生P(3)

     */
    struct Solution1 {
        
        static func getSubset(set: [Int]) -> [[Int]] {
            guard !set.isEmpty else {
                return []
            }
            
            return getSubset(set: set, index: set.count - 1)
        }
        
        
        static func getSubset(set: [Int], index: Int) -> [[Int]] {
            guard index >= 0 else {
                return [[]]
            }
            
            var subset = getSubset(set: set, index: index - 1)
            
            // 添加新的元素
            let item = set[index]
            let moreSet = subset.map { items -> [Int] in
                var result = Array(items)
                result.append(item)
                return result
            }
            
            /// 放入其中
            subset.append(contentsOf: moreSet)
            return subset
        }
    }
    
    struct Solution2 {
        static func getSubset(set: [Int]) -> [[Int]] {
            guard !set.isEmpty else {
                return []
            }
            
            let max = 1 << set.count
            var allSet: [[Int]] = []
            for i in 0..<max {
                allSet.append(coverToSet(x: i, set: set))
            }
            return allSet
        }
        
        private static func coverToSet(x: Int, set: [Int]) -> [Int] {
            var index = 0
            var newSet: [Int] = []
            
            for i in sequence(first: x, next: { $0 > 0 ? $0>>1 : nil }) {
                if i & 1 == 1  {
                    newSet.append(set[index])
                }
                index += 1
            }
            return newSet
        }
    }
    
    static func test() {
        let a = [1, 2, 3]
        print(Solution1.getSubset(set: a))
        print(Solution2.getSubset(set: a))
    }
}
