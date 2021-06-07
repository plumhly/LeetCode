//
//  2.2 返回倒数第K个节点.swift
//  算法
//
//  Created by Plum on 2020/8/10.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 2.2 返回倒数第K个节点
 
 实现一种算法，找出单项链表中倒数第k个节点。
 */

struct InterView_2_2 {
    
    // 双指针
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    struct Solution1 {
        static func find(last k: Int, in node: Node) -> Int? {
            guard k > 0 else {
                return nil
            }
            var frontNode: Node? = node
            for _ in 0..<k where frontNode != nil {
                frontNode = frontNode?.next
            }
            guard frontNode != nil else {
                return nil
            }
            
            var backNode: Node? = node
            while frontNode != nil {
                frontNode = frontNode?.next
                backNode = backNode?.next
            }
            
            return backNode?.value
        }
    }
    
    // 递归
    // 时间复杂度 O(n)
    // 空间复杂度 O(n)
    struct Solution2 {
        static func find(last k: Int, in node: Node) {
            find(k: k, in: node)
        }
        
        @discardableResult
        static func find(k: Int, in node: Node?) -> Int {
            guard node != nil else {
                return 0
            }
            let index = find(k: k, in: node?.next) + 1
            
            if index == k {
                print(node?.value)
            }
            return index
        }
    }
    
    // 递归
    // 时间复杂度 O(n)
    // 空间复杂度 O(n)
    struct Solution3 {
        static func find(last k: Int, in node: Node) -> Int? {
            var index = 0
            return find(k: k, in: node, index: &index)?.value
        }
        
        static func find(k: Int, in node: Node?, index: inout Int) -> Node? {
            guard node != nil else {
                return nil
            }
            let resultNode = find(k: k, in: node?.next, index: &index)
            index += 1
            
            if index == k {
                return node
            }
            return resultNode
        }
    }
    
    static func test() {
        do {
            let node1 = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 4, next: nil))))
            assert(Solution1.find(last: 0, in: node1) == nil)
            assert(Solution1.find(last: 10, in: node1) == nil)
            assert(Solution1.find(last: 1, in: node1) == 4)
            assert(Solution1.find(last: 3, in: node1) == 2)
            print("InterView_2_2 Solution1 OVER")
        }
        
        do {
            let node1 = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 4, next: nil))))
            Solution2.find(last: 1, in: node1)
            Solution2.find(last: 3, in: node1)
        }
        
        do {
            let node1 = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 4, next: nil))))
            assert(Solution3.find(last: 0, in: node1) == nil)
            assert(Solution3.find(last: 10, in: node1) == nil)
            assert(Solution3.find(last: 1, in: node1) == 4)
            assert(Solution3.find(last: 3, in: node1) == 2)
            print("InterView_2_2 Solution3 OVER")
        }
    }
}
