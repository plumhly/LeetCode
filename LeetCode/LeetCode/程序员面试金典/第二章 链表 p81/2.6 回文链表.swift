//
//  2.6 回文链表.swift
//  算法
//
//  Created by Plum on 2020/8/18.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 回文链表
 
 编写一个函数，检查链表是否为回文。
 */

struct Interview_2_6 {
    
    // 转换成整数
    // 时间复杂度 O(n)
    // 空间复杂度 O(1)
    struct Solution1 {
        static func isCycleNode(_ node: Node) -> Bool {
            let value = number(of: node)
            let reverseValue = reverse(value: value)
            return value == reverseValue
        }
        
        static func number(of: Node?) -> Int {
            var value = 0
            if let number = of?.value {
                value  =  number + 10 * self.number(of: of?.next)
            }
            return value
        }
        
        static func reverse(value: Int) -> Int {
            var value = value
            var reverseValue = 0
            while value != 0 {
                reverseValue = reverseValue * 10 + value % 10
                value /= 10
            }
            return reverseValue
        }
    }
    
    // 头插法
    // 时间复杂度 O(n)
    // 空间复杂度 O(n)
    struct Solution2 {
        static func isCycleNode(_ node: Node) -> Bool {
            // 头插法,必须要分配空间，因为node是引用类型，如果不开创空间，那么原来的链表就会改变, 可以创建新的元素数组或者链表
            var varryNode: Node? = node
            var newNode: Node = Node(value: node.value, next: nil)
            while let next = varryNode?.next {
                newNode = Node(value: next.value, next: newNode)
                varryNode = next
            }
            
            // 遍历对比
            var node: Node? = node
            var isCycleList = true
            
            while let tempNode = node, let tempVarryNode = varryNode {
                if tempNode.value != tempVarryNode.value {
                    isCycleList = false
                    break
                }
                node = tempNode.next
                varryNode = tempVarryNode.next
            }
            
            return isCycleList
        }
    }
    
    // 时间复杂度 O(n)
    // 空间复杂度 O(n/2)
    struct Solution3 {
        static func isCycleNode(_ node: Node) -> Bool {
            var fast: Node? = node
            var slow: Node? = node
            var stack = Stack<Int>()
            while fast?.next != nil {
                if let value = slow?.value {
                    stack.push(value: value)
                }
                slow = slow?.next
                fast = fast?.next?.next
            }
            
            if fast != nil {
                slow = slow?.next
            }
            
            var isSame = true
            while slow != nil, !stack.isEmpty {
                if slow?.value != stack.pop() {
                    isSame = false
                    break
                }
            }
            return isSame
        }
    }
    
    // 通过递归，把结果存入对象
    // 时间复杂度 O(n)
    // 空间复杂度 O(n)
    struct Solution4 {
        
        struct Result {
            var node: Node?
            var result: Bool
        }
        static func isCycleNode(_ node: Node) -> Bool {
            return isCycleNode(node, length: node.count).result
        }
        
        static func isCycleNode(_ node: Node?, length: Int) -> Result {
            if node == nil || length <= 0 { // 长度为偶数时
                return Result(node: node, result: true)
            } else if length == 1 { // 奇数，跳过中间个
                return Result(node: node?.next, result: true)
            }
            
            var res = isCycleNode(node?.next, length: length - 2)
            if !res.result || res.node == nil {
                return res
            }
            
            res.result = node?.value == res.node?.value
            res.node = res.node?.next // 移动下一个
            return res
        }
    }
    
    static func test() {
        do {
            let node1 = Node(value: 1, next: nil)
            assert(Solution1.isCycleNode(node1))
            
            let node2 = Node(value: 1, next: Node(value: 2, next: Node(value: 1, next: nil)))
            assert(Solution1.isCycleNode(node2))
            
            let node3 = Node(value: 1, next: Node(value: 2, next: Node(value: 2, next: nil)))
            assert(Solution1.isCycleNode(node3) == false)
            
            print("Interview_2_6 Solution1 OVER")
        }
        
        do {
            let node1 = Node(value: 1, next: nil)
            assert(Solution2.isCycleNode(node1))
            
            let node2 = Node(value: 1, next: Node(value: 2, next: Node(value: 1, next: nil)))
            assert(Solution2.isCycleNode(node2))
            
            let node3 = Node(value: 1, next: Node(value: 2, next: Node(value: 2, next: nil)))
            assert(Solution2.isCycleNode(node3) == false)
            
            print("Interview_2_6 Solution2 OVER")
        }
        
        do {
            let node1 = Node(value: 1, next: nil)
            assert(Solution3.isCycleNode(node1))
            
            let node2 = Node(value: 1, next: Node(value: 2, next: Node(value: 1, next: nil)))
            assert(Solution3.isCycleNode(node2))
            
            let node3 = Node(value: 1, next: Node(value: 2, next: Node(value: 2, next: nil)))
            assert(Solution3.isCycleNode(node3) == false)
            
            print("Interview_2_6 Solution3 OVER")
        }
        
        do {
            let node1 = Node(value: 1, next: nil)
            assert(Solution4.isCycleNode(node1))
            
            let node2 = Node(value: 1, next: Node(value: 2, next: Node(value: 1, next: nil)))
            assert(Solution4.isCycleNode(node2))
            
            let node3 = Node(value: 1, next: Node(value: 2, next: Node(value: 2, next: nil)))
            assert(Solution4.isCycleNode(node3) == false)
            
            print("Interview_2_6 Solution4 OVER")
        }
    }
}
