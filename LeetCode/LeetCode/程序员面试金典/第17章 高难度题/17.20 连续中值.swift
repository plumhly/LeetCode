//
//  17.20 连续中值.swift
//  算法
//
//  Created by Plum on 2021/7/4.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 17.20连续中值。随机产生数字并传递给一个方法。你能否完成这个方法,在每次产生新值时寻找当前所有值的中间值并保存。
 
 ##中位数，又称中点数，中值。中位数是按顺序排列的一组数据中居于中间位置的数，即在这组数据中，有一半的数据比他大，有一半的数据比他小，这里用来表示中位数。
 （注意：中位数和众数不同，众数指最多的数，众数有时不止一个，而中位数只能有一个。）
 
 (提示:518,545,574,708)
 */


struct Interview_17_20 {
    
    struct MaxModel: Comparable {
        
        static func < (lhs: MaxModel, rhs: MaxModel) -> Bool {
            return lhs.value > rhs.value
        }
        
        let value: Int
        
        init(value: Int) {
            self.value = value
        }
        
    }
    
    struct MinModel: Comparable {
        
        static func < (lhs: MinModel, rhs: MinModel) -> Bool {
            return lhs.value < rhs.value
        }
        
        let value: Int
        
        init(value: Int) {
            self.value = value
        }
        
    }
    
    /// 大顶堆：存放小于中位数的值
    static var maxHeap = PriorityQueue<MaxModel>()
    static var minHeap = PriorityQueue<MinModel>()
    
    static func add(number: Int) {
        if maxHeap.size == minHeap.size {
            if maxHeap.size > 0, number > minHeap.peek()!.value  {
                let v = try! minHeap.remove().value
                maxHeap.add(MaxModel(value: v))
                minHeap.add(MinModel(value: number))
            } else {
                maxHeap.add(MaxModel(value: number))
            }
        } else {
            if number < maxHeap.peek()!.value {
                let v = try! maxHeap.remove().value
                minHeap.add(MinModel(value: v))
                maxHeap.add(MaxModel(value: number))
            } else {
                minHeap.add(MinModel(value: number))
            }
        }
    }
    
    static func printMedia() -> Double? {
        guard maxHeap.size > 0 else {
            return nil
        }
        
        if maxHeap.size == minHeap.size {
            return (Double(maxHeap.peek()!.value) + Double(minHeap.peek()!.value)) / 2
        } else {
            return Double(maxHeap.peek()!.value)
        }
    }
    
    static func test() {
        
        assert(printMedia() == nil)
        add(number: 1)
        assert(printMedia() == 1)
        add(number: 3)
        assert(printMedia() == 2)
        
        add(number: 4)
        assert(printMedia() == 3)
        
        add(number: 2)
        assert(printMedia() == 2.5)
        
        add(number: 5)
        assert(printMedia() == 3)

        
        print("\(self) OVER")
    }
}
