//
//  面试题37-序列化二又树.swift
//  LeetCode
//
//  Created by Plum on 2020/6/23.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题37:序列化二又树
 
 P194
 
 题目:请实现两个函数,分别用来序列化和反序列化二叉树。
 
 分析：
 通过分析解决面试题7“重建二又树”,我们知道可以从前序遍历序列，和中序遍历序列中构造出一棵二叉树。受此启发,我们可以先把一棵二叉树序列化成一个前序遍历序列和一个中序遍历序列,然后在反序列化时通过这两个序列重构出原二叉树。
 这种思路有两个缺点:一是该方法要求二又树中不能有数值重复的节点;二是只有当两个序列中所有数据都读出后才能开始反序列化。如果两个遍历序列的数据是从一个流里读出来的,那么可能需要等待较长的时间。
 实际上,如果二又树的序列化是从根节点开始的,那么相应的反序列化在根节点的数值读出来的时候就可以开始了。因此,我们可以根据前序遍历的顺序来序列化二又树,因为前序遍历是从根节点开始的。在遍历二又树碰到 nullptr指针时,这些 nullptr指针序列化为一个特殊的字符(如S)。
 另外,节点的数值之间要用一个特殊字符(如:)隔开。
 根据这样的序列化规则,图4.17中的二又树被序列化成字符串1,2,4,$,$,$,3,5,$,$,6,$,$"。
 */

struct Topic37 {
    static func serialize(tree: Tree?) -> [Any] {
        guard let tree = tree else {
            return []
        }
        var result: [Any] = []
        result.append(tree.value)
        if let left = tree.left {
            result.append(contentsOf: serialize(tree: left))
        } else {
            result.append("$")
        }
        
        if let right = tree.right {
            result.append(contentsOf: serialize(tree: right))
        } else {
            result.append("$")
        }
        return result
    }
    
    static func deserialize(array: [Any]) -> Tree? {
        guard !array.isEmpty else {
            return nil
        }
        var index = 0
        return deserialize(array: array, index: &index)
    }
    
    static func deserialize(array: [Any], index: inout Int) -> Tree? {
        guard index < array.endIndex else {
            return nil
        }
        
        if array[index] is Int {
            let tree = Tree(value: array[index] as! Int)
            index += 1
            tree.left = deserialize(array: array, index: &index)
            tree.right = deserialize(array: array, index: &index)
            return tree
        }
        index += 1
        return nil
    }
    
    static func test() {
        
        let tree = Tree(value: 1, left: Tree(value: 2, left: Tree(value: 4)), right: Tree(value: 3, left: Tree(value: 5), right: Tree(value: 6)))
        
        let result1 = serialize(tree: tree)
        let tree2 = deserialize(array: result1)
        print("Topic37 OVER")
    }
}
