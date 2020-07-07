//
//  面试题26 树的子结构.swift
//  LeetCode
//
//  Created by Plum on 2020/6/16.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 题目 树的子结构
 
 P148
 
 输入两颗二叉树A和B，判断B是不是A的子树
 
 */

struct Topic26 {
    static func isSubtree(tree: Tree?, sub: Tree?) -> Bool {
        guard let sub = sub else {
            return true
        }
        
        guard let tree = tree else {
            return false
        }
        
        var isSub = tree.value == sub.value
        if isSub {
            isSub = isValueSame(tree: tree, sub: sub)
        }
        
        if !isSub {
            isSub = isSubtree(tree: tree.left, sub: sub)
        }
        
        if !isSub {
            isSub = isSubtree(tree: tree.right, sub: sub)
        }
        
        return isSub
    }
    
    static func isValueSame(tree: Tree?, sub: Tree?) -> Bool {
        if sub == nil {
            return true
        }
        
        if tree == nil {
            return false
        }
        
        if tree!.value == sub!.value {
            return isValueSame(tree: tree?.left, sub: sub?.left) && isValueSame(tree: tree?.right, sub: sub?.right)
        } else {
            return false
        }
    }
    
    static func test() {
        
        let a = Tree(value: 1)
        let b = Tree(value: 2)
        let c = Tree(value: 3)
        let d = Tree(value: 4)
        let e = Tree(value: 5)
        let f = Tree(value: 6)
        
        a.left = b
        a.right = c
        b.left = e
        c.left = f
        
        let g = Tree(value: 6)
        
        assert(isSubtree(tree: nil, sub: nil) == true)
        assert(isSubtree(tree: a, sub: nil) == true)
        
        assert(isSubtree(tree: a, sub: d) == false)
        assert(isSubtree(tree: a, sub: b) == true)
        assert(isSubtree(tree: a, sub: g) == true)
        print("Topic26 OVER")
    }
}
