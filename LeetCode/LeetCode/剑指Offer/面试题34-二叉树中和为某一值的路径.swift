//
//  面试题34-二叉树中和为某一值的路径.swift
//  LeetCode
//
//  Created by Plum on 2020/6/21.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题34:二叉树中和为某一值的路径
 
 P182
 
 题目:输入一棵二叉树和一个整数,打印出二叉树中节点值的和为输入整数的所有路径。从树的根节点开始往下一直到叶节点所经过的节点形成一条路径。二叉树节点的定义如下:
 
 */
struct Topic34 {
    static func findPath(tree: Tree?, sum: Int) -> [[Int]]? {
        guard let tree = tree else { return nil}
        
        var result: [[Int]] = []
        var path: [Int] = []
        findPath(tree: tree, sum: sum, current: 0, path: &path, result: &result)
        return result
    }
    
    static func findPath(tree: Tree, sum: Int, current: Int, path: inout [Int], result: inout [[Int]]) {
        
        var current = current
        let root = tree.value
        
        current += root
        path.append(root)
        
        let isLeaf = tree.left == nil && tree.right == nil
        if isLeaf, current == sum {
            // 记录节点
            result.append(path)
        }
        
        if let left = tree.left {
            findPath(tree: left, sum: sum, current: current, path: &path, result: &result)
        }
        
        if let right = tree.right {
            findPath(tree: right, sum: sum, current: current, path: &path, result: &result)
        }
        
        // ***
        // 无论成功或者失败都要回溯
        path.removeLast()
    }
    
    
    static func test() {
        let tree = Tree(value: 10, left: Tree(value: 5, left: Tree(value: 4), right: Tree(value: 7)), right: Tree(value: 12))
        
        assert(findPath(tree: tree, sum: 22) == [[10, 5, 7], [10, 12]])
        assert(findPath(tree: tree, sum: 19) == [[10, 5, 4]])
        assert(findPath(tree: nil, sum: 20) == nil)
        
        print("Topic34 OVER")
    }
}
