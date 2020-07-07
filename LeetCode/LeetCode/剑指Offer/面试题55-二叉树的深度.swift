//
//  面试题55-二叉树的深度.swift
//  LeetCode
//
//  Created by Plum on 2020/7/4.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题55:二叉树的深度
 
 P271
 
 
 */

struct Topic55 {
    /*
     题目一:二又树的深度。
     
     P271
     
     输入一棵二叉树的根节点,求该树的深度。从根节点到叶节点依次经过的节点(含根、叶节点)形成树的一条路径,最长路径的长度为树的深度
     */
    struct Topic1 {
        static func deep(of tree: Tree?) -> Int {
            guard let tree = tree else {
                return 0
            }
            
            let left = deep(of: tree.left)
            let right = deep(of: tree.right)
            return left > right ? left + 1 : right + 1
        }
        
        static func test() {
            let tree = Tree(value: 1, left: Tree(value: 2, left: Tree(value: 4), right: Tree(value: 5, left: Tree(value: 7))), right: Tree(value: 3, right: Tree(value: 6)))
            
            assert(deep(of: tree) == 4)
            
            let tre2 = Tree(value: 1, left:Tree(value: 2, left: Tree(value: 3)))
            assert(deep(of: tre2) == 3)
            print("Topic55.Topic1 OVER")
        }
    }
    
    /*
     题目二:平衡二又树。
     
     P273
     
     输入一棵二又树的根节点,判断该树是不是平衡二又树。如果某二又树中任意节点的左、右子树的深度相差不超过1,那么它就是一棵平衡二叉树。例如,图6.2中的二叉树就是一棵平衡二叉树。
     
     分析： 如果按照题目一的结果，先求出左右子树的深度来比较，那么点判断根节点，然后左右子树，其中就会有很多的重复计算。
     
     ```
     bool Isbalanced(Binary Treenode*proot) {
        if(proot=nullptr)
            return true
        int left=treedepth(proot->m pleft)
        int right=Treedepth(proot->m pright)
        int diff= left -right;
        if(diff> 1 || diff<-1)
            return false
     
        return Isbalanced(Proot->m_pleft) && Isbalanced(Proot->m_pright)
     ```
     
     所以：
     如果我们用后序遍历的方式遍历二又树的每个节点,那么在遍历到个节点之前我们就已经遍历了它的左、右子树。只要在遍历每个节点的时候记录它的深度(某一节点的深度等于它到叶节点的路径的长度),我们就可以边遍历一边判断每个节点是不是平衡的。下面是这种思路的参考代码:
     */
    struct Topic2 {
        static func isBalanceTree(_ tree: Tree?) -> Bool {
            var deep = 0
            return isBalance(tree: tree, deep: &deep)
        }
        
        static func isBalance(tree: Tree?, deep: inout Int) -> Bool {
            guard let tree = tree else {
                deep = 0
                return true
            }
            
            var left = 0
            var right = 0
            
            if isBalance(tree: tree.left, deep: &left), isBalance(tree: tree.right, deep: &right) {
                let result = left - right
                if result >= -1 && result <= 1 {
                    deep = left > right ? left + 1 : right + 1
                    return true
                }
            }
            return false
        }
        
        static func test() {
            let tree1 = Tree(value: 1, left: Tree(value: 2, left: Tree(value: 3), right: Tree(value: 4)), right: Tree(value: 5, left: Tree(value: 6), right: Tree(value: 7)))
            
            let tree2 = Tree(value: 1, left: Tree(value: 2, left: Tree(value: 3)))
            let tree3 = Tree(value: 1, right: Tree(value: 2, right: Tree(value: 3)))
            
            assert(isBalanceTree(tree1))
            assert(isBalanceTree(tree2) == false)
            assert(isBalanceTree(tree3) == false)
            print("Topic55.Topic2 OVER")
        }
    }
}
