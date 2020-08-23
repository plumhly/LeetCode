//
//  2.8 环路检查.swift
//  算法
//
//  Created by Plum on 2020/8/23.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 环路检查
 
 给定一个有环链表，实现一个算法返回环路的开头节点。
 */

struct Interview_2_8 {
    // 用散列表
    // 时间复杂度 O(n)
    // 空间复杂度 O(n)
    struct Solution1 {
        static func isSycle(node: Node) -> Node? {
            var set: Set<Node> = []
            var node: Node? = node
            while let tempNode = node {
                if set.contains(tempNode) {
                    break
                }
                set.insert(tempNode)
                node = tempNode.next
            }
            return node
        }
    }
    
    // 快慢指针
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    struct Solution2 {
        static func isSycle(node: Node) -> Node? {
            var fast: Node? = node
            var slow: Node? = node
            
            // 判断是否有环
            while fast != nil, fast?.next != nil {
                fast = fast?.next?.next
                slow = slow?.next
                if fast == slow {
                    break
                }
            }
            
            // 当fast.next == nil，没有判断
            if fast == nil || fast?.next == nil {
                return nil
            }
            
            // 有环
            // 确定环的大小
            var cycleCount = 1
            fast = fast?.next
            while fast != slow {
                fast = fast?.next
                cycleCount += 1
            }
            
            // 重新运用快慢指针
            slow = node
            
            // 优化，这里不用重新移动fast,因为当前的fast的位置就是想移动到的位置
//            fast = node
//            for _ in 0..<cycleCount {
//                fast = fast?.next
//            }
            
            while fast != slow {
                fast = fast?.next
                slow = slow?.next
            }
            
            return fast
        }
    }
    
    static func test() {
        do {
            let node1 = Node(value: 1, next: nil)
            let node2 = Node(value: 2, next: nil)
            let node3 = Node(value: 3, next: nil)
            let node4 = Node(value: 4, next: nil)
            node1.next = node2
            node2.next = node3
            node3.next = node4
            node4.next = node2
            
            let node5 = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: nil)))
            assert(Solution1.isSycle(node: node1) == node2)
            assert(Solution1.isSycle(node: node5) == nil)
            print("Interview_2_8 Solution1 OVER")
        }
        
        
        do {
            let node1 = Node(value: 1, next: nil)
            let node2 = Node(value: 2, next: nil)
            let node3 = Node(value: 3, next: nil)
            let node4 = Node(value: 4, next: nil)
            node1.next = node2
            node2.next = node3
            node3.next = node4
            node4.next = node2
            
            let node5 = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: nil)))
            assert(Solution2.isSycle(node: node1) == node2)
            assert(Solution2.isSycle(node: node5) == nil)
            
            let node6 = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 4, next: nil))))
            assert(Solution2.isSycle(node: node6) == nil)
            print("Interview_2_8 Solution2 OVER")
        }
    }
}
