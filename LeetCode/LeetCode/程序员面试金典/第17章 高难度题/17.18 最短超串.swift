//
//  17.18 最短超串.swift
//  算法
//
//  Created by Plum on 2021/7/3.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P498
 
 17.18最短超串。假设你有两个数组,一个长一个短,短的元素均不相同。找到长数组中包含短数组所有的元素的最短子数组,其出现顺序无关紧要
 
 示例:
    输入:{1,5,9} | {7,5,9,0,2,1,3,5,7,9,1,1,5,8,8,9,7}
                                 -------
    输出:[7,10]
 
 (提示:644,651,668,#680,690,#724,#730,740)
 */

struct Interview_17_18 {
    
    struct Range {
        let start: Int
        let end: Int
        
        var length: Int {
            return end - start + 1
        }
        
        func isShortThan(other: Range) -> Bool {
            return length < other.length
        }
    }
    
    
    // O(SB^2), 短数组长度，长数组长度
    struct Solution1 {
        static func findMinLcoaltion(on bigger: [Int], shorter: [Int]) -> Range? {
            guard shorter.count <= bigger.count else {
                return nil
            }
            
            var start: Int? = nil
            var end: Int? = nil
            
            for index in 0 ..< bigger.count {
                if let idx = endIndex(bigger: bigger, shorter: shorter, bigIndex: index) {
                    
                    if start == nil && end == nil {
                        start = index
                        end = idx
                    } else {
                        if idx - index < end! - start! {
                            start = index
                            end = idx
                        }
                    }
                } else {
                    break
                }
            }
            
            return start == nil ? nil : Range(start: start!, end: end!)
        }
        
        private static func endIndex(bigger: [Int], shorter: [Int], bigIndex: Int) -> Int? {
            var index = -1
            for item in shorter {
                if let idx = self.index(in: bigger, value: item, startIndex: bigIndex) {
                    index = max(index, idx)
                } else {
                    break
                }
            }
            
            return index == -1 ? nil : index
        }
        
        private static func index(in array: [Int], value: Int, startIndex: Int) -> Int? {
            guard startIndex < array.count else {
                return nil
            }
            
            var index: Int? = nil
            for idx in startIndex ..< array.count {
                if array[idx] == value {
                    index = idx
                    break
                }
            }
            
            return index
        }
    }
    
    
    // 时间：O(SB)
    // 空间：O(SB)
    struct Solution2 {
        static func findMinLcoaltion(on bigger: [Int], shorter: [Int]) -> Range? {
            
            guard shorter.count <= bigger.count, let indexInfoArray = createIndexInfo(on: bigger, shorter: shorter) else {
                return nil
            }
            
            let closure = createClosureInfo(on: indexInfoArray)
            
            return findRange(in: closure)
        }
        
        private static func createIndexInfo(on bigger: [Int], shorter: [Int]) -> [[Int]]? {
            
            var result: [[Int]]? = []
            
            for item in shorter {
                var tempInfo = Array<Int>(repeating: -1, count: bigger.count)
                var preIndex: Int?
                
                for index in stride(from: bigger.count - 1, through: 0, by: -1) {
                    if bigger[index] == item {
                        tempInfo[index] = index
                        preIndex = index
                    } else if let p = preIndex {
                        tempInfo[index] = p
                    }
                }
                
                if preIndex == nil {
                    result = nil
                    break;
                } else {
                    result?.append(tempInfo)
                }
            }
         
            return result
        }
        
        private static func createClosureInfo(on array: [[Int]]) -> [Int] {
            
            let lenght = array[0].count
            var result: [Int] = Array<Int>(repeating: -1, count: lenght)
            
            for index in 0 ..< lenght {
                var maxValue = -1;
                for item in array {
                    /// ⚠️，如果是其中有值是-1，表明从该index之后，不能满足shorter数组的元素在后面出现。
                    if item[index] == -1 {
                        maxValue = -1
                        break
                    }
                    
                    maxValue = max(item[index], maxValue)
                }
                
                /// 提前终止
                if (maxValue == -1) {
                    break
                }
                
                result[index] = maxValue
            }
            
            return result
        }
        
        
        private static func findRange(in array: [Int]) -> Range {
            var start = 0
            var end = array.count - 1
            
            for (index, value) in array.enumerated() {
                let result = value - index
                if result < 0 {
                    break
                } else if result < end - start {
                    start = index
                    end = value
                }
            }
            
            return Range(start: start, end: end)
        }
        
    }
    
    // 时间：O(SB)
    // 空间：O(B)
    struct Solution3 {
        static func findMinLcoaltion(on bigger: [Int], shorter: [Int]) -> Range? {
            
            guard shorter.count <= bigger.count, let closure = createClosureInfo(on: bigger, shorter: shorter) else {
                return nil
            }
            
            
            return findRange(in: closure)
        }
        
        private static func createClosureInfo(on bigger: [Int], shorter: [Int]) -> [Int]? {
            
            var result = [Int](repeating: -1, count: bigger.count)
            
            for (shortIndex, item) in shorter.enumerated() {
                var preIndex: Int?
                
                for index in stride(from: bigger.count - 1, through: 0, by: -1) {
                    if bigger[index] == item {
                        
                        /// ⚠️ 一定要满足 result[index] < index
                        if (result[index] > 0 && result[index] < index) || shortIndex == 0 {
                            result[index] = index
                        }
                        
                        preIndex = index
                    } else {
                        if let p = preIndex {
                            if shortIndex == 0 {
                                result[index] = p
                            } else {
                                if result[index] > 0, p > result[index] {
                                    result[index] = p
                                }
                            }
                        } else {
                            result[index] = -1
                        }
                    }
                }
                
                if preIndex == nil {
                    return nil
                }
                
            }
         
            return result
        }
        
        
        private static func findRange(in array: [Int]) -> Range {
            var start = 0
            var end = array.count - 1
            
            for (index, value) in array.enumerated() {
                let result = value - index
                if result < 0 {
                    break
                } else if result < end - start {
                    start = index
                    end = value
                }
            }
            
            return Range(start: start, end: end)
        }
        
    }
    
    /// 见答案
    /*
     P503
     */
    struct Solution4 {
        
    }
    
    
    static func test() {
        
        let shorter = [1, 5, 9]
        let bigger = [7,5,9,0,2,1,3,5,7,9,1,1,5,8,8,9,7]
        
        do {
            let result = Solution1.findMinLcoaltion(on: bigger, shorter: shorter)
            assert(result?.start == 7 && result?.end == 10)
        }
        
        do {
            let result = Solution2.findMinLcoaltion(on: bigger, shorter: shorter)
            assert(result?.start == 7 && result?.end == 10)
        }
        
        do {
            let result = Solution3.findMinLcoaltion(on: bigger, shorter: shorter)
            assert(result?.start == 7 && result?.end == 10)
        }
        
        
        print("\(self) OVER")
    }
}
