//
//  面试题22-链表中倒数第k个节点.swift
//  LeetCode
//
//  Created by Plum on 2020/6/14.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题22:链表中倒数第k个节点
 题目:输入一个链表,输出该链表中倒数第k个节点。为了符合大多数人的习惯,本题从1开始计数,即链表的尾节点是倒数第1个节点。例如,一个链表有6个节点,从头节点开始,它们的值依次是12、3、4、5、这个链表的倒数第3个节点是值为4的节点。链表节点定义如下
 
 P135
 
 为了实现只遍历链表一次就能找到倒数第k个节点,我们可以定义两个指针。第一个指针从链表的头指针开始遍历向前走k-1步,第二个指针保持不动;从第k步开始,第二个指针也开始从链表的头指针开始遍历。
 由于两个指针的距离保持在k-1,当第一个(走在前面的)指针到达链表的尾节点时,第二个(走在后面的)指针正好指向倒数第k个节点。
 
 */

struct Topic22 {
    static func findLast(number: Int, node: Node?) -> Int? {
        guard number > 0, node != nil else {
            return nil
        }
        
        var firstHead = node
        var secondHead: Node? = nil
        
        for _ in 0...number - 1 {
            guard let next = firstHead?.next else {
                 return nil
            }
            firstHead = next
        }
        secondHead = node
        
        while let next = firstHead?.next  {
            firstHead = next
            secondHead = secondHead?.next
        }
        return secondHead?.value
    }
    
    static func test() {
        
        let node = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 4, next: Node(value: 5, next: Node(value: 6, next: nil))))))
        assert(findLast(number: 0, node: node) == nil)
        assert(findLast(number: 2, node: nil) == nil)
        assert(findLast(number: 7, node: node) == nil)
        assert(findLast(number: 2, node: node) == 4)
        print("Topic22 OVER")
    }
}


// 扩展

/*
 P138
 
 求链表的中间节点。如果链表中的节点总数为奇数,则返回中间节点如果节点总数是偶数,则返回中间两个节点的任意一个。为了解决这个题,我们也可以定义两个指针,同时从链表的头节点出发,一个指针一走一步,另一个指针一次走两步。当走得快的指针走到链表的末尾时, 得慢的指针正好在链表的中间。
 */
extension Topic22 {
    static func findMid(node: Node?) -> Int? {
        guard node != nil else { return nil }
        
        var fastNode = node
        var slowNode = node
        // 排除一个节点和两个节点的node
        var number = 0
        while fastNode != nil {
            fastNode = fastNode?.next?.next
            slowNode = slowNode?.next
            number += 1
        }
        if number == 1 {
            return nil
        }
        return slowNode?.value
    }
    
    static func test2() {
        let node2 = Node(value: 6, next: nil)
        let node = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 4, next: Node(value: 5, next: node2)))))
        
        assert(findMid(node: nil) == nil)
        assert(findMid(node: node2) == nil)
        assert(findMid(node: node) == 4)
        
        print("Topic22 extension")
    }
}
