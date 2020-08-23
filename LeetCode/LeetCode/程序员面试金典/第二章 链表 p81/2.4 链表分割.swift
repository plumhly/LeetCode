//
//  2.4 链表分割.swift
//  算法
//
//  Created by Plum on 2020/8/11.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation
/*
 2.4 链表分割
 
 编写程序以x分割链表，使得小于x的节点排在大于或者等于x的节点之前。
 实例：
 输入: head = 1->4->3->2->5->2, x = 3
 输出: 1->2->2->4->3->5
 */

/*
 ⚠️ 需要返回新的node!!!!
 */
struct Interview_2_4 {
    
    /*
     解决思路：
     1. 需要三个指针，一个是用来遍历，一个用来指向上一个节点，一个用来表示小于该数的node整理后的末尾
     */
    struct Solution1 {
        static func separate(list: Node, separator: Int) -> Node? {
            var smallStart: Node? = nil
            var smallNode: Node? = nil
            var largeNode: Node? = list
            var largeNodePre: Node? = nil
            while largeNode != nil {
                let value = largeNode!.value
                if value < separator {
                    if smallNode == nil {
                        // 不是头结点
                        if largeNode !== list {
                            let largeNext = largeNode?.next
                            
                            // 断除上一个节点的引用
                            largeNodePre?.next = nil
                            
                            // 把该节点当做头结点
                            largeNode?.next = list
                            
                            // 标记小节点
                            smallNode = largeNode
                            
                            //记录头结点
                            smallStart = smallNode
                            
                            // 还原largeNode
                            largeNode = largeNext
                            
                        } else {
                            // 是头结点
                            smallNode = largeNode
                            //记录头结点
                            smallStart = smallNode
                            
                            largeNode = largeNode?.next
                            largeNodePre = largeNode
                        }
                        
                    } else {
                        // 记录下一个节点
                        let largeNext = largeNode?.next
                        // 上级节点
                        largeNodePre?.next = largeNext
                        
                        // 插入到小节点
                        largeNode?.next = smallNode?.next
                        smallNode?.next = largeNode
                        
                        // 移动large节点
                        largeNode = largeNext
                    }
                } else {
                    largeNodePre = largeNode
                    largeNode = largeNode?.next
                }
            }
            
            return smallStart == nil ? list : smallNode
        }
    }
    
    /*
     解法分析：
     1. 用5个指针，1个用来遍历， 1对用来维护小于separator的链表，1对用来维护大于等于separator的链表，然后合并。
     注意点：
     1. 该方法要把遍历变量的 next = nil, 方便重组
     */
    struct Solution2 {
        static func separate(list: Node, separator: Int) -> Node? {
            var node: Node? = list
            var beforeStart: Node? = nil
            var beforeEnd: Node? = nil
            var afterStart: Node? = nil
            var afterEnd: Node? = nil
            
            while node != nil {
                let next = node?.next
                // 变成单独的node
                node?.next = nil
                if node!.value < separator {
                    if beforeStart == nil {
                        beforeStart = node
                    } else {
                        beforeEnd?.next = node
                    }
                    beforeEnd = node
                } else {
                    if afterStart == nil {
                        afterStart = node
                    } else {
                        afterEnd?.next = node
                        
                    }
                    afterEnd = node
                }
                
                node = next
            }
            
            if beforeStart == nil {
               return afterStart
            }
            
            beforeEnd?.next = afterStart
            return beforeStart
        }
    }
    
    
    /*
     解法分析：
     1. 三个指针，1个用于遍历。一个用于记录小于数组成链表，插入的方法：之前发现的同组数组成的链表，作为新发现的next (头插法)， 大于也是一样
     
     注意点：
     1. smallStart遍历要用一个新的index， smallStart链表会被不断赋值，而smallStart没有其他变量持有
     2. 这里必须要返回新的node
     */
    struct Solution3 {
        static func separate(list: Node, separator: Int) -> Node? {
            var node: Node? = list
            
            var smallStart: Node? = nil
            var largeStart: Node? = nil
            while node != nil {
                let next = node?.next
                if node!.value < separator {
                    node?.next = smallStart
                    smallStart = node
                } else {
                    node?.next = largeStart
                    largeStart = node
                }
                node = next
            }
            
            guard smallStart != nil else {
                return largeStart
            }
            
            guard largeStart != nil else {
                return smallStart
            }
            
            // 这里不能移动smallStart，原因是移动之后，之前的node就会被释放，需要一个新的索引
            var index = smallStart
            while let next = index?.next {
                index = next
            }
            
            index?.next = largeStart
            return smallStart
        }
    }
    
    
    /**
     🏆
     解法分析：
     用3个指针，1个遍历，一个指向head,1个指向tail。一旦发现小于的数，就从头插入，如果大于的数，从尾插入。
     
     注意：
     1. 引用类型指针的操作和赋值。node.next = node, 是把next指针指向自己，构成一个环
     2. 一定要执行 tail.next = nil.， 因为小于的数在移动到头部是，可能它是tail的next
     */
    struct Solution4 {
        static func separate(list: Node, separator: Int) -> Node? {
            var node: Node? = list
            var head: Node? = list
            var tail: Node? = list
            while node != nil {
                let next = node?.next
                if node!.value < separator {
                    node?.next = head
                    head = node
                } else {
                    tail?.next = node
                    tail = node
                }
                node = next
            }
            tail?.next = nil
            return head
        }
    }
    
    static func test() {
        do {
            let node1 = Node(value: 1, next: nil)
            let node2_1 = Node(value: 2, next: nil)
            let node2_2 = Node(value: 2, next: nil)
            let node3 = Node(value: 3, next: nil)
            let node4 = Node(value: 4, next: nil)
            let node5 = Node(value: 5, next: nil)
            
            node1.next = node4
            node4.next = node3
            node3.next = node2_1
            node2_1.next = node5
            node5.next = node2_2
            let node = Solution1.separate(list: node1, separator: 3)
            assert(node?.values == [1, 2, 2, 4, 3, 5])
            print("Interview_2_4 Solution1 OVER")
        }
        
        do {
            let node1 = Node(value: 1, next: nil)
            let node2_1 = Node(value: 2, next: nil)
            let node2_2 = Node(value: 2, next: nil)
            let node3 = Node(value: 3, next: nil)
            let node4 = Node(value: 4, next: nil)
            let node5 = Node(value: 5, next: nil)
            
            node1.next = node4
            node4.next = node3
            node3.next = node2_1
            node2_1.next = node5
            node5.next = node2_2
            let node = Solution2.separate(list: node1, separator: 3)
            assert(node?.values == [1, 2, 2, 4, 3, 5])
            print("Interview_2_4 Solution2 OVER")
        }
        
        do {
            let node1 = Node(value: 1, next: nil)
            let node2_1 = Node(value: 2, next: nil)
            let node2_2 = Node(value: 2, next: nil)
            let node3 = Node(value: 3, next: nil)
            let node4 = Node(value: 4, next: nil)
            let node5 = Node(value: 5, next: nil)
            
            node1.next = node4
            node4.next = node3
            node3.next = node2_1
            node2_1.next = node5
            node5.next = node2_2
            let node = Solution3.separate(list: node1, separator: 3)
            assert(node?.values == [2, 2, 1, 5, 3, 4])
            print("Interview_2_4 Solution3 OVER")
        }
        
        do {
            let node1 = Node(value: 1, next: nil)
            let node2_1 = Node(value: 2, next: nil)
            let node2_2 = Node(value: 2, next: nil)
            let node3 = Node(value: 3, next: nil)
            let node4 = Node(value: 4, next: nil)
            let node5 = Node(value: 5, next: nil)
            
            node1.next = node4
            node4.next = node3
            node3.next = node2_1
            node2_1.next = node5
            node5.next = node2_2
            let node = Solution4.separate(list: node1, separator: 3)
            assert(node?.values == [2, 2, 1, 5, 3, 4])
            print("Interview_2_4 Solution4 OVER")
        }
        
    }
}
