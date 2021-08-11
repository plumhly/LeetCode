//
//  面试题24-反转链表.swift
//  LeetCode
//
//  Created by Plum on 2020/6/15.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题24:反转链表
 题目:定义一个函数,输入一个链表的头节点,反转该链表并输出反转后链表的头节点。链表节点定义如下:
 
 P142
 
 记到：
 node的顺序，也就是node.next = newNode, newNode = node
 */

struct Topic24 {
    static func inverse(node: Node?) -> Node? {
        guard node != nil else {
            return nil
        }
        
        var node = node
        var preNode: Node? = nil
        
        while node != nil {
            let tempNode = node?.next
            
            // 这里是重点
            node?.next = preNode
            preNode = node
            
            node = tempNode
        }
        return preNode
    }
    
    static func test() {
        
        assert(inverse(node: nil) == nil)
        
        let node1 = Node(value: 1, next: nil)
        let result1 = inverse(node: node1)
        assert(result1?.values == [1])
        
        let node2 = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 4, next: nil))))
        let result2 = inverse(node: node2)
        assert(result2?.values == [4, 3, 2, 1])
        
        print("Topic24 OVER")
    }
}
