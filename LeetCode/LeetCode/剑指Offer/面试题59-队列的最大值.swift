//
//  面试题59-队列的最大值.swift
//  LeetCode
//
//  Created by Plum on 2020/7/7.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题59:队列的最大值
 
 P287
 
 
 */

struct Topic59 {
    
    /*
     题目一:滑动窗口的最大值。
     
      P287
     
     给定一个数组和滑动窗口的大小,请找出所有滑动窗口里的最大值。
     例如,如果输入数组{2,3,4,2,6,2,5,1}及滑动窗口的大小3,那么一共存在6个滑动窗口,它们的最大值分别为{4,4,6,6,6,5},如表63所示。
     
     分析：
     下面換一种思路。我们并不把滑动窗口的每个数值都存入队列,而是只把有可能成为滑动窗口最大值的数值存入一个两端开口的队列(如C++ 标准模板库中的 deque)。接着以输入数组{2,3,4,2,6,2,5,1}为例一步步分析。
     数组的第一个数字是2,把它存入队列。第二个数字是3,由于它比前一个数字2大,因此2不可能成为滑动窗口中的最大值。先把2从队列里删除,再把3存入队列。此时队列中只有一个数字3。针对第三个数字4的步骤类似,最终在队列中只剩下一个数字4。此时滑动窗口中己经有3个数字,而它的最大值4位于队列的头部
     */
    struct Topic1 {
        static func findMaxValueInWindow(array: [Int], size: Int) -> [Int]? {
            
            /// ⚠️ size > 0
            guard array.count >= size, size > 0 else {
                return nil
            }
            
            var indexes: [Int] = []
            for i in 0..<size {
                /// ⚠️
                /// 1 last
                /// 2 >=
                while !indexes.isEmpty, let last = indexes.last, array[i] >= array[last] {
                    indexes.removeLast()
                }
                indexes.append(i)
            }
            
            var result: [Int] = []
            for i in size..<array.count {
                result.append(array[indexes.first!])
                
                while !indexes.isEmpty, let last = indexes.last, array[i] >= array[last] {
                    indexes.removeLast()
                }
                
                if !indexes.isEmpty, let first = indexes.first, i - size >= first {
                    indexes.removeFirst()
                }
                indexes.append(i)
            }
            result.append(array[indexes.first!])
            
            return result
        }
        
        
        static func test() {
            let a = [2,3,4,2,6,2,5,1]
            let result = findMaxValueInWindow(array: a, size: 3)
            assert(result == [4, 4, 6, 6, 6, 5])
            print("Topic59.Topic1 OVER")
        }
    }
    

    /*
     题目二:队列的最大值请定义一个队列并实现函数max得到队列里的最大值,要求函数max、push back和 pop front的时间复杂度都是O(1)。
     
     P292
     
     */
    struct Topic2 {
        
        struct MaxQueue {
            var currentIndex = 0
            var max: [(value: Int, index: Int)] = []
            var data: [(value: Int, index: Int)] = []
            
            mutating func enqueue(number: Int) {
                while !max.isEmpty, let tuple = max.last, tuple.value <= number  {
                    max.removeLast()
                }
                let value = (number, currentIndex)
                max.append(value)
                data.append(value)
                currentIndex += 1
            }
            
            @discardableResult
            mutating func dequeue() -> Int? {
                guard !data.isEmpty else {
                    return nil
                }
                 
                let dataTuple = data.removeFirst()
                
                if let maxTuple = max.first, maxTuple.index == dataTuple.index {
                    max.removeFirst()
                }
                return dataTuple.value
            }
            
            func maxValue() -> Int? {
                guard !max.isEmpty else { return nil }
                return max.first!.value
            }
        }
        
        
        static func test() {
            var queue = MaxQueue()
            queue.enqueue(number: 1)
            assert(queue.maxValue() == 1)
            
            queue.enqueue(number: 2)
            assert(queue.maxValue() == 2)
            queue.enqueue(number: 3)
            assert(queue.maxValue() == 3)
            queue.enqueue(number: 2)
            
            queue.dequeue()
            queue.dequeue()
            queue.dequeue()
            assert(queue.maxValue() == 2)
            queue.dequeue()
            assert(queue.maxValue() == nil)
            print("Topic59.Topic2 OVER")
        }
        
    }
}
