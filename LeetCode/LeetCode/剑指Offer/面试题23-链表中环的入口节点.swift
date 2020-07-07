//
//  面试题23-链表中环的入口节点.swift
//  LeetCode
//
//  Created by Plum on 2020/6/15.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题23:链表中环的入口节点
 
 P139
 
 解决这个问题的第一步是如何确定一个链表中包含环。受到面试题22 的启发,我们可以用两个指针来解决这个问题。和前面的问题一样,定义两个指针,同时从链表的头节点出发,一个指针一次走一步,另一个指针次走两步。如果走得快的指针追上了走得慢的指针,那么链表就包含环如果走得快的指针走到了链表的末尾( m pnext指向NUL)都没有追上第个指针,那么链表就不包含环。
 第二步是如何找到环的入口。我们还是可以用两个指针来解决这个问题。先定义两个指针P1和P2指向链表的头节点。如果链表中的环有n个节点,则指针P1先在链表上向前移动n步,然后两个指针以相同的速度向前移动。当第二个指针指向环的入口节点时,第一个指针已经围绕着环走了圈,又回到了入口节点
 
 */

struct Topic23 {
    
    static func findLoopEntry(node: Node?) -> Int? {
        guard node != nil else {
            return nil
        }
        
        guard let nodeInLoop = findNodeInLoop(node: node) else {
            return nil
        }
        
        // find number
        var numberOfElementInNode = 1
        var tempNode = nodeInLoop.next
        while tempNode !== nodeInLoop {
            numberOfElementInNode += 1
            tempNode = tempNode?.next
        }
        
        // find entry
        var fastNode = node
        
        // 移动n步
        for _ in 0..<numberOfElementInNode {
            fastNode = fastNode?.next
        }
        
        var slowNode = node
        while fastNode !== slowNode  {
            fastNode = fastNode?.next
            slowNode = slowNode?.next
        }
        return slowNode?.value
    }
    
    static func findNodeInLoop(node: Node?) -> Node? {
        var slowNode = node
        var fastNode = node?.next
        
        while fastNode != nil, slowNode != nil {
            if fastNode === slowNode {
                return fastNode
            }
            slowNode = slowNode?.next
            fastNode = fastNode?.next?.next
        }
        return nil
    }
    
    
    static func test() {
        let node4 = Node(value: 4, next: nil)
        let node2 = Node(value: 2, next: Node(value: 3, next: node4))
        node4.next = node2
        let node = Node(value: 1, next: node4)
        
        assert(findLoopEntry(node: nil) == nil)
        assert(findLoopEntry(node: Node(value: 1, next: Node(value: 2, next: nil))) == nil)
        assert(findLoopEntry(node: node) == 4)
        print("Topic23 OVER")
    }
}
