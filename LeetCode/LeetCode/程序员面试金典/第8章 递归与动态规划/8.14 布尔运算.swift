//
//  8.14 布尔运算.swift
//  算法
//
//  Created by Plum on 2021/5/19.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 8.14布尔运算给定一个布尔表达式和一个期望的布尔结果 result,布尔表达式由0、1、&、|和^符号组成。实现一个函数,算出有几种可使该表达式得出 result值的括号方法。
 该表达式要用全括号(如()^(1))表示,而不能包含半括号(如(()^(1))
 示例:
  counteval("1^0|0|1", false)->2
  counteval("0&0&0&1^1|0",true)->10
 (提示:#148,#168,#197,#305,#327)
 */

struct Interview_8_14 {
    
    struct Solution1 {
        static func countEval(s: String, result: Bool) -> Int {
            guard s.count > 0 else {
                return 0
            }
            
            if s.count == 1 {
                return (s == "1" && result) || (s == "0" && !result) ? 1 : 0
            }
            
            var way = 0
            for index in s.indices where s.distance(from: s.startIndex, to: index) & 1 == 1 {
                let left = String(s[...s.index(before: index)])
                let right = String(s[s.index(after: index)...])
                
                let leftTrue = countEval(s: left, result: true)
                let leftFalse = countEval(s: left, result: false)
                
                let rightTrue = countEval(s: right, result: true)
                let rightFalse = countEval(s: right, result: false)
                
                let total = (leftTrue + leftFalse) * (rightTrue + rightFalse)
                var totalTrue = 0
                
                switch s[index] {
                case Character("^"):
                    totalTrue = leftTrue * rightFalse + leftFalse * rightTrue
                    
                case Character("|"):
                    totalTrue = leftTrue * rightFalse + leftFalse * rightTrue + leftTrue * rightTrue
                    
                case Character("&"):
                    totalTrue = leftTrue * rightTrue
                
                default:
                    break;
                }
                
                let ways = result ? totalTrue : total - totalTrue
                way += ways
            }
            
            return way
        }
    }
    
    struct Solution2 {
        
        static func countEval(s: String, result: Bool) -> Int {
            var map: [String: Int] = [:]
            return countEval(s: s, result: result, results: &map)
        }
        
        private static func countEval(s: String, result: Bool, results: inout [String: Int]) -> Int {
            guard s.count > 0 else {
                return 0
            }
            
            if s.count == 1 {
                return (s == "1" && result) || (s == "0" && !result) ? 1 : 0
            }
            
            if let value = results[s] {
                return value
            }
            
            var way = 0
            for index in s.indices where s.distance(from: s.startIndex, to: index) & 1 == 1 {
                let left = String(s[...s.index(before: index)])
                let right = String(s[s.index(after: index)...])
                
                let leftTrue = countEval(s: left, result: true)
                let leftFalse = countEval(s: left, result: false)
                
                let rightTrue = countEval(s: right, result: true)
                let rightFalse = countEval(s: right, result: false)
                
                let total = (leftTrue + leftFalse) * (rightTrue + rightFalse)
                var totalTrue = 0
                
                switch s[index] {
                case Character("^"):
                    totalTrue = leftTrue * rightFalse + leftFalse * rightTrue
                    
                case Character("|"):
                    totalTrue = leftTrue * rightFalse + leftFalse * rightTrue + leftTrue * rightTrue
                    
                case Character("&"):
                    totalTrue = leftTrue * rightTrue
                
                default:
                    break;
                }
                
                let ways = result ? totalTrue : total - totalTrue
                way += ways
            }
            
            results[s] = way
            return way
        }
    }
    
    
    
    static func test() {
        let s1 = "1^0|0|1"
        let s2 = "0&0&0&1^1|0"
        assert(Solution1.countEval(s: s1, result: false) == 2)
        assert(Solution1.countEval(s: s2, result: true) == 10)
        print("Interview_8_14 Solution1 Over")
        
        assert(Solution2.countEval(s: s1, result: false) == 2)
        assert(Solution2.countEval(s: s2, result: true) == 10)
        print("Interview_8_14 Solution2 Over")
    }
}
