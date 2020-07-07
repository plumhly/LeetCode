//
//  面试题52-两个链表的第一个公共节点.swift
//  LeetCode
//
//  Created by Plum on 2020/7/2.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation



class List<E>: NSObject {
    var value: E
    var next: List<E>?
    init(value: E, next: List<E>?) {
        self.value = value
        self.next = next
    }
    
    var length: Int {
        var length = 0
        var tempSecond: List<E>? = self
        while let temp = tempSecond {
            length += 1
            tempSecond = temp.next
        }
        return length
    }
}

typealias IntList = List<Int>

/*
面试题52:两个链表的第一个公共节点

P253

题目:输入两个链表,找出它付的第一个公共节点。链表节点定义如下:
 
分析：
 1. 暴力法：
 面试的时候碰到这道题,很多应聘者的第一反应就是蛮力法:在第链表上顺序遍历每个节点,每遍历到一个节点,就在第二个链表上顺序遍历每个节点。如果在第二个链表上有一个节点和第一个链表上的节点一样, 则说明两个链表在这个节点上重合,于是就找到了它们的公共节点。如果第一个链表的长度为m,第二个链表的长度为n,那么,显然该方法的时间复杂度是Omn)
 
 2. 借用栈
 解决这个问题:分别把两个链表的节点放入两个栈里,这样两个链表的尾节点就位于两个栈的栈顶,接下来比较两个栈顶的节点是否相同。如果相同, 则把栈顶弹出接着比较下一个栈顶,直到找到最后一个相同的节点。
 在上述思路中,我们需要用两个辅助栈。如果链表的长度分别为m和n, 那么空间复杂度是Om+n)。这种思路的时间复杂度也是Om+m)。和最开始的蛮力法相比,时间效率得到了提高,相当于用空间消耗换取了时间效率。
 
 3. 提前移位法
 之所以需要用到栈,是因为我们想同时遍历到达两个栈的尾节点两个链表的长度不相同时,如果我们从头开始遍历,那么到达尾节点的时间就不一致。其实解决这个问题还有一种更简单的办法:首先遍历两个链表得到它们的长度,就能知道哪个链表比较长,以及长的链表比短的链表多几个节点。在第二次遍历的时候,在较长的链表上先走若干步,接着同时在两个链表上遍历,找到的第一个相同的节点就是它们的第一个公共节点。
*/

struct Topic52 {
    static func findCommonNode(first: IntList, second: IntList) -> IntList? {
        // 先计算长度
        let firstLength = first.length
        let secondLength = second.length
        
        var first: IntList? = first
        var second: IntList? = second
        
        // 移动
        if firstLength > secondLength {
            for _ in 0..<(firstLength - secondLength) {
                first = first?.next
            }
            
        } else if secondLength > firstLength {
            for _ in 0..<(secondLength - firstLength) {
                second = second?.next
            }
        }
        
        let index = min(firstLength, secondLength)
        
        for _ in 0..<index {
            if first === second {
                return first
            }
            first = first?.next
            second = second?.next
        }
        return nil
    }
    
    static func test() {
        let l1 = IntList(value: 1, next: IntList(value: 2, next: IntList(value: 3, next: nil)))
        let l2 = IntList(value: 4, next: IntList(value: 5, next: nil))
        let l3 = IntList(value: 6, next: IntList(value: 7, next: nil))
        
        l1.next = l3
        l2.next = l3
        
        assert(findCommonNode(first: l1, second: l2) == l3)
        
        let l4 = IntList(value: 1, next: IntList(value: 2, next: IntList(value: 3, next: nil)))
        let l5 = IntList(value: 4, next: IntList(value: 5, next: nil))
        assert(findCommonNode(first: l4, second: l5) == nil)
        
        print("Topic52 VOER")
    }
}
