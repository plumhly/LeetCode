//
//  17.14 最小k个数.swift
//  算法
//
//  Created by Plum on 2021/6/24.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P484
 
 17.14最小k个数。设计一个算法,找出数组中最小的k个数。
 
 (提示:#469,#529,#551,#592 #624,#646,#660,#677)
 */

struct Interview_17_14 {
    
    /// 暴力法
    struct Solution1 {
        
    }
    
    // O(Nlog(K))
    struct Solution2 {
        struct PriorityQueue<E: Comparable> {
            var array: [E] = []
            
            let size: Int
            
            init(size: Int) {
                self.size = size
            }
            
            var isEmpty: Bool {
                return array.isEmpty
            }
            
            mutating
            func add(element: E) {
                array.append(element)
                if array.count == size {
                    let lastNode = (array.count - 1 - 1) / 2
                    heapfy(at: lastNode)
                }
                
            }
            
            // 这里必须是父节点
            mutating
            private func heapfy(at index: Int) {
                
                let leftNode = index * 2 + 1
                let rightNode = index * 2 + 2
                
                var largeIndex = index
                if leftNode < array.count, array[leftNode] > array[index] {
                    largeIndex = leftNode
                }
                
                if rightNode < array.count, array[rightNode] > array[index] {
                    largeIndex = rightNode
                }
                
                if largeIndex != index {
                    array.swapAt(index, largeIndex)
                    let parentNode = (index - 1) / 2
                    heapfy(at: parentNode)
                }
            }
            
            @discardableResult
            mutating
            func poll() -> E? {
                guard let value = array.first else {
                    return nil
                }
                
                array.swapAt(0, array.count - 1)
                
                array.removeLast()
                
                let lastNode = (array.count - 1 - 1) / 2
                heapfy(at: lastNode)
                
                return value
            }
            
            func peek() -> E? {
                return array.last
            }
        }
        
        static func findMinValues(in array: [Int], length: Int) -> [Int] {
            var priorityQueue = PriorityQueue<Int>(size: length)
            
            for value in array {
                if priorityQueue.array.count == length, let last = priorityQueue.peek(), last > value {
                    priorityQueue.poll()
                    priorityQueue.add(element: value)
                } else if priorityQueue.array.count < length {
                    priorityQueue.add(element: value)
                }
            }
            
            return priorityQueue.array
        }
    }
    
    /// 若没有重复元素
    struct Solution3 {
        static func findMinValues(in array: [Int], length: Int) -> [Int]? {
            guard length > 0, array.count >= length else {
                return nil
            }
            
            var array = array
            let throld = getRank(in: &array, left: 0, right: array.count - 1, rank: length - 1)
            
            return array.filter { $0 <= throld}
        }
        
        private static func getRank(in array: inout [Int], left: Int, right: Int, rank:Int) -> Int {
            
            let pivotIndex = (left + right) / 2
            
            let leftEnd = partial(in: &array, left: left, right: right, pivot: array[pivotIndex])
            
            let leftSize = leftEnd - left + 1
            
            var value: Int
            if rank == leftSize - 1 {
                // ⚠️获取最大值
                value = array[left...leftEnd].max()!
            } else if rank < leftSize {
                /// 左边继续缩减
                value = getRank(in: &array, left: left, right: leftEnd, rank: rank)
            } else {
                /// 右边查找
                value = getRank(in: &array, left: leftEnd + 1, right: right, rank: rank - leftSize)
            }
            
            return value
        }
        
        private static func partial(in array: inout [Int], left: Int, right: Int, pivot: Int) -> Int {
            var left = left
            var right = right
            
            while left < right {
                if array[left] > pivot {
                    array.swapAt(left, right)
                    right -= 1
                } else if array[right] < pivot {
                    array.swapAt(left, right)
                    left += 1
                } else {
                    left += 1
                    right -= 1
                }
            }
            
            return left
        }
        
    }
    
    struct Solution4 {
        
        typealias SizeResult = (leftSize: Int, middleSize: Int)
        
        static func findMinValues(in array: [Int], length: Int) -> [Int]? {
            guard length > 0, array.count >= length else {
                return nil
            }
            var array = array
            
            let value = getRank(in: &array, start: 0, end: array.count - 1, length: length)
            
            var result: [Int] = array.filter { $0 < value }
            
            if result.count < length {
                let counts = Array<Int>(repeating: value, count: length - result.count)
                result.append(contentsOf: counts)
            }
            
            return result
        }
        
        private static func getRank(in array: inout [Int], start: Int, end: Int, length: Int) -> Int {
            
            let pivotIndex = (start + end) / 2
            let pivot = array[pivotIndex]
            
            let sizeResult = partial(in: &array, start: start, end: end, pivot: pivot)
            
            var value = 0
            if length < sizeResult.leftSize {
                /// 左边寻找
                value = getRank(in: &array, start: start, end: start + sizeResult.leftSize - 1, length: length)
            } else if length < sizeResult.leftSize + sizeResult.middleSize {
                value = pivot
            } else {
                // 往右边寻找
                let remain = length - sizeResult.leftSize - sizeResult.middleSize
                value = getRank(in: &array, start: start + sizeResult.leftSize + sizeResult.middleSize, end: end, length: remain)
            }
            
            return value
            
        }
        
        // 这里返回小于privot的是ç
        private static func partial(in array: inout [Int], start: Int, end: Int, pivot: Int) -> SizeResult {
            var left = start
            var middle = start
            var right = end
            
            while middle < right {
                if array[middle] < pivot {
                    /*
                     这里可以这样思考;
                     1. array[left] = pivot
                     2. array[left] < pivot
                     
                     left会最终指向 pivot
                     */
                    
                    array.swapAt(left, middle)
                    
                    middle += 1
                    left += 1
                } else if array[middle] > pivot {
                    array.swapAt(right, middle)
                    right -= 1
                } else {
                    middle += 1
                }
            }
            
            /*
             ⚠️
             这里leftsize
             */
            return (left - start, right - left + 1)
        }
        
    }
    
    
    static func test() {
        
        let array = [2, 3, 9, 5, 4, 1, 10, 12]
        print(Solution2.findMinValues(in: array, length: 3))
        print(Solution3.findMinValues(in: array, length: 3))
        
        let array1 = [2, 3, 9, 5, 4, 1, 10, 12, 2]
        print(Solution4.findMinValues(in: array1, length: 3))
        
        print("\(self) OVER")
    }
}
