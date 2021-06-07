//
//  2.5 链表求和.swift
//  算法
//
//  Created by Plum on 2020/8/13.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 2.5 链表求和
 
 给定用两个链表表示的整数，每一个节点包含一个位数。这些位数是反向存放的，也就是各位排在链表的首部，编写一个算法求两个整数的和，并用链表的形式返回结果。
 
 实例：
    输入： 7->1->6 + 5->9->2 即617 + 295
    输出：2->1->9 即912
 
 进阶：假设位数是正向存储的，再做一遍
 
 实例：
 输入： 1->6 + 9->2 即16 + 92
 输出：1->0->8 即108
 */

struct Interview_2_5 {
    
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    struct Solution1 {
        static func add(node1: Node, node2: Node) -> Node {
            var longNode: Node?
            var smallNode: Node?
            if node1.count > node2.count {
                longNode = node1
                smallNode = node2
            } else {
                longNode = node2
                smallNode = node1
            }
            let resultNode = longNode!
            var longNodePre = longNode
            var carry = 0
            while let tempLongNode = longNode {
                var sum = tempLongNode.value + carry
                if let tempSmallNode = smallNode {
                    sum += tempSmallNode.value
                    smallNode = tempSmallNode.next
                }
                carry = sum / 10
                tempLongNode.value = sum % 10
                longNodePre = tempLongNode
                longNode = tempLongNode.next
            }
            
            // 最高位还要进位
            if carry > 0 {
               longNodePre?.next = Node(value: carry, next: nil)
            }
            return resultNode
        }
    }
    
    // 递归
    // 时间复杂度 O(n)
    // 空间复杂度 O(n)
    struct Advance {
        static func add(node1: Node, node2: Node) -> Node {
            var longNode: Node?
            var smallNode: Node?
            if node1.count > node2.count {
                longNode = node1
                smallNode = node2
            } else {
                longNode = node2
                smallNode = node1
            }
            let carry = addChild(longNode: longNode, smallNode: smallNode)
            if carry > 0 {
                longNode = Node(value: carry, next: longNode)
            }
            return longNode!
        }
        
        static func addChild(longNode: Node?, smallNode: Node?) -> Int {
            guard longNode != nil || smallNode != nil else {
                return 0
            }
            var sum = addChild(longNode: longNode?.next, smallNode: smallNode?.next)
            if let longNodeValue = longNode?.value {
                sum += longNodeValue
            }
            if let smallNodeValue = smallNode?.value {
                sum += smallNodeValue
            }
            longNode?.value = sum % 10
            return sum / 10
        }
    }
    
    // 可以考虑转换成整数
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    struct OpenMind {
        static func add(node1: Node, node2: Node) -> Int {
            let value1 = number(of: node1)
            let value2 = number(of: node2)
            return value1 + value2
        }
        
        static func number(of: Node?) -> Int {
            var value = 0
            if let number = of?.value {
                value  =  number + 10 * self.number(of: of?.next)
            }
            return value
        }
    }
    
    static func test() {
        do {
            
            let node1 = Node(value: 1, next: nil)
            let node2 = Node(value: 9, next: nil)
            assert(Solution1.add(node1: node1, node2: node2).values == [0, 1])
            
            let node3 = Node(value: 7, next: Node(value: 1, next: Node(value: 6, next: nil)))
            let node4 = Node(value: 5, next: Node(value: 9, next: Node(value: 2, next: nil)))
            assert(Solution1.add(node1: node3, node2: node4).values == [2, 1, 9])
            
            let node5 = Node(value: 7, next: Node(value: 6, next: Node(value: 1, next: nil)))
            let node6 = Node(value: 5, next: nil)
            assert(Solution1.add(node1: node5, node2: node6).values == [2, 7, 1])
            
            print("Interview_2_5 Solution1 OVER")
        }
        
        do {
            
            let node1 = Node(value: 1, next: nil)
            let node2 = Node(value: 9, next: nil)
            assert(Advance.add(node1: node1, node2: node2).values == [1, 0])
            
            let node3 = Node(value: 7, next: Node(value: 1, next: Node(value: 6, next: nil)))
            let node4 = Node(value: 5, next: Node(value: 9, next: Node(value: 2, next: nil)))
            assert(Advance.add(node1: node3, node2: node4).values == [1, 3, 0, 8])
            
            let node5 = Node(value: 7, next: Node(value: 6, next: Node(value: 1, next: nil)))
            let node6 = Node(value: 5, next: nil)
            assert(Advance.add(node1: node5, node2: node6).values == [1, 2, 6, 1])
            
            print("Interview_2_5 Advance OVER")
        }
        
        do {
            
            let node1 = Node(value: 1, next: nil)
            let node2 = Node(value: 9, next: nil)
            assert(OpenMind.add(node1: node1, node2: node2) == 10)
            
            let node3 = Node(value: 7, next: Node(value: 1, next: Node(value: 6, next: nil)))
            let node4 = Node(value: 5, next: Node(value: 9, next: Node(value: 2, next: nil)))
            assert(OpenMind.add(node1: node3, node2: node4) == 912)
            
            let node5 = Node(value: 7, next: Node(value: 6, next: Node(value: 1, next: nil)))
            let node6 = Node(value: 5, next: nil)
            assert(OpenMind.add(node1: node5, node2: node6) == 172)
            
            print("Interview_2_5 OpenMind OVER")
        }
    }
}
