//
//  17.11 BiNode.swift
//  算法
//
//  Created by Plum on 2021/6/21.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P475
 
 7.12 BiNode。 有个名为BiNode的简单数据结构包含指向另外两个节点的指针

 public class BiNode {
    public BiNode nodel, node2;
    public int data;
 }
 
 BiNode可用来表示二树(其中node1为左子节点，node2为右子节点)或双向链表(其中node1为前趋节点,node2为后继节点)。
 实现一个方法,把用BiNode实现的二叉搜索树转换为双向链表,要求值的顺序保持不变,转换操作应是原址的,也就是在原始的
 二叉搜索树上直接修改。
 
 (提示:508 607 645 679 700 718)
 */

struct Interview_17_12 {
    class BiNode {
        var node1: BiNode?
        var node2: BiNode?
        let data: Int
        
        init(data: Int, node1: BiNode? = nil, node2: BiNode? = nil) {
            self.data = data
            self.node1 = node1
            self.node2 = node2
        }
        
    }
    
    private static func concat(x: BiNode?, y: BiNode?) {
        x?.node2 = y
        y?.node1 = x
    }
    
    struct Solution1 {
        
        class NodePair {
            let head: BiNode?
            let tail: BiNode?
            
            init(head: BiNode?, tail: BiNode?) {
                self.head = head
                self.tail = tail
            }
        }
        
        static func convert(tree: BiNode?) -> NodePair? {
            guard let tree = tree else {
                return nil
            }
            
            let leftNodePaire = convert(tree: tree.node1)
            let rightNodePaire = convert(tree: tree.node2)
            
            concat(x: leftNodePaire?.tail, y: tree)
            concat(x: tree, y: rightNodePaire?.head)
            
            return NodePair(head: leftNodePaire?.head ?? tree, tail: rightNodePaire?.tail ?? tree)
        }
    }
    
    struct Solution2 {
        static func convert(tree: BiNode?) -> BiNode? {
            guard let tree = tree else {
                return nil
            }
            
            let leftNode = convert(tree: tree.node1)
            let rightNode = convert(tree: tree.node2)
            
    
            concat(x: getTail(in: leftNode), y: tree)
            concat(x: tree, y: rightNode)
            
            return leftNode ?? tree
        }
        
        private static func getTail(in tree: BiNode?) -> BiNode? {
            guard var node = tree else {
                return nil
            }
            
            while let nextNode = node.node2 {
                node = nextNode
            }
            
            return node
        }
    }
    
    /// 循环链表
    //
    struct Solution3 {
        static func convert(tree: BiNode?) -> BiNode? {
            let result = covertR(node: tree)
            /// 断链
            result?.node1?.node2 = nil
            result?.node1 = nil
            
            return result
        }
        
        private static func covertR(node: BiNode?) -> BiNode? {
            guard let node = node else {
                return nil
            }
            
            let leftNode = covertR(node: node.node1)
            let rightNode = covertR(node: node.node2)
            
            if leftNode == nil, rightNode == nil {
                // 自我循环
                node.node1 = node
                node.node2 = node
                
                return node
            }
            
            let trail = rightNode?.node1
            
            // 让node1指向尾节点
            if leftNode == nil {
                /// 若左边为空，那么现在就构建循环链表
                concat(x: trail, y: node)
            } else {
                // 否则，获取左边的尾节点，然后拼接
                concat(x: leftNode?.node1, y: node)
            }
            
            if rightNode == nil {
                concat(x: node, y: leftNode)
            } else {
                concat(x: node, y: rightNode)
            }
            
            // 合并左右
            if leftNode != nil, rightNode != nil {
                concat(x: trail, y: leftNode)
            }
            
            return leftNode ?? node
        }
    }
    
    static func test() {
        
        do {
            let tree = BiNode(data: 5, node1: BiNode(data: 3, node1: BiNode(data: 2), node2: BiNode(data: 4)), node2: BiNode(data: 7, node1: BiNode(data: 6), node2: BiNode(data: 8)))
            
            let result1 = Solution1.convert(tree: tree)
        }
        
        do {
            let tree = BiNode(data: 5, node1: BiNode(data: 3, node1: BiNode(data: 2), node2: BiNode(data: 4)), node2: BiNode(data: 7, node1: BiNode(data: 6), node2: BiNode(data: 8)))
            
            let result2 = Solution2.convert(tree: tree)
            print("")
        }
        
        do {
            let tree = BiNode(data: 5, node1: BiNode(data: 3, node1: BiNode(data: 2), node2: BiNode(data: 4)), node2: BiNode(data: 7, node1: BiNode(data: 6), node2: BiNode(data: 8)))
            
            let result2 = Solution3.convert(tree: tree)
            print("")
        }
        
       
        
        print("\(self) OVER")
    }
}
