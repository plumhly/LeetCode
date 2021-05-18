//
//  8.13推箱子.swift
//  算法
//
//  Created by Plum on 2021/5/15.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P307
 
 8.13堆箱子。给你一堆n个箱子,箱子宽Wi，高Hi、深Di。箱子不能翻转,将箱子堆起来时,
 下面箱子的宽度、高度和深度必须大于上面的箱子。实现一种方法,搭出最高的一堆箱子。
 箱堆的高度为每个箱子高度的总和。(提示:#155,#194,#214,#260,#322,#368,#378)
 */

struct Interview_8_13 {
    
    /**
     * 有很多重复计算
     *
     */
    struct Solution1 {
        static func stackBox(boxes: [Box]) -> Int {
            /// 排序
            let boxes = boxes.sorted {$0.height < $1.height}
            var maxHeight = 0
            
            for (index, _) in boxes.enumerated() {
                let height = createStack(boxes: boxes, bottomIndex: index)
                maxHeight = max(height, maxHeight)
            }
            
            return maxHeight
        }
        
        private static func createStack(boxes: [Box], bottomIndex: Int) -> Int {
            
            guard bottomIndex < boxes.count else {
                return 0
            }
            
            // 依次选底部箱子
            let box = boxes[bottomIndex]
            let nextIndex = bottomIndex + 1
            
            var maxHeight = 0
            for index in nextIndex..<boxes.count where isBoxValid(currentBox: box, nextBox: boxes[index]) {
                let height = createStack(boxes: boxes, bottomIndex: index)
                maxHeight = max(height, maxHeight)
            }
            
            return maxHeight + box.height
        }
        
        private static func isBoxValid(currentBox: Box, nextBox: Box) -> Bool {
            return currentBox.width < nextBox.width && currentBox.deep < nextBox.deep
        }
    }
    
    
    /**
     * 消除有很多重复计算
     *
     */
    struct Solution2 {
        static func stackBox(boxes: [Box]) -> Int {
            /// 排序
            let boxes = boxes.sorted {$0.height < $1.height}
            var maxHeight = 0
            
            // 以bn为第一个的最大高度
            var heightMap = Array<Int>(repeating: 0, count: boxes.count)
            for (index, _) in boxes.enumerated() {
                let height = createStack(boxes: boxes, bottomIndex: index, result: &heightMap)
                maxHeight = max(height, maxHeight)
            }
            
            return maxHeight
        }
        
        private static func createStack(boxes: [Box], bottomIndex: Int, result: inout [Int]) -> Int {
            
            guard bottomIndex < boxes.count else {
                return 0
            }
            
            if result[bottomIndex] > 0 {
                return result[bottomIndex]
            }
            
            // 依次选底部箱子
            let box = boxes[bottomIndex]
            let nextIndex = bottomIndex + 1
            
            var maxHeight = 0
            for index in nextIndex..<boxes.count where isBoxValid(currentBox: box, nextBox: boxes[index]) {
                let height = createStack(boxes: boxes, bottomIndex: index, result: &result)
                maxHeight = max(height, maxHeight)
            }
            
            let maxValue = maxHeight + box.height
            result[bottomIndex] = maxValue
            return maxValue
        }
        
        private static func isBoxValid(currentBox: Box, nextBox: Box) -> Bool {
            return currentBox.width < nextBox.width && currentBox.deep < nextBox.deep
        }
    }
    
    
    struct Solution3 {
        static func stackBox(boxes: [Box]) -> Int {
            /// 排序
            let boxes = boxes.sorted {$0.height < $1.height}
            // 以bn为第一个的最大高度
            var heightMap = Array<Int>(repeating: 0, count: boxes.count)
            return createStack(boxes: boxes, box: nil, topIndex: 0, result: &heightMap)
        }
        
        private static func createStack(boxes: [Box], box: Box?, topIndex: Int, result: inout [Int]) -> Int {
            guard topIndex < boxes.count else {
                return 0
            }
            
            // 将该box作为顶部
            let current = boxes[topIndex]
            var maxHeightWithTop = 0
            /**
             box == nil, 表示上面没有箱子
             */
            if box == nil || isBoxValid(currentBox: box!, nextBox: current){
                if result[topIndex] == 0 {
                    let hegiht = createStack(boxes: boxes,box: current, topIndex: topIndex + 1, result: &result)
                    result[topIndex] = hegiht + current.height
                }
                maxHeightWithTop = result[topIndex]
            }
            
            
            // 不将该box多为顶部
            let maxHeightWithoutTop = createStack(boxes: boxes, box: box, topIndex: topIndex + 1, result: &result)
            
            return max(maxHeightWithTop, maxHeightWithoutTop)
            
        }
        
        private static func isBoxValid(currentBox: Box, nextBox: Box) -> Bool {
            return currentBox.width < nextBox.width && currentBox.deep < nextBox.deep
        }
    }
    
    
    
    static func test() {
        let boxes = [
            Box(width: 4, height: 5, deep: 6),
            Box(width: 1, height: 2, deep: 3),
            Box(width: 7, height: 8, deep: 9),
        ]
        
        assert(Solution1.stackBox(boxes: boxes) == 15)
        print("Solution1 OVER")
        
        assert(Solution2.stackBox(boxes: boxes) == 15)
        print("Solution2 OVER")
        
        assert(Solution3.stackBox(boxes: boxes) == 15)
        print("Solution3 OVER")
    }
}

struct Box {
    let width, height, deep: Int
    
}
