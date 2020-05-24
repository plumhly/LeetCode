//
//  Sort.swift
//  LeetCode
//
//  Created by Plum on 2020/5/23.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

func heapify(numbers: inout [Int], node: Int, lastIndex: Int) {
    
    let leftNode = 2 * node + 1
    let rightNode = 2 * node + 2
    var largeNode = node // large
    
    if leftNode < lastIndex, numbers[leftNode] > numbers[largeNode] {
        largeNode = leftNode
    }
    
    if rightNode < lastIndex, numbers[rightNode] > numbers[largeNode]  {
        largeNode = rightNode
    }
    
    // swap
    print(largeNode)
    if node != largeNode {
        let temp = numbers[node]
        numbers[node] = numbers[largeNode]
        numbers[largeNode] = temp
        
        heapify(numbers: &numbers, node: largeNode, lastIndex: lastIndex)
    }
}

// 迭代
func heapifyIterate(numbers: inout [Int], node: Int, lastIndex: Int) {
    var large = node
    for i in sequence(first: large, next: { value in
        guard value != large, 2 * large + 1 < lastIndex else { return nil }
        return large
    }) {
        let left = 2 * i + 1
        let right = 2 * i + 2
        large = i
        if left < lastIndex, numbers[i] < numbers[left] {
            large = left
        }
        
        if right < lastIndex, numbers[large] < numbers[right] {
            large = right
        }
        
        // swap
        if large != i {
            let temp = numbers[i]
            numbers[i] = numbers[large]
            numbers[large] = temp
        }
    }
}


func buildMaxHeap(numbers: inout [Int]) {
    let lastParentNode = (numbers.count - 1 - 1) / 2
    
    // 递归
    for i in stride(from: lastParentNode , through: 0, by: -1) {
        heapify(numbers: &numbers, node: i, lastIndex: numbers.count)
    }
    
    // 迭代
//    for i in stride(from: lastParentNode , through: 0, by: -1) {
//        heapifyIterate(numbers: &numbers, node: i, lastIndex: numbers.count)
//    }
}

func heapifySort(numbers: inout [Int]) {
    buildMaxHeap(numbers: &numbers)
    
    // 把堆顶和末尾元素交换，并减少index
    for i in stride(from: numbers.count - 1, through: 0, by: -1) {
        let temp = numbers[0]
        numbers[0] = numbers[i]
        numbers[i] = temp
        heapify(numbers: &numbers, node: 0, lastIndex: i)
//        heapifyIterate(numbers: &numbers, node: 0, lastIndex: i)
    }
}



