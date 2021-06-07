//
//  2.7 链表相交.swift
//  算法
//
//  Created by Plum on 2020/8/22.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 2.7 链表相交
 
 给定2个（单项）链表，判断他们是否相交，并返回节点。请注意相交的定义基于节点的引用。
 */

struct Interview_2_7 {
    
    //
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    // 优化建议：通过比较尾节点是否相等，来判断链表是否相交的可能。
    struct Solution1 {
        static func isIntersection(node1: Node, node2: Node) -> Node? {
            let length1 = node1.count
            let length2 = node2.count
            
            var longNode: Node?
            var shortNode: Node?
            let moveStep: Int
            if length1 >= length2 {
                longNode = node1
                shortNode = node2
                moveStep = length1 - length2
            } else {
                longNode = node2
                shortNode = node1
                moveStep = length2 - length1
            }
            
            for _ in 0..<moveStep {
                longNode = longNode?.next
            }
            
            while longNode != nil, shortNode != nil {
                if longNode == shortNode {
                    break
                }
                longNode = longNode?.next
                shortNode = shortNode?.next
            }
            return longNode
        }
    }
    
    static func test() {
        do {
            let node1 = Node(value: 1, next: nil)
            let node2 = Node(value: 1, next: Node(value: 2, next: node1))
            let node3 = Node(value: 1, next: Node(value: 2, next: node1))
            
            let node4 = Node(value: 1, next: Node(value: 2, next: nil))
            let node5 = Node(value: 1, next: Node(value: 2, next: nil))
            
            assert(Solution1.isIntersection(node1: node2, node2: node3) == node1)
            assert(Solution1.isIntersection(node1: node4, node2: node5) == nil)
            print("Interview_2_7 Solution1 OVER")
        }
    }
}
