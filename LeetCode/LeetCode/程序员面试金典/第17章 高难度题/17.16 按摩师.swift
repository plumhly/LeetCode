//
//  17.16 按摩师.swift
//  算法
//
//  Created by Plum on 2021/6/29.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P490
 
 17.16按摩师。一个有名的按摩师会收到源源不断的预约请求,每个预约都可以选择接或不接。
 在每次预约服务之间要有15分钟的休息时间，因此她不能接受时间相邻的预约。
 给定一个预约请求序列(都是15分钟的倍数,没有重叠,也无法移动),替按摩师找到最优的预约集合(总预约时间最长),返回总的分钟数。
 
 示例:
    输入:{30, 15, 60, 75, 45, 15, 15, 45}
    输出:180 minutes {30,60,45,45}
 
 (提示:494, 503, 515,525,541,553,561,#567,577 586 606)
 */

struct Interview_17_16 {
    
    // O(2^n)
    struct Solution1 {
        static func maxMinutes(in array: [Int] ) -> Int {
            guard array.count > 0 else {
                return 0
            }
            
            return maxMinutes(in: array, index: 0)
        }
        
        private static func maxMinutes(in array: [Int], index: Int) -> Int {
            guard index < array.count else {
                return 0
            }
            
            
            let containeCurrent = maxMinutes(in: array, index: index + 2) + array[index]
            let notContainCurrent = maxMinutes(in: array, index: index + 1)
            
            return max(containeCurrent, notContainCurrent)
        }
    }
    
    
    // 递归法
    // 时间复杂度：O(N)
    // 空间复杂度：O(N)
    struct Solution2 {
        static func maxMinutes(in array: [Int] ) -> Int {
            guard array.count > 0 else {
                return 0
            }
            
            var mem: [Int] = Array<Int>(repeating: 0, count: array.count)
            
            return maxMinutes(in: array, index: 0, mem: &mem)
        }
        
        private static func maxMinutes(in array: [Int], index: Int, mem: inout [Int]) -> Int {
            guard index < array.count else {
                return 0
            }
            
            if mem[index] > 0 {
                return mem[index]
            }
            
            
            let containeCurrent = maxMinutes(in: array, index: index + 2, mem: &mem) + array[index]
            let notContainCurrent = maxMinutes(in: array, index: index + 1, mem: &mem)
            
            mem[index] = max(containeCurrent, notContainCurrent)
            
            return mem[index]
        }
    }
    
    // 迭代法
    // 时间复杂度：O(N)
    // 空间复杂度：O(N)
    struct Solution3 {
        static func maxMinutes(in array: [Int] ) -> Int {
            guard array.count > 0 else {
                return 0
            }
            
            var mem: [Int] = Array<Int>(repeating: 0, count: array.count + 2)
            
            for index in stride(from: array.count - 1, through: 0, by: -1) {
                let bestWith = array[index] + mem[index + 2]
                let bestWithout = mem[index + 1]
                mem[index] = max(bestWith, bestWithout)
            }
            
            return mem[0]
        }
    
    }
    
    // 迭代法
    // 时间复杂度：O(N)
    // 空间复杂度：O(1)
    struct Solution4 {
        static func maxMinutes(in array: [Int] ) -> Int {
            guard array.count > 0 else {
                return 0
            }
            
            var nextOne = 0
            var nextTwo = 0
            
            for index in stride(from: array.count - 1, through: 0, by: -1) {
                let bestWith = array[index] + nextTwo
                let bestWithout = nextOne
                
                let current = max(bestWith, bestWithout)
                nextTwo = nextOne
                nextOne = current
            }
            
            return nextOne
        }
    
    }
    
    
    static func test() {
        
        let a = [30, 15, 60, 75, 45, 15, 15, 45]
        assert(Solution1.maxMinutes(in: a) == 180)
        assert(Solution2.maxMinutes(in: a) == 180)
        assert(Solution3.maxMinutes(in: a) == 180)
        assert(Solution4.maxMinutes(in: a) == 180)
        
        print("\(self) OVER")
    }
}
