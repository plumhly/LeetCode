//
//  面试题32-从上到下打印二叉树.swift
//  LeetCode
//
//  Created by Plum on 2020/6/21.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题32:从上到下打印二叉树
 
 P 171
 
 题目一:不分行从上到下打印二叉树从上到下打印出二又树的每个节点,同一层的节点按照从左到右的顺序打印。例如,输入图4.6中的二叉树,则依次打印出8,6,10,5,7,9,11 叉树节点的定义如下:
 
 */
struct Topic32 {
    static func levelTraveral(tree: Tree) -> [Int] {
        var queue = MyQueue<Tree>()
        queue.enqueue(element: tree)
        var result: [Int] = []
        while !queue.isEmpty {
            if let tree = queue.dequeue() {
                result.append(tree.value)
                if let left = tree.left {
                    queue.enqueue(element: left)
                }
                if let right = tree.right {
                    queue.enqueue(element: right)
                }
            }
        }
        return result
    }
    
    /*
     题目二:分行从上到下打印二叉树。
     从上到下按层打印二又树,同一层的节点按从左到右的顺序打印,每层打印到一行。例如,打印图4.7中二叉树的结果为:
     */
    static func levelTraveralNexLine(tree: Tree) -> [[Int]] {
        var queue = MyQueue<Tree>()
        queue.enqueue(element: tree)
        var result: [[Int]] = []
        var nextLevelCount = 0
        var remainCount = 1
        var tempResult: [Int] = []
        while !queue.isEmpty {
            if let tree = queue.dequeue() {
                tempResult.append(tree.value)
                
                remainCount -= 1
                
                if let left = tree.left {
                    queue.enqueue(element: left)
                    nextLevelCount += 1
                }
                if let right = tree.right {
                    queue.enqueue(element: right)
                    nextLevelCount += 1
                }
                
                if remainCount == 0 {
                    //打印完了
                    result.append(tempResult)
                    tempResult = []
                    remainCount = nextLevelCount
                    nextLevelCount = 0
                }
            }
        }
        return result
    }
    
    /*
     题目三:之字形打印二又树。
     请实现一个函数按照之字形顺序打印二叉树,即第一行按照从左到右的顺序打印,第二层按照从右到左的顺序打印,第三行再按照从左到右的顺序打印,其他行以此类推。例如,按之字形顺序打印图4.8中二叉树的结果为:
     */
    static func levelTraveralZline(tree: Tree) -> [[Int]] {
        var queue = MyQueue<Tree>()
        queue.enqueue(element: tree)
        var result: [[Int]] = []
        var nextLevelCount = 0
        var remainCount = 1
        var tempResult: [Int] = []
        var tempStack = Stack<Int>()
        var line = 0
        while !queue.isEmpty {
            if let tree = queue.dequeue() {
                
                //偶数行存数组，奇数行存栈
                let isEven = line & 1 == 0
                if isEven {
                    tempResult.append(tree.value)
                } else {
                    tempStack.push(value: tree.value)
                }
                
                // **
                remainCount -= 1
                
                if let left = tree.left {
                    queue.enqueue(element: left)
                    nextLevelCount += 1
                }
                if let right = tree.right {
                    queue.enqueue(element: right)
                    nextLevelCount += 1
                }
                
                if remainCount == 0 {
                    //打印完了
                    if isEven {
                        result.append(tempResult)
                        tempResult = []
                    } else {
                        var array: [Int] = []
                        while let v = tempStack.pop() {
                            array.append(v)
                        }
                        result.append(array)
                    }
                    remainCount = nextLevelCount
                    nextLevelCount = 0
                    line += 1
                }
            }
        }
        return result
    }
    
    static func levelTraveralZline2(tree: Tree) -> [[Int]] {
        
        // 偶数 0， 奇数 1
        var stacks: [Stack<Tree>] = [Stack<Tree>(), Stack<Tree>()]
        var line = 0
        stacks[0].push(value: tree)
        
        var result: [[Int]] = []
        var tempResult:[Int] = []
 
        while !stacks[0].isEmpty || !stacks[1].isEmpty {
            let index = line & 1
            
            if let tree = stacks[index].pop() {
                tempResult.append(tree.value)
                
                // 偶数 左到右， 奇数 右到左
                if index == 0 {
                    if let left = tree.left {
                        stacks[1].push(value: left)
                    }
                    
                    if let right = tree.right {
                        stacks[1].push(value: right)
                    }
                } else {
                    if let right = tree.right {
                        stacks[0].push(value: right)
                    }
                    if let left = tree.left {
                        stacks[0].push(value: left)
                    }
                }
                
                if stacks[index].isEmpty {
                    // 完了，下一层
                    line += 1
                    result.append(tempResult)
                    tempResult = []
                }
            }
        }
      return result
    }
 
    static func test() {
        let tree = traversalTree()
        let result1 = levelTraveral(tree: tree)
        assert(result1 == [10, 6, 14, 4, 8, 12, 16])
        
        let result2 = levelTraveralNexLine(tree: tree)
        assert(result2 == [[10], [6, 14], [4, 8 , 12, 16]])
        
        
        let result3 = levelTraveralZline(tree: tree)
        assert(result3 == [[10], [14, 6], [4, 8 , 12, 16]])
        
        let result4 = levelTraveralZline2(tree: tree)
        assert(result4 == [[10], [14, 6], [4, 8 , 12, 16]])
        
        print("Topic32 OVER")
    }
}
