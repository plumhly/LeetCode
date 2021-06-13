//
//  16.11 跳水板.swift
//  算法
//
//  Created by Plum on 2021/6/9.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P410
 
 16.11跳水板,你正在使用一堆木板建造跳水板有两种类型的木板,其中一种长度较短(长
 度记为 shorter）。一种长度较长(长度记为longer）。你必须正好使用块木板编写
 一个方法,生成跳水板所有可能的长度。
 */

struct Interview_16_11 {
    
    struct Solution1 {
        static func getLength(k: Int, shorter: Int, longer: Int) -> Set<Int> {
            var result: Set<Int> = []
            
            getLength(total: 0, k: k, shorter: shorter, longer: longer, result: &result)
            
            return result
        }
        
        private static func getLength(total: Int, k: Int, shorter: Int, longer: Int, result: inout Set<Int>) {
            guard k > 0 else {
                result.insert(total)
                return
            }
            
            getLength(total: total + shorter, k: k - 1, shorter: shorter, longer: longer, result: &result)
            getLength(total: total + longer, k: k - 1, shorter: shorter, longer: longer, result: &result)
        }
    }
    
    /// O(K^2)
    struct Solution2 {
        static func getLength(k: Int, shorter: Int, longer: Int) -> Set<Int> {
            var result: Set<Int> = []
            var visited: [String: Int] = [:]
            getLength(total: 0, k: k, shorter: shorter, longer: longer, result: &result, visited: &visited)
            
            return result
        }
        
        private static func getLength(total: Int, k: Int, shorter: Int, longer: Int, result: inout Set<Int>, visited: inout [String: Int]) {
            guard k > 0 else {
                result.insert(total)
                return
            }
            
            let key = "\(k) \(total)"
            
            if let _ = visited[key] {
                /// 这里表明，这个长度之前出现过，那么后面的所有情况已经考虑了，不用重复计算了
                return
            }
            
            getLength(total: total + shorter, k: k - 1, shorter: shorter, longer: longer, result: &result, visited: &visited)
            getLength(total: total + longer, k: k - 1, shorter: shorter, longer: longer, result: &result, visited: &visited)
            
            visited[key] = total
        }
    }
    
    
    // O(K)
    struct Solution3 {
        static func getLength(k: Int, shorter: Int, longer: Int) -> Set<Int> {
            var result: Set<Int> = []
            for numer in 0...k {
                let shortNumber = numer
                let longNumber = k -  numer
                let sum = shorter * shortNumber + longNumber * longer
                
                result.insert(sum)
            }
            
            return result
        }
    }
    
    
    static func test() {
        
        print(Solution1.getLength(k: 2, shorter: 1, longer: 2))
        print(Solution2.getLength(k: 2, shorter: 1, longer: 2))
        print(Solution3.getLength(k: 2, shorter: 1, longer: 2))
        print("\(self) OVER")
    }
}
