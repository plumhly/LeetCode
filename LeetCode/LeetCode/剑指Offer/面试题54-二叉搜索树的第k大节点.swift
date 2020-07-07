//
//  面试题54-二叉搜索树的第k大节点.swift
//  LeetCode
//
//  Created by Plum on 2020/7/4.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题54:二叉搜索树的第k大节点
 
 P269
 
 题目:给定一棵二叉搜索树,请找出其中第k大的节点。例如,在图中的二又搜索树里,按节点数值大小顺序,第三大节点的值是4
 */

struct Topic54 {
    static func find(k: Int, tree: Tree) -> Tree? {
        guard k > 0 else {
            return nil
        }
    
        var k = k
        return find(in: tree, k: &k)
    }
    
    static func find(in tree: Tree?, k: inout Int) -> Tree? {
        
        var target: Tree? = nil
        if let left = tree?.left {
            target = find(in: left, k: &k)
        }
        
        if target == nil {
            if k == 1 {
                target = tree
            }
            k -= 1
        }
    
        if target == nil, let right = tree?.right {
            target = find(in: right, k: &k)
        }
        return target
    }
    
    static func test() {
        let tree2 = Tree(value: 2)
        let tree3 = Tree(value: 3)
        let tree4 = Tree(value: 4)
        let tree5 = Tree(value: 5)
        let tree6 = Tree(value: 6)
        let tree7 = Tree(value: 7)
        let tree8 = Tree(value: 8)
        
        tree3.left = tree2
        tree3.right = tree4
        
        tree7.left = tree6
        tree7.right = tree8
        
        tree5.left = tree3
        tree5.right = tree7
        
        assert(find(k: 3, tree: tree5) === tree4)
        print("Topic54 OVER" )
    }
}
