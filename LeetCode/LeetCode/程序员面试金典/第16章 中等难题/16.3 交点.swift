//
//  16.3 交点.swift
//  算法
//
//  Created by Plum on 2021/6/4.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 16.3交点,给定两条线段(表示为起点和终点如果它们有交点,请计算其交点(提示#471 #496 #516 #526)
 */

/*
 分析：
 情况1：
    直线相交的条件 && 交点在线段1中 && 交点在线段2中
 
 情况2：重合
    线段2的起点在线段1的起点和终点之间
 */

struct Interview_16_3 {
    
    static func intersection(start1: Point, end1: Point, start2: Point, end2: Point) -> Point? {
        /// 先做这样的处理：
        /// 1. 小的点放在前面作为起点
        /// 2. 起点小的线段放在前面
        var start1 = start1
        var end1 = end1
        var start2 = start2
        var end2 = end2
        
        if start1.x > end1.x {
            swap(point1: &start1, point2: &end1)
        }
        
        if start2.x > end2.x {
            swap(point1: &start1, point2: &end2)
        }
    
        if start1.x > start2.x {
            swap(point1: &start1, point2: &start2)
            swap(point1: &end1, point2: &end2)
        }
        
        
        /// 如果两条线段的函数是一样的，那么看是否满足 情况2
        let line1 = Line(start: start1, end: end1)
        let line2 = Line(start: start2, end: end2)
        if line1.scope == line2.scope {
            let isOtherValueEqual = line1.otherValue == line2.otherValue
            if isBetween(start: start1, middle: start2, end: end1) && isOtherValueEqual {
                return start2
            }
        } else {
            /// 计算交点
            let x = (line1.otherValue - line2.otherValue) / (line2.scope - line1.scope)
            let y = line1.scope * x + line1.otherValue
            let intersection = Point(x: x, y: y)
            
            if isBetween(start: start1, middle: intersection, end: end1) && isBetween(start: start2, middle: intersection, end: end2) {
                return intersection
            }
        }
        
        return nil
    }
    
    static func isBetween(start: Point, middle: Point, end: Point) -> Bool {
        return middle.x >= start.x && middle.x <= end.x
    }
    
    static func swap(point1: inout Point, point2: inout Point) {
//        let temp = point1
//        point1 = point2
//        point2 = temp
        (point1, point2) = (point2, point1)
    }
    
    struct Point: Equatable {
        var x: Double
        var y: Double
        
    }
    
    struct Line {
        var scope: Double
        var otherValue: Double = 0
        
        init(start: Point, end: Point) {
            let dx = end.x - start.x
            let dy = end.y - start.y
            
            if dx == 0 {
                scope = Double.infinity
            } else {
                scope = dy / dx
                otherValue = end.y - scope * end.x
            }
        }
    }

    static func test() {
        
//        var p1 = Point(x: 0, y: 0)
//        var p2 = Point(x: 1, y: 1)
//        swap(point1: &p1, point2: &p2)
//        print("\(p1), \(p2)")
//
//        print(Double.infinity == Double.infinity)
        
        do {
            let star1 = Point(x: 2, y: 0)
            let end1 = Point(x: 2, y: 2)
            let start2 = Point(x: 3, y: 0)
            let end2 = Point(x: 3, y: 3)
            assert(intersection(start1: star1, end1: end1, start2: start2, end2: end2) == nil)
        }
        
        do {
            let star1 = Point(x: 0, y: 0)
            let end1 = Point(x: 2, y: 2)
            let start2 = Point(x: 0, y: 2)
            let end2 = Point(x: 2, y: 0)
            assert(intersection(start1: star1, end1: end1, start2: start2, end2: end2) == Point(x: 1, y: 1))
        }
        
        
        
        print("\(self) OVER")
    }
}
