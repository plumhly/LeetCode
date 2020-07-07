//
//  面试题25-合并两个排序的链表.swift
//  LeetCode
//
//  Created by Plum on 2020/6/15.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题25:合并两个排序的链表
 
 P145
 
 题目:输入内个递増排序的链表,合并这两个链表并使新链表中的点仍然是递增排序的。例如,输入图3.11中的链表1和链表2,则合并之后的升序链表如链表3所示。链表节点定义如下:
 
 */

struct Topic25 {
    // 迭代
    static func merge(first: Node?, second: Node?) -> Node? {
        if first == nil {
            return second
        }
        if second == nil {
            return first
        }
        
        var newNode: Node? = nil
        var newNodeHead = newNode
        var first = first
        var second = second
        while let tempFirst = first, let tempSecond = second {
            let tempNode: Node
            if tempFirst.value > tempSecond.value {
                tempNode = tempSecond
                second = second?.next
                
            } else {
                //小于等于
                tempNode = tempFirst
                first = first?.next
            }
            
            // 置空时机
            tempNode.next = nil
            if newNode == nil {
                newNode = tempNode
            } else {
                newNodeHead?.next = tempNode
            }
            // 记到替换
            newNodeHead = tempNode
        }
        
        while let tempFirst = first {
            newNodeHead?.next = tempFirst
            
            // 位置很重要
            first = first?.next
            tempFirst.next = nil
        }
        
        while let tempSecond = second {
            newNodeHead?.next = tempSecond
            second = second?.next
            tempSecond.next = nil
        }
        
        return newNode
    }
    
    // 递归
    static func merge_recursive(first: Node?, second: Node?) -> Node? {
        guard let first = first else {
            return second
        }
        
        guard let second = second else {
            return first
        }
        
        var pHead: Node? = nil
        if first.value < second.value {
            pHead = first
            pHead?.next = merge_recursive(first: first.next, second: second)
        } else {
            pHead = second
            pHead?.next = merge_recursive(first: first, second: second.next)
        }
        return pHead
    }
    
    static func test() {
        let node1 = Node(value: 1, next: Node(value: 3, next: Node(value: 5, next: nil)))
        let node2 = Node(value: 2, next: Node(value: 4, next: Node(value: 6, next: nil)))
        
        assert(merge(first: nil, second: nil) == nil)
        assert(merge(first: node1, second: nil) === node1)
        assert(merge(first: nil, second: node2) === node2)
        let result = merge(first: node1, second: node2)
        assert(result?.values == [1, 2, 3, 4, 5, 6])

        let node3 = Node(value: 1, next: Node(value: 3, next: Node(value: 5, next: nil)))
        let node4 = Node(value: 2, next: Node(value: 4, next: Node(value: 6, next: nil)))
        assert(merge_recursive(first: nil, second: nil) == nil)
        assert(merge_recursive(first: node3, second: nil) === node3)
        assert(merge_recursive(first: nil, second: node4) === node4)
        let result1 = merge_recursive(first: node3, second: node4)
        assert(result1?.values == [1, 2, 3, 4, 5, 6])

        
        print("Topic25 OVER")
    }
}
