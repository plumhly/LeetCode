//
//  2.3 删除中间节点.swift
//  算法
//
//  Created by Plum on 2020/8/11.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 2.3 删除中间节点
 
 实现一种算法，删除单向链表的中的某一个节点，除（头和尾）节点
 实例：
    输入 1->2->3->4->5->6 3
    输出 1->2->4->5->6
 */

struct Interview_2_3 {
    
    // 偏题了
    /*
    struct Solution1 {
        static func delete(node: Node, in list: Node) {
            guard list !== node else {
                return
            }
            
            var previusNode: Node? = list
            var nextNode = list.next
            while nextNode != nil {
                if nextNode === node {
                    if let next = nextNode?.next {
                        nextNode?.next = nil
                        previusNode?.next = next
                    }
                    break
                }
                
                previusNode = nextNode
                nextNode = nextNode?.next
            }
        }
    }
    
    static func test() {
        let node1 = Node(value: 1, next: nil)
        let node2 = Node(value: 2, next: nil)
        let node3 = Node(value: 3, next: nil)
        let node4 = Node(value: 4, next: nil)
        let node5 = Node(value: 5, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        
        Solution1.delete(node: node1, in: node1)
        assert(node1.values == [1, 2, 3, 4, 5])
        
        Solution1.delete(node: node5, in: node1)
        assert(node1.values == [1, 2, 3, 4, 5])
        
        Solution1.delete(node: node2, in: node1)
        assert(node1.values == [1, 3, 4, 5])
        
        Solution1.delete(node: node2, in: node1)
        assert(node1.values == [1, 3, 4, 5])
        
        print("Interview_2_3 Solution1 OVER")
    }
 */
    
    struct Solution1 {
        static func delete(node: Node) {
            guard node.next != nil else {
                return
            }
            
            node.value = node.next!.value
            let next = node.next?.next
            node.next?.next = nil
            node.next = next
        }
        
    }
    
    static func test() {
        let node1 = Node(value: 1, next: nil)
        let node2 = Node(value: 2, next: nil)
        let node3 = Node(value: 3, next: nil)
        let node4 = Node(value: 4, next: nil)
        let node5 = Node(value: 5, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        
        Solution1.delete(node: node5)
        assert(node1.values == [1, 2, 3, 4, 5])
        
        Solution1.delete(node: node2)
        assert(node1.values == [1, 3, 4, 5])
        
        print("Interview_2_3 Solution1 OVER")
    }
}
