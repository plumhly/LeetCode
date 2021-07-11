//
//  17.21 直方图的水量.swift
//  算法
//
//  Created by Plum on 2021/7/7.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P509
 
 17.21直方图的水量。给定一个直方图(也称柱状图)假设有人从上面源源不断地倒水,最后直方图能存多少水量?直方图的宽度为1
 
示例(黑色部分是直方图,灰色部分是水)
    输入:(0,0,4,0,0,6,0,0,3,0,5,0,1,0,0,0)
    输出：26
 */

struct Interview_17_21 {
    
    /// O(N^2) （findMaxValueIndex这个方法在每次都是 start..end）
    struct Solution1 {
        static func computeVolume(in array: [Int]) -> Int {
            guard array.count > 0 else {
                return 0
            }
            
            let maxIndex = findMaxValueIndex(from: 0, to: array.count - 1, in: array)
            
            let leftArea = computeSubArea(in: array, start: 0, end: maxIndex, isLeft: true)
            let rightArea = computeSubArea(in: array, start: maxIndex, end: array.count - 1, isLeft: false)
        
            return leftArea + rightArea
        }
        
        
        /// ⚠️ 这里计算index
        private static func findMaxValueIndex(from: Int, to: Int, in array: [Int]) -> Int {
            var max = from
            for i in from...to {
                if array[max] < array[i] {
                    max = i
                }
            }
            
            return max
        }
        
        private static func computeSubArea(in array: [Int], start: Int, end: Int, isLeft: Bool) -> Int {
            guard start < end else {
                return 0
            }
            
            var sum = 0
            if isLeft {
                let index = findMaxValueIndex(from: start, to: end - 1, in: array)
                sum += area(in: array, start: index, end: end)
                sum += computeSubArea(in: array, start: start, end: index, isLeft: isLeft)
            } else {
                let index = findMaxValueIndex(from: start + 1, to: end, in: array)
                sum += area(in: array, start: start, end: index)
                sum += computeSubArea(in: array, start: index, end: end, isLeft: isLeft)
            }
            
            return sum
        }
        
        private static func area(in array: [Int], start: Int, end: Int) -> Int {
            guard start < end else {
                return 0
            }
            
            let minValue = min(array[start], array[end])
            
            var sum = 0
            for i in (start + 1)..<end {
                sum += minValue - array[i]
            }
            
            return sum
        }
        
    }
    
    
    /// O(N)
    struct Solution2 {
        static func computeVolume(in array: [Int]) -> Int {
            guard array.count > 0 else {
                return 0
            }
            
            let rightToLeft = creatRightToLeftMaxInfo(in: array)
            let leftToRight = creatLeftToRightMaxInfo(in: array)
            
            let maxIndex = rightToLeft[0]
            
            let leftArea = computeSubArea(in: array, start: 0, end: maxIndex, isLeft: true, indexInfo: leftToRight)
            let rightArea = computeSubArea(in: array, start: maxIndex, end: array.count - 1, isLeft: false, indexInfo: rightToLeft)
        
            return leftArea + rightArea
        }
        
        
        /// 左边的最大值
        private static func creatLeftToRightMaxInfo(in array: [Int]) -> [Int] {
            var result: [Int] = []
            var maxIndex = 0
            for i in 0..<array.count {
                if array[maxIndex] < array[i] {
                    maxIndex = i
                }
                
                result.append(maxIndex)
            }
            
            return result
        }
        
        /// 右边的最大值
        private static func creatRightToLeftMaxInfo(in array: [Int]) -> [Int] {
            var result: [Int] = Array<Int>(repeating: 0, count: array.count)
            var maxIndex = array.count - 1
            for i in stride(from: array.count - 1, through: 0, by: -1) {
                if array[maxIndex] < array[i] {
                    maxIndex = i
                }
                
                result[i] = maxIndex
            }
            
            return result
        }
        
        private static func computeSubArea(in array: [Int], start: Int, end: Int, isLeft: Bool, indexInfo: [Int]) -> Int {
            guard start < end else {
                return 0
            }
            
            var sum = 0
            if isLeft {
                let index = indexInfo[end - 1]
                sum += area(in: array, start: index, end: end)
                sum += computeSubArea(in: array, start: start, end: index, isLeft: isLeft, indexInfo: indexInfo)
            } else {
                let index = indexInfo[start + 1]
                sum += area(in: array, start: start, end: index)
                sum += computeSubArea(in: array, start: index, end: end, isLeft: isLeft, indexInfo: indexInfo)
            }
            
            return sum
        }
        
        private static func area(in array: [Int], start: Int, end: Int) -> Int {
            guard start < end else {
                return 0
            }
            
            let minValue = min(array[start], array[end])
            
            var sum = 0
            for i in (start + 1)..<end {
                sum += minValue - array[i]
            }
            
            return sum
        }
        
    }
    
    /// O(N)
    struct Solution3 {
        static func computeVolume(in array: [Int]) -> Int {
            guard array.count > 0 else {
                return 0
            }
            
            var leftMax: [Int] = []
            var maxValue = 0
            for i in 0..<array.count {
                if maxValue < array[i] {
                    maxValue = array[i]
                }
                
                leftMax.append(maxValue)
            }
            
            var maxRightValue = 0
            
            var sum = 0
            
            for i in stride(from: array.count - 1, through: 0, by: -1) {
                if maxRightValue < array[i] {
                    maxRightValue = array[i]
                }
                
                /// 变换了左边和右边
                let minValue = min(maxRightValue, leftMax[i])
                if array[i] < minValue {
                    sum += minValue - array[i]
                }
            }
            
            
            return sum
        }
    }
    
    
    static func test() {
        let array = [0,0,4,0,0,6,0,0,3,0,5,0,1,0,0,0]
        assert(Solution1.computeVolume(in: array) == 26)
        assert(Solution2.computeVolume(in: array) == 26)
        assert(Solution3.computeVolume(in: array) == 26)
        print("\(self) OVER")
    }
}
