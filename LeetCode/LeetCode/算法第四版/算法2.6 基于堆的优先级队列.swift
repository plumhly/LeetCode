//
//  算法2.6 基于堆的优先级队列.swift
//  LeetCode
//
//  Created by Plum on 2020/7/20.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

struct MinPriorityQuque<E: Comparable> {
    private var values: [E]
    
    var count: Int {
        return values.count
    }
    
    init(count: Int) {
        values = []
    }
    
    private mutating func swim(at index: Int) {
        var index = index
        
        while index > 0 {
            // 和父节点比较 (k - 1) / 2
            let parentIndex =  (index - 1) / 2
            guard values[parentIndex] > values[index] else {
                return
            }
            
            // 交换父节点和子节点
            values.swapAt(parentIndex, index)
            index = parentIndex
        }
    }

    
    private mutating func sink(at index: Int) {
        var index = index
        while (2 * index + 1) < values.count {
            // 寻找最大的子节点
            var minIndex = 2 * index + 1
            let rightIndex = minIndex + 1
            if rightIndex <= count, values[minIndex] > values[rightIndex] {
                minIndex = rightIndex
            }
            guard values[minIndex] < values[index] else {
                return
            }
            
            values.swapAt(index, minIndex)
            index = minIndex
        }
    }
    
    mutating func insert(value: E) {
        values.append(value)
        // 上浮
        swim(at: count - 1)
    }
    
    mutating func deleteMinValue() -> E? {
        // root
        guard !values.isEmpty else {
            return nil
        }
        // 第一个元素和最后一个元素交换
        values.swapAt(0, count - 1)
        
        // 移除最后一个
        let min = values.removeLast()
        
        // xiachen
        sink(at: 0)
        return min
    }
}

struct MaxPriorityQuque<E: Comparable> {
    private var values: [E]
    
    var count: Int {
        return values.count
    }
    
    init(count: Int) {
        values = []
    }
    
    private mutating func swim(at index: Int) {
        var index = index
        
        while index > 0 {
            // 和父节点比较 (k - 1) / 2
            let parentIndex =  (index - 1) / 2
            guard values[parentIndex] < values[index] else {
                return
            }
            
            // 交换父节点和子节点
            values.swapAt(parentIndex, index)
            index = parentIndex
        }
    }

    
    private mutating func sink(at index: Int) {
        var index = index
        while (2 * index + 1) < values.count {
            // 寻找最大的子节点
            var maxIndex = 2 * index + 1
            let rightIndex = maxIndex + 1
            if rightIndex <= count, values[maxIndex] < values[rightIndex] {
                maxIndex = rightIndex
            }
            guard values[maxIndex] > values[index] else {
                return
            }
            
            values.swapAt(index, maxIndex)
            index = maxIndex
        }
    }
    
    mutating func insert(value: E) {
        values.append(value)
        // 上浮
        swim(at: count - 1)
    }
    
    mutating func deleteMaxValue() -> E? {
        // root
        guard !values.isEmpty else {
            return nil
        }
        // 第一个元素和最后一个元素交换
        values.swapAt(0, count - 1)
        
        // 移除最后一个
        let max = values.removeLast()
        
        // xiachen
        sink(at: 0)
        return max
    }
}

struct Test {
    static func testMaxPriorityQueue() {
        var maxQueue = MaxPriorityQuque<Int>(count: 3)
        assert(maxQueue.deleteMaxValue() == nil)
        
        maxQueue.insert(value: 1)
        assert(maxQueue.deleteMaxValue() == 1)
        
        maxQueue.insert(value: 2)
        maxQueue.insert(value: 3)
        assert(maxQueue.deleteMaxValue() == 3)
        assert(maxQueue.deleteMaxValue() == 2)
        print("MaxPriorityQuque OVER")
        
        
        var minQueue = MinPriorityQuque<Int>(count: 3)
        assert(minQueue.deleteMinValue() == nil)
        
        minQueue.insert(value: 1)
        assert(minQueue.deleteMinValue() == 1)
        
        minQueue.insert(value: 2)
        minQueue.insert(value: 3)
        assert(minQueue.deleteMinValue() == 2)
        assert(minQueue.deleteMinValue() == 3)
        print("MinPriorityQuque OVER")
        
    }
}
