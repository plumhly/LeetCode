//
//  面试题6 从头到尾打印链表.swift
//  LeetCode
//
//  Created by Plum on 2020/5/28.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

struct Topic6 {
    class Node {
        let value: Int
        var next: Node?
        
        init(value: Int, next: Node? = nil) {
            self.value = value
            self.next = next
        }
    }
    
    static func printNode(node: Node?) {
        if let nextNode = node?.next {
            printNode(node: nextNode)
        }
        if let node = node {
            print(node.value)
        }
    }
    
    static func test() {
        let node = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 4, next: nil))))
        printNode(node: node)
    }
    
}








