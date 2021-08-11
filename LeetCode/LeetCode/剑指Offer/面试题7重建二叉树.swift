//
//  面试题7重建二叉树.swift
//  LeetCode
//
//  Created by Plum on 2020/5/31.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/**
 题目:输入某二叉树的前序遍历和中序遍历的结果,请重建该二叉树。
 假设输入的前序遍历和中序遍历的结果中都不含重复的数字。例如,输入前序遍历序列{1,2,4,7,3,5,6,8}和中序遍历序列{4,7,2,1,5,3,8,6},则重建如图2.6所示的二叉树并输出它的头节点。二叉树节点的定义如下:
 
算法分析：
 所示,前序遍历序列的第一个数字1就是根节点的值。扫描中序遍历序列,就能确定根节点的值的位置。根据中序遍历的特点,在根节点的值1前面的3个数字都是左子树节点的值,位于1后面的数字都是右子树节点的值。
 由于在中序遍历序列中,有3个数字是左子树节点的值,因此左子树共有3个左子节点。同样,在前序遍历序列中,根节点后面的3个数字就是3个左子树节点的值,再后面的所有数字都是右子树节点的值。这样我们就在前序遍历和中序遍历两个序列中分别找到了左、右子树对应的子序列。
 
 */

struct Topic7 {

    static func constructTree(with preorder: [Int], inorder: [Int]) -> Tree? {
        guard preorder.count > 1, preorder.count == inorder.count else {
            return nil
        }
        
        return _constructTree(with: preorder, preStart: 0, preEnd: preorder.count - 1, inorder: inorder, inStart: 0, inEnd: inorder.count - 1)
    }
    
   static func _constructTree(with preorder: [Int], preStart: Int, preEnd: Int, inorder: [Int], inStart: Int, inEnd: Int) -> Tree? {
        
//        guard preEnd < preorder.count, inEnd < inorder.count else { return nil }
        
        let rootValue = preorder[preStart]
        let rootTree = Tree(value: rootValue)
    
        if preStart == preEnd {
            return rootTree
        }
        
        // 寻找左子树的长度
        var start = inStart
    
        while start <= inEnd, inorder[start] != rootValue {
            start += 1
        }
        
        let leftChildLength = start - inStart
    
        // 构建左子树
        let lPreStart = preStart + 1
        let lPreEnd = lPreStart + leftChildLength - 1
        
        let lInStart = inStart
        let lInEnd = inStart + leftChildLength - 1
        
        if leftChildLength > 0 {
            rootTree.left = _constructTree(with: preorder, preStart: lPreStart, preEnd: lPreEnd, inorder: inorder, inStart: lInStart, inEnd: lInEnd)
        }
        
        // 构建右子树
        let rPreStart = lPreEnd + 1
        let rPreEnd = preEnd
        
        let rInStart = lInEnd + 2
        let rInEnd = inEnd
        
        // 看前序里面是否有右子树
        if leftChildLength < preEnd - preStart {
            rootTree.right = _constructTree(with: preorder, preStart: rPreStart, preEnd: rPreEnd, inorder: inorder, inStart: rInStart, inEnd: rInEnd)
        }
        
        return rootTree
    }
    
    static func test() {
        let preOrder = [1, 2, 4, 7, 3, 5, 6, 8]
        let inorder = [4, 7, 2, 1, 5, 3, 8, 6]
        let tree = constructTree(with: preOrder, inorder: inorder)
        
        let resul1 = tree?.preorder_recursive()
        assert((resul1 != nil) && (resul1 == preOrder))
        
        let resul2 = tree?.inorder_recursive()
        assert((resul2 != nil) && (resul2 == inorder))
        print("Topic7 Over")
    }
}
