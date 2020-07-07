//
//  面试题27-二叉树的镜像.swift
//  LeetCode
//
//  Created by Plum on 2020/6/16.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题27:二叉树的镜像
 
 P157
 
 题目:请完成一个函数,输入一棵二叉树,该函数输出它的镜像。
 又树节点的定义如下
 */

struct Topic27 {
    static func mirrorBinaryTree(tree: Tree?) {
        
        guard let tree = tree else {
            return
        }
        
        if tree.left == nil && tree.right == nil {
            return
        }
        
        let temp = tree.left
        tree.left = tree.right
        tree.right = temp
        
        if let left = tree.left {
            mirrorBinaryTree(tree: left)
        }
        
        if let right = tree.right {
            mirrorBinaryTree(tree: right)
        }
        
    }
    
    static func test() {
        let tree = traversalTree()
        mirrorBinaryTree(tree: tree)
        assert(tree.preorder_recursive() == [10, 14, 16, 12, 6, 8, 4])
        
        let tree2 = Tree(value: 1, left: Tree(value: 2, left: Tree(value: 3)))
        mirrorBinaryTree(tree: tree2)
        assert(tree2.preorder_recursive() == [1 ,2 ,3])
        
        let tree3 = Tree(value: 1, right: Tree(value: 2, right: Tree(value: 3)))
        mirrorBinaryTree(tree: tree3)
        assert(tree2.preorder_recursive() == [1 ,2 ,3])
        
        print("Topic27 OVER")
    }
}
