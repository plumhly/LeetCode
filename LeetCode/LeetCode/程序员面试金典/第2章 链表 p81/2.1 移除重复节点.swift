//
//  2.1 移除重复节点.swift
//  算法
//
//  Created by Plum on 2020/8/9.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 2.1 移除重复节点
 
 编写代码，移除链表中的重复节点
 进阶: 如果不使用临时缓冲区，该怎么解决
 */

struct Interview_2_1 {
    
    // 暴力法 左 -> 右
    // 时间复杂度 O(n^2)
    // 空间复杂度 O(1)
    struct Solution1 {
        static func removeDuplicateElement(in node: Node) {
            var selectedNode: Node? = node
            var node: Node? = nil
            while selectedNode != nil {
                let element = selectedNode!.value
                node = selectedNode
                while node != nil {
                    if element == node!.next?.value {
                        let next = node?.next?.next
                        node?.next?.next = nil
                        node?.next = next
                    } else {
                        node = node?.next
                    }
                }
                
                // node 遍历完
                selectedNode = selectedNode?.next
            }
        }
    }
    
    //
    // 时间复杂度 O(n)
    // 空间复杂度 O(n)
    struct Solution2 {
        static func removeDuplicateElement(in node: Node) {
            var set: Set<Int> = []
            set.insert(node.value)
            var node: Node? = node
            while let nextNode = node?.next {
                if set.contains(nextNode.value) {
                    let next = nextNode.next
                    nextNode.next = nil
                    node?.next = next
                } else {
                    set.insert(nextNode.value)
                    node = node?.next
                }
            }
        }
    }
    
    // 暴力法 右 -> 左
    // 时间复杂度 O(n^2)
    // 空间复杂度 O(1)
    struct Solution3 {
        static func removeDuplicateElement(in node: Node) {
            var previousNode: Node? = node
            var current: Node? = node.next
            while current != nil {
                var runner: Node? = node
                let currentValue = current!.value
                while runner !== current {
                    if runner?.value == currentValue {
                        let temp = current?.next
                        current?.next = nil
                        previousNode?.next = temp
                        current = temp
                        break
                    }
                    runner = runner?.next
                }
                
                // node 遍历完
                if runner === current {
                    previousNode = current
                    current = current?.next
                }
            }
        }
    }
    
    static func test() {
        
        do {
            let node1 = Node(value: 1, next: Node(value: 2, next: Node(value: 1, next: Node(value: 2, next: nil))))
            let node2 = Node(value: 1, next: Node(value: 2, next: nil))
            
            Solution1.removeDuplicateElement(in: node1)
            Solution1.removeDuplicateElement(in: node2)
            
            assert(node1.values == [1, 2])
            assert(node2.values == [1, 2])
            
            print("Interview_2_1 Solution1 OVER")
        }
        
        
        do {
            let node1 = Node(value: 1, next: Node(value: 2, next: Node(value: 1, next: Node(value: 2, next: nil))))
            let node2 = Node(value: 1, next: Node(value: 2, next: nil))
            
            Solution2.removeDuplicateElement(in: node1)
            Solution2.removeDuplicateElement(in: node2)
            
            assert(node1.values == [1, 2])
            assert(node2.values == [1, 2])
            
            print("Interview_2_1 Solution2 OVER")
        }
        
        do {
            let node1 = Node(value: 1, next: Node(value: 2, next: Node(value: 1, next: Node(value: 2, next: nil))))
            let node2 = Node(value: 1, next: Node(value: 2, next: nil))
            
            Solution3.removeDuplicateElement(in: node1)
            Solution3.removeDuplicateElement(in: node2)
            
            assert(node1.values == [1, 2])
            assert(node2.values == [1, 2])
            
            print("Interview_2_1 Solution3 OVER")
        }
        
    }
}
