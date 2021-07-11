//
//  17.8 马戏团人塔.swift
//  算法
//
//  Created by Plum on 2021/6/19.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P465
 
 17.8 马戏团人塔。有个马戏团正在设计叠罗汉的表演节目,一个人要站在另一人的肩上出于实际和美观的考虑,
 在上面的人要比下面的人矮一点且轻一点,已知马戏团每个人的身高和体重,请编写代码计算叠罗汉最多能叠几个人

 示例:
    输入:(ht,wt): (65, 100) (70, 150) (56, 90) (75,190) (60, 95) (68, 110)
    输出: 从上往下数,叠罗汉最多能叠6层: (56,90) (60, 95) (65, 100) (68,110) (70, 150) (75,190)
 
 (提示:637 656 665 681 698)
 */

struct Interview_17_8 {
    
    typealias Body = (hegiht: Int, weight: Int)
    
    /// 时间复杂度 O(2^N)
    struct Solution1 {
        static func maxHeight(in array: [Body]) -> [Body] {
            let array = array.sorted { $0.hegiht <= $1.hegiht }
            return maxHeight(in: array, currentIndex: 0, sequence: [])
        }
        
        private static func maxHeight(in array: [Body], currentIndex: Int, sequence: [Body]) -> [Body] {
            guard currentIndex < array.count else {
                return sequence
            }
            
            let value = array[currentIndex]
            
            var addValueIn: [Body] = []
            if canAdd(in: sequence, value: value) {
                var sequence = sequence
                sequence.append(value)
                addValueIn = maxHeight(in: array, currentIndex: currentIndex + 1, sequence: sequence)
            }
            
            let withoutAddIn = maxHeight(in: array, currentIndex: currentIndex + 1, sequence: sequence)
            
            return addValueIn.count > withoutAddIn.count ? addValueIn : withoutAddIn
        }
    }
    
    static func canAdd(in array: [Body], value: Body) -> Bool {
        guard array.count > 0 else {
            return true
        }
        
        let last = array.last!
        
        return last.hegiht <= value.hegiht && last.weight <= value.weight
    }
    
    /// 时间复杂度 O(N^2)
    struct Solution2 {
        static func maxHeight(in array: [Body]) -> [Body] {
            let array = array.sorted { $0.hegiht <= $1.hegiht }
            
            return findLongest(in: array)
        }
        
        private static func findLongest(in array: [Body]) -> [Body] {
            var best: [Body] = []
            var solutions = Array<Array<Body>>(repeating: [], count: array.count)
            for i in 0..<array.count {
                let maybeBest = findBest(in: array, solutions: &solutions, currentIndex: i)
                if maybeBest.count > best.count {
                    best = maybeBest
                }
            }
            
            return best
        }
        
        private static func findBest(in array: [Body], solutions: inout [[Body]], currentIndex: Int) -> [Body] {
            
            var best: [Body] = []
            
            let value = array[currentIndex]
            for i in 0...currentIndex {
                var solution = solutions[i]
                if canAdd(in: solution, value: value) {
                    solution.append(value)
                    solutions[i] = solution
                }
                if solution.count > best.count {
                    best = solution
                }
            }
            
            return best
        }
    }
    
    
    static func test() {
        
        let input = [(65, 100), (70, 150), (56, 90), (75,190), (60, 95), (68, 110)]
        print(Solution1.maxHeight(in: input))
        print(Solution2.maxHeight(in: input))
        
        print("\(self) OVER")
    }
}
