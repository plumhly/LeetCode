//
//  🌲的遍历.swift
//  LeetCode
//
//  Created by Plum on 2020/5/29.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation


class Tree: NSObject {
    let value: Int
    var left: Tree?
    var right: Tree?
    unowned var parent: Tree?
    
    init(value: Int, parent: Tree? = nil, left: Tree? = nil, right: Tree? = nil) {
        self.value = value
        self.parent = parent
        self.left = left
        self.right = right
    }
}

extension Tree: Comparable {
    static func < (lhs: Tree, rhs: Tree) -> Bool {
        return true
    }
}

func traversalTree() -> Tree {
    let root = Tree(value: 10)
    let left = Tree(value: 6, left: Tree(value: 4), right: Tree(value: 8))
    let right = Tree(value: 14, left: Tree(value: 12), right: Tree(value: 16))
    root.left = left
    root.right = right
    return root
}

func nextTree() -> Tree {
    let a = Tree(value: 1)
    
    let b = Tree(value: 2)
    let c = Tree(value: 3)
    let d = Tree(value: 4)
    let e = Tree(value: 5)
    let f = Tree(value: 6)
    let g = Tree(value: 7)
    let h = Tree(value: 8)
    let i = Tree(value: 9)
    
    i.parent = e
    h.parent = e
    e.left = h
    e.right = i
    
    e.parent = b
    d.parent = b
    b.left = d
    b.right = e
    
    f.parent = c
    g.parent = c
    c.left = f
    c.right = g
    
    b.parent = a
    c.parent = a
    
    a.left = b
    a.right = c
    
    return a
}


struct Stack<Element> {
    
    private var array: [Element]
    var size: Int {
        return array.count
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    init() {
        array = []
    }
    
    mutating func push(value: Element) {
        array.append(value)
    }
    
    mutating func pop() -> Element? {
        return array.isEmpty ? nil : array.removeLast()
    }
    
    func peek() -> Element? {
        return array.last
    }
}

struct MyQueue<Element: Comparable> {
    
    private(set) var array: [Element]
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var peek: Element? {
        return array.first
    }
    
    var size: Int {
        return array.count
    }
    init() {
        array = []
    }
    
    mutating func dequeue() -> Element? {
        array.isEmpty ? nil : array.removeFirst()
    }
    
    mutating func enqueue(element: Element) {
       return array.append(element)
    }
    
    mutating func remove(element: Element) {
        array.removeAll { $0 == element}
    }
}

// 前序遍历
extension Tree {
    func preorder_recursive() -> [Int] {
        var result: [Int] = []
        result.append(self.value)
        //left
        if let left = left {
            let leftResult = left.preorder_recursive()
            result.append(contentsOf: leftResult)
        }
        
        //right
        if let right = right {
            let rightResult = right.preorder_recursive()
            result.append(contentsOf: rightResult)
        }
        
        return result
    }
    
    static func preorderTest() {
        let tree = traversalTree()
        let result1 = tree.preorder_recursive()
        assert(result1 == [10, 6, 4, 8, 14, 12, 16])
        
        let result2 = tree.preorder_iterate()
        assert(result2 == [10, 6, 4, 8, 14, 12, 16])
        
        print("OVER")
    }
    
    
    func preorder_iterate() -> [Int] {
        var result: [Int] = []
        var this: Tree? = self
        
        var stack = Stack<Tree>()
        
        
        while this != nil || !stack.isEmpty {
            if let tree = this {
                result.append(tree.value)
                if let right = tree.right {
                    stack.push(value: right)
                }
                this = tree.left
            } else {
                this = stack.pop()
            }
        }
        
        return result
    }
}

extension Tree {
    func inorder_recursive() -> [Int] {
        var result: [Int] = []
        if let left = self.left {
            result.append(contentsOf: left.inorder_recursive())
        }
        result.append(value)
        if let right = self.right {
            result.append(contentsOf: right.inorder_recursive())
        }
        return result
    }
    
    func inorder_iterate() -> [Int] {
        var result: [Int] = []
        var this: Tree? = self
        var stack = Stack<Tree>()
        
        while this != nil || !stack.isEmpty {
            if let t = this {
                stack.push(value: t)
                this = this?.left
            } else {
                let tree = stack.pop()
                if let t = tree {
                    result.append(t.value)
                }
                this = tree?.right
            }
        }
        return result
    }
    
    static func inorderTest() {
        let tree = traversalTree()
        let result1 = tree.inorder_recursive()
        assert(result1 == [4, 6, 8, 10, 12, 14, 16])
        
        let result2 = tree.inorder_iterate()
        assert(result2 == [4, 6, 8, 10, 12, 14, 16])
        
        print("OVER")
    }
}

extension Tree {
    func postOrder_recursive() -> [Int] {
        var result: [Int] = []
        if let left = left {
            result.append(contentsOf: left.postOrder_recursive())
        }
        if let right = right {
            result.append(contentsOf: right.postOrder_recursive())
        }
        result.append(value)
        return result
    }
    
    func postOrder_interate() -> [Int] {
     
        var result: [Int] = []
        var prev: Tree?
//        var current: Tree?
        var stack = Stack<Tree>()
        var this: Tree? = self
        while this != nil || !stack.isEmpty {
            if let t = this {
                stack.push(value: t)
                this = t.left
            } else {
                this = stack.peek()
                if let r = this?.right, r != prev {
                    this = r
                } else {
                    prev = this
                    _ = stack.pop()
                    if let t = this {
                        result.append(t.value)
                    }
                    this = nil
                }
            }
        }
        return result
    }
    
    static func postOrderTest() {
        let tree = traversalTree()
        let result1 = tree.postOrder_recursive()
        assert(result1 == [4, 8, 6, 12, 16, 14, 10])
        
        let result2 = tree.postOrder_interate()
        assert(result2 == [4, 8, 6, 12, 16, 14, 10])
        
        print("OVER")
    }
}


extension Tree {
    func level() -> [Int] {
        
        var queue = MyQueue<Tree>()
        var result: [Int] = []
        queue.enqueue(element: self)
        while !queue.isEmpty {
            if let root = queue.dequeue() {
                result.append(root.value)
                
                if let l = root.left {
                    queue.enqueue(element: l)
                }
                if let r = root.right {
                    queue.enqueue(element: r)
                }
            }
        }
        return result
    }
    
    static func levelTest() {
        let tree = traversalTree()
        let result1 = tree.level()
        assert(result1 == [10, 6, 14, 4, 8, 12, 16])
        print("OVER")
    }
}
