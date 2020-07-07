//
//  面试题35-复杂链表的复制.swift
//  LeetCode
//
//  Created by Plum on 2020/6/21.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题35:复杂链表的复制
 
 P187
 
 题目:请实现函数 Complex Listnode* Clone( Complex Listnode* plead), 复制一个复杂链表。在复杂链表中,每个节点除了有一个 m pnext指针指向下一个节点,还有一个 m sibling指针指向链表中的任意节点或者nullptr。节点的C+定义如下:
 
 分析：
 分两步，第一步clone节点，第二步，复制sibling
 
 1. O(n^2)
 2. 如果用一个哈希表来装（N,N'）, 这样找sbling就是O(1), 时间复杂度O(n), 空间复杂度：O(n)
 3.接下来我们再换一种思路,在不用辅助空间的情况下实现On)的时间效率。第三种方法的第一步仍然是根据原始链表的每个节点N创建对应的N。这一次,我们把N'链接在N的后面。图4.11中的链表经过这一步之后的结构如图4.12所示。
 
 */

class ComplexList {
    var value: Int
    var next: ComplexList?
    var sibling: ComplexList?
    
    init(value: Int, next: ComplexList? = nil, sibling: ComplexList? = nil) {
        self.value = value
        self.next = next
        self.sibling = sibling
    }
    
    func printNode() -> [[Int]] {
        var this: ComplexList? = self
        var result: [[Int]] = []
        while let node = this {
            var temp: [Int] = []
            temp.append(node.value)
            if let sibling = node.sibling {
                temp.append(sibling.value)
            }
            result.append(temp)
            this = node.next
        }
        return result
    }
}

struct Topic35 {
    static func clone(list: ComplexList?) -> ComplexList? {
        guard let list = list else {
            return nil
        }
        
        creatNext(list: list)
        copySibling(list: list)
        return divideList(list: list)
    }
    
    static func creatNext(list: ComplexList) {
        var list: ComplexList? = list
        while let node = list {
            let linkList = ComplexList(value: node.value)
            list = node.next
            node.next = linkList
            linkList.next = list
        }
    }
    
    static func copySibling(list: ComplexList) {
        var list: ComplexList? = list
        while let node = list {
            if let sibling = node.sibling {
                node.next?.sibling = sibling.next
            }
            list = list?.next?.next
        }
    }
    
    static func divideList(list: ComplexList) -> ComplexList? {
        var list: ComplexList? = list.next
        let newList: ComplexList? = list
        var pointer: ComplexList? = list
        while let node = list?.next?.next {
            pointer?.next = node
            pointer = node
            list = node
        }
        pointer?.next = nil
        return newList
    }
    
    static func test() {
        let a = ComplexList(value: 1)
        let b = ComplexList(value: 2)
        let c = ComplexList(value: 3)
        let d = ComplexList(value: 4)
        let e = ComplexList(value: 5)
        
        a.next = b
        b.next = c
        b.sibling = d
        c.next = d
        d.next = e
        d.sibling = a
        
        let list = clone(list: a)
        
        assert(list?.printNode() == [[1], [2, 4], [3], [4, 1], [5]])
        
        print("Topic35 OVER")
    }
    
}
