//
//  10.10.swift
//  算法
//
//  Created by Plum on 2021/6/2.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 10.10数字流的秩。假设你正在读取一串整数,每隔一段时间,你希望能找出数字x的秩(小于或等于x的值的个数),
 请实现数据结构和算法来支持这些操作,也就是说实现track(int x)方法,每读入一个数字都会调用该方法实现 getRankOfNumber(intx)
 方法,返回小于或等于x(x除外)的值的个数
 示例:
    数据流为(按出现的先后顺序): 5,1,4,4,5,9,7,13,3
    
    getRankOfNumber(1)=0
    getRankOfNumber(3)=1
    getRankOfNumber(4)=3
 
 (提示:#301,#376,392)
 */

struct Interview_10_10 {
    
    static var node: RankNode?
    static func track(number: Int) {
        if node == nil {
            node = RankNode(value: number)
        } else {
            node?.insert(number: number)
        }
    }
    
    static func getRank(of number: Int) -> Int? {
        return node?.getRank(number: number)
    }
    
    
    class RankNode {
        var leftSize = 0
        var leftNode: RankNode?
        var rightNode: RankNode?
        var value: Int
        
        init(value: Int) {
            self.value = value
        }
        
        func insert(number: Int) {
            if number <= value {
                // 插入左边
                leftSize += 1
                if leftNode == nil {
                    leftNode = RankNode(value: number)
                } else {
                    leftNode?.insert(number: number)
                }
            } else {
                if rightNode == nil {
                    rightNode = RankNode(value: number)
                } else {
                    rightNode?.insert(number: number)
                }
            }
        }
        
        func getRank(number: Int) -> Int? {
            var size: Int?
            if number == value {
                size = leftSize
            } else if (number < value) {
                size = leftNode?.getRank(number: number)
            } else {
                
                // 这里之所以不能返回0，是因为 如果 number不树中
                if let rightRanke = rightNode?.getRank(number: number) {
                    size = leftSize + 1 + rightRanke
                }
            }
            
            return size
        }
    }
    
    static func test() {
        track(number: 5)
        track(number: 1)
        track(number: 4)
        track(number: 4)
        track(number: 5)
        track(number: 9)
        track(number: 7)
        track(number: 13)
        track(number: 3)
        
        assert(getRank(of: 26) == nil)
        assert(getRank(of: 1) == 0)
        assert(getRank(of: 3) == 1)
        assert(getRank(of: 4) == 3)
        
        print("\(self) OVER")
    }
}
