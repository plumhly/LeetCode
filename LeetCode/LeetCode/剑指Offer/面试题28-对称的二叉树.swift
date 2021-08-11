//
//  面试题28-对称的二叉树.swift
//  LeetCode
//
//  Created by Plum on 2020/6/17.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题28:对称的二叉树
 
 P159
 
 题目:请实现一个函数,用来判断一棵二又树是不是对称的。如果棵二叉树和它的镜像一样,那么它是对称的。例如,在如图4.3所示的3棵又树中,第一棵二叉树是对称的,而另外两棵不是
 
 
 分析：
 通常我们有3种不同的二叉树遍历算法,即前序遍历、中序遍历和后序遍历。在这3种遍历算法中,都是先遍历左子节点再遍历右子节点。我们是否可以定义一种遍历算法,先遍历右子节点再遍历左子节点?比如我们针对前序遍历定义一种对称的遍历算法,即先遍历父节点,再遍历它的右子节点,最后遍历它的左子节点。
 
 */
struct Topic28 {
    static func isSymmetrical(tree: Tree?) -> Bool {
        guard let tree = tree else {
            return true
        }
        return isSymmetrical(left: tree, right: tree)
    }
    
    static func isSymmetrical(left: Tree?, right: Tree?) -> Bool {
        if left == nil && right == nil {
            return true
        }
        
        /// 结构不同
        if left == nil || right == nil {
            return false
        }
        
        /// 值不同
        if left!.value != right!.value {
            return false
        }
        
        return isSymmetrical(left: left?.left, right: right?.right) && isSymmetrical(left: left?.right, right: right?.left)
        
    }
    
    static func test() {
        let eight = Tree(value: 8)
        let six1 = Tree(value: 6)
        let six2 = Tree(value: 6)
        
        let five1 = Tree(value: 5)
        let five2 = Tree(value: 5)
        
        let seven1 = Tree(value: 7)
        let seven2 = Tree(value: 7)
        
        six1.left = five1
        six1.right = seven1
        
        six2.right = five2
        six2.left = seven2
        eight.left = six1
        eight.right = six2
        
        let three1 = Tree(value: 3)
        let three2 = Tree(value: 3)
        let three3 = Tree(value: 3)
        let three4 = Tree(value: 3)
        let three5 = Tree(value: 3)
        three1.left = three2
        three1.right = three3
        three2.left = three4
        three2.right = three5
        
        assert(isSymmetrical(tree: eight))
        assert(isSymmetrical(tree: nil))
        assert(isSymmetrical(tree: three1) == false)
        print("Topic28 OVER")
    }
}
