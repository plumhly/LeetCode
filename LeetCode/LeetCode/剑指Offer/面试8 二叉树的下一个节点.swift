//
//  面试8 二叉树的下一个节点.swift
//  LeetCode
//
//  Created by Plum on 2020/5/31.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/**
 题目:给定一棵二叉树和其中的一个节点,如何找出中序遍历序列的下一个节点?树中的节点除了有两个分别指向左、右子节点的指针,还有个指向父节点的指针
 P84
 
 
 分析：
 1.如果一个节点有右子树,那么它的下一个节点就是它的右子树中的最左子节点。
 2.如果一个节点既没有右子树,并且它还是它父节点的右子节点,那么这种情形就比较复杂。我们可以沿着指向父节点的指针一直向上遍历,直到找到一个是它父节点的左子节点的节点。如果这样的节点存在,那么这个节点的父节点就是我们要找的下一个节点。
 
 */

struct Topic8 {
    static func nextNode(for tree: Tree?) -> Int? {
        guard tree != nil else { return nil }
        var tempTree = tree
        
        // 如果有右节点，一直往左找
        if tempTree?.right != nil {
            tempTree = tempTree?.right
            while let _ = tempTree?.left {
                tempTree = tempTree?.left
            }
            return tempTree?.value
        } else if tempTree?.parent != nil {
            var current: Tree? = tree
            while let parent = tempTree?.parent, parent.left != current {
                tempTree = parent
                current = parent
            }
            return tempTree?.parent?.value
        }
        
        return nil
    }
    
    static func test() {
        let tree = nextTree()
        let b = tree.left
        
        let result1 = nextNode(for: b)
        assert(result1 == 8)
        
        let i = tree.left?.right?.right
        let result2 = nextNode(for: i)
        assert(result2 == 1)
        
        let g = tree.right?.right
        let result3 = nextNode(for: g)
        assert(result3 == nil)
        print("Topic8 OVer")
        
    }
}
