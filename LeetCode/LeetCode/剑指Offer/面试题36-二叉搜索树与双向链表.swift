//
//  面试题36-二叉搜索树与双向链表.swift
//  LeetCode
//
//  Created by Plum on 2020/6/23.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题36:二叉搜索树与双向链表
 
 P191
 
 题目:输入一棵二叉搜索树,将该二叉搜索树转换成一个排序的双向连表。要求不能创建任何新的节点,只能调整树中节点指针的指向。比如, 输入图4.15中左边的二又搜索树,则输出转换之后的排序双向链表。二又树节点的定义如下:
 */
struct Topic36 {
    static func changeSBTToDoubleList(tree: Tree?) -> Tree? {
        guard let tree = tree else {
            return nil
        }
        var current: Tree? = nil
        change(tree: tree, current: &current)
        
        while let left = current?.left {
            current = left
        }
        return current
    }
    
    static func change(tree: Tree?, current: inout Tree?) {
        guard let tree = tree else { return }
        
        let pCurrent = tree
        if let left = pCurrent.left {
            change(tree: left, current: &current)
        }
        
        pCurrent.left = current
        if current != nil {
            current?.right = pCurrent
        }
        current = pCurrent
        
        if let right = pCurrent.right {
            change(tree: right, current: &current)
        }
        
    }
    
    static func leftToRight(tree: Tree?) -> [Int] {
        guard tree != nil else {
            return []
        }
        var this = tree
        var result: [Int] = []
        while let t = this {
            result.append(t.value)
            this = t.right
        }
        return result
    }
    
    static func rightToLeft(tree: Tree?) -> [Int] {
        
        guard tree != nil else {
           return []
        }
        var this = tree
        while let t = this?.right {
            this = t
        }
        
        var result: [Int] = []
        while let t = this {
            result.append(t.value)
            this = t.left
        }
        return result
    }
    
    static func test() {
        let tree = Tree(value: 10, left: Tree(value: 6, left: Tree(value: 4), right: Tree(value: 8)), right: Tree(value: 14, left: Tree(value: 12), right: Tree(value: 16)))
        let current = changeSBTToDoubleList(tree: tree)
        let ltr = leftToRight(tree: current)
        let rtl = rightToLeft(tree: current)
        
        assert(ltr == [4, 6, 8, 10, 12, 14, 16])
        assert(rtl == [16, 14, 12, 10, 8, 6, 4])
        print("Topic36 OVER")
    }
}
