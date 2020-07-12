//
//  (面试题68)树中两个节点的最低公共祖先.swift
//  LeetCode
//
//  Created by Plum on 2020/7/12.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 (面试题68)树中两个节点的最低公共祖先
 
 P326
 
 分校：
 1. 如果是二叉树,并且是二叉搜索树,那么是可以找到公共节点的
 2.如果这棵树不是二叉搜索树,甚至连二叉树都不是,而只是普通的树,又该怎么办呢?
 那么这个问题可以转换成求两个链表的第一个公共节,点、
 
 3.现在假设这棵树是普通的树,而且树中的节点没有指向父节点的指针
 应聘者:(静下来思考了两分钟)所谓两个节点的公共祖先,指的是这两个节点都出现在某个节点的子树中。我们可以从根节点开始遍历一棵树, 每遍历到一个节点时,判断两个输入节点是不是在它的子树中。如果在子树中,则分别遍历它的所有子节点,并判断两个输入节点是不是在它们的子树中。这样从上到下一直找到的第一个节点,它自己的子树中同时包含两个输入的节点而它的子节点却没有,那么该节点就是最低的公共祖先。
 
 4.面试官:听起来不错。很明显,当我们判断以节点A为根的树中是否含有节点F的时候,我们需要对D、E等节点遍历一遍;接下来判断以节点B为根的树中是否含有节点F的时候,我们还是需要对D、E等节点再遍历一遍。这种思路会对同一节点重复遍历很多次。你想想看还有没有更快的算法?
 应聘者:我的想法是用两个链表分别保存从根节点到输入的两个节点的路径,然后把问题转换成两个链表的最后公共节点。
 */

struct Topic68 {
    class Tree {
        let value: Character
        let children: [Tree]?
        
        init(value: Character, children: [Tree]? = nil) {
            self.value = value
            self.children = children
        }
    }
    
    static func findLastCommonNode(root: Tree?, node1: Tree?, node2: Tree?) -> Tree? {
        guard let root = root, let node1 = node1, let node2 = node2 else {
            return nil
        }
        var path1: [Tree] = []
        var path2: [Tree] = []
        
        findPathTo(root: root, node: node1, path: &path1)
        findPathTo(root: root, node: node2, path: &path2)
        return lastComponet(path1: path1, path2: path2)
    }
    
    @discardableResult
    static func findPathTo(root: Tree, node: Tree, path: inout [Tree]) -> Bool {
        
        path.append(root)
        
        if root === node {
            return true
        }
        
        var isContain = root === node
        if isContain {
            return true
        }
        
        if let children = root.children {
            for value in children {
                isContain = findPathTo(root: value, node: node, path: &path)
                if isContain {
                    break
                } else {
                   path.removeLast()
                }
            }
            
        }
        return isContain
    }
    
    static func lastComponet(path1: [Tree], path2: [Tree]) -> Tree? {
        guard
            path1.count > 1,
            path2.count > 1
        else { return nil }
        
        let count = min(path1.count, path2.count)
        var value: Tree? = nil
        for i in 0..<count {
            if path1[i] === path2[i] {
                value = path1[i]
            }
        }
        return value
    }
    
    static func test() {
        let g = Tree(value: Character("G"))
        let f = Tree(value: Character("F"))
        let d = Tree(value: Character("D"), children: [f, g])
        
        let h = Tree(value: Character("H"))
        let i = Tree(value: Character("I"))
        let j = Tree(value: Character("J"))
        let e = Tree(value: Character("E"), children: [h, i, j])
        
        let b = Tree(value: Character("B"), children: [d, e])
        
        let c = Tree(value: Character("C"))
        let a = Tree(value: Character("A"), children: [b, c])
        
        assert(findLastCommonNode(root: a, node1: f, node2: h) === b)
        assert(findLastCommonNode(root: a, node1: f, node2: e) === b)
        print("Topic68 OVER")
    }
}
