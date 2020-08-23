//
//  面试题18-删除链表的节点.swift
//  LeetCode
//
//  Created by Plum on 2020/6/11.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/**
 面试题18:删除链表的节点
 
 P119
 
 题目一:在O1)时间内除链表背点给定单向链表的头指针和一个节点指针,定义一个函数在O(1)时间内删除该节点。链表节点与函数的定义如下:
 
 1.那是不是一定需要得到被刑除的节点的前一个节点呢?答案是否定的。我们可以很方便地得到要删除的节点的下一个节点。
 如果我们把下个节点的内容复制到需要删除的节点上覆盖原有的内容,再把下一个节点删除,那是不是就相当于把当前需要删除的节点删除了?
 
 2.上述思路还有一个问题:如果要删除的节点位于链表的尾部,那么它就没有下ー个节点,怎么办?我们仍然从链表的头节点开始,顺序遍历得到该节点的前序节点,并完成删除操作。
 最后需要注意的是,如果链表中只有一个节点,而我们又要删除链表的头节点(也是尾节点),那么,此时我们在删除节点之后,还需要把链表的头节点设置为 nullptr
 */

class Node: NSObject {
    var value: Int
    var next: Node?
    init(value: Int, next: Node?) {
        self.value = value
        self.next = next
        super.init()
    }
    
    var values: [Int]? {
        var result: [Int] = [value]
        var this: Node? = next
        while let node = this {
            result.append(node.value)
            this = this?.next
        }
        return result
    }
    
    var count: Int {
        var length = 0
        var node: Node? = self
        while node != nil {
            length += 1
            node = node?.next
        }
        return length
    }
    
}


struct Topic18 {
    
    struct Topic1 {
        @discardableResult
        static func deleteNode(header: inout Node?, current: Node) -> [Int]? {
            if header === current {
                header = nil
            }
            guard header != nil else {
                return nil
            }
            
            // 如果是尾结点
            if current.next == nil {
                // 顺序处理
                var node = header
                while node?.next !== current {
                    node = node?.next
                }
                node?.next = nil
            }
            
            // 正常处理
            if let v = current.next?.value {
                current.value = v
                current.next = current.next?.next
            }
            
            return printNode(node: header!)
        }
    }
    
    struct Topic2 {
        static func deleteDuplication(header: inout Node?) -> [Int]? {
            guard header != nil else {
                return nil
            }
            
            var preNode: Node? = nil
            var node = header
            while node != nil {
                var isDelete = false
                
                let value = node?.value
                let next = node?.next
                
                if next != nil, value == next?.value {
                    isDelete = true
                }

                if isDelete {
                   // 删除,删除之后的所有
                    while node != nil, node?.value == value {
                        // 这里面是要被删除的, 小步快走
                        let tempNode = node?.next
                        /**删除*/
                        node?.next = nil
                        node = tempNode
                    }
                    
                    if preNode == nil {
                        header = node
                    } else {
                        preNode?.next = node
                    }
                    
                } else {
                    // 不用删除
                    preNode = node
                    node = node?.next
                }
            }
            
            if let h = header {
                return Topic18.printNode(node: h)
            } else {
                return nil
            }
        }
    }
    
    
    static func printNode(node: Node) -> [Int] {
        var node: Node? = node
        var result: [Int] = []
        while node != nil {
            if let n = node {
                result.append(n.value)
            }
            node = node?.next
        }
        return result
    }
    
    static func test() {
        var aNode: Node? = Node(value: 0, next: nil)
        Topic1.deleteNode(header: &aNode, current: aNode!)
        
        let bNode1 = Node(value: 3, next: Node(value: 4, next: nil))
        var bNode: Node? = Node(value: 1, next: Node(value: 2, next:bNode1))
        
        assert(Topic1.deleteNode(header: &bNode, current: bNode1) == [1, 2, 4])
        
        
        let cNode1 = Node(value: 4, next: nil)
        var cNode: Node? = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: cNode1)))
        assert(Topic1.deleteNode(header: &cNode, current: cNode1) == [1, 2, 3])
        
        print("Topic18 1 OVER")
        
        var dNode: Node? = nil
        assert(Topic18.Topic2.deleteDuplication(header: &dNode) == nil)
        
        var eNode: Node? = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 3, next: Node(value: 4, next: Node(value: 4, next: nil))))))
        
        assert(Topic18.Topic2.deleteDuplication(header: &eNode) == [1, 2])
        
        var fNode: Node? = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 3, next: Node(value: 3, next: Node(value: 4, next: Node(value: 4, next: Node(value: 5, next: nil))))))))
        
        assert(Topic18.Topic2.deleteDuplication(header: &fNode) == [1, 2, 5])
        
        print("Topic18 2 OVER")
    }
}
