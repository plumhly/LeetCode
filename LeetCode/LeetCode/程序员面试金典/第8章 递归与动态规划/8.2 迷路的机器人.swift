//
//  8.2 迷路的机器人.swift
//  算法
//
//  Created by Plum on 2021/3/7.
//  Copyright © 2021 Plum. All rights reserved.
//

/*
 8.2迷路的机器人。设想有个机器人坐在一个网格的左上角，网格r行c列。机器人只能向

 下或向右移动，但不能走到一些被禁止的网格。设计一种算法，寻找机器人从左上角移动到右下角的路径。（提示：#331，#360，#388）
 */

import Foundation

struct Interview_8_2 {
    
    private static func isMazeValid(maze: [[Bool]]) -> Bool {
        guard !maze.isEmpty, !maze[0].isEmpty else {
            return false
        }
        
        let length = maze[0].count
        return maze.allSatisfy { $0.count == length }
    }
    
    /*
     时间：O(2^(r+n))
     空间：O(r+c)
     
     分析：此方法有个最大的问题，如果一个点不可能有有路径能到达（比如它的上和左都是禁止访问的网格），但是因为其是两个点的上一步，可能会被重复计算
     */
    struct Solution1 {
        static func getPath(maze: [[Bool]]) -> [CGPoint]? {
            guard isMazeValid(maze: maze) else {
                return nil
            }
            
            // row和clomun的值
            let row = maze.count - 1
            let colum = maze.first!.count - 1
            var path: [CGPoint] = []
            if getPath(maze: maze, row: row, column: colum, path: &path) {
                return path
            }
            return nil
        }
        
        private static func getPath(maze: [[Bool]], row: Int, column: Int, path: inout [CGPoint]) -> Bool {
            guard row >= 0, column >= 0, maze[row][column] else {
                return false
            }
            
            let isOriginPoint = row == 0 && column == 0
            
            // 由于短路效应，这里只能执行一条路
            if isOriginPoint
                || getPath(maze: maze, row: row - 1, column: column, path: &path)
                || getPath(maze: maze, row: row, column: column - 1, path: &path) {
                let point = CGPoint(x: row, y: column)
                path.append(point)
                return true
            }
            
            return false
        }
    }
    
    /*
     时间：O(r*n)
     空间：O(r+c)
     */
    struct Solution2 {
        static func getPath(maze: [[Bool]]) -> [CGPoint]? {
            guard isMazeValid(maze: maze) else {
                return nil
            }
            
            // row和clomun的值
            let row = maze.count - 1
            let colum = maze.first!.count - 1
            var path: [CGPoint] = []
            var failedSet: [CGPoint] = []
            if getPath(maze: maze, row: row, column: colum, path: &path, failedPoint: &failedSet) {
                return path
            }
            return nil
        }
        
        private static func getPath(maze: [[Bool]], row: Int, column: Int, path: inout [CGPoint], failedPoint: inout [CGPoint]) -> Bool {
            guard row >= 0, column >= 0, maze[row][column] else {
                return false
            }
            
            let point = CGPoint(x: row, y: column)
            if failedPoint.contains(point) {
                return false
            }
            
            let isOriginPoint = row == 0 && column == 0
            // 由于短路效应，这里只能执行一条路
            if isOriginPoint
                || getPath(maze: maze, row: row - 1, column: column, path: &path, failedPoint: &failedPoint)
                || getPath(maze: maze, row: row, column: column - 1, path: &path, failedPoint: &failedPoint) {
                path.append(point)
                return true
            }
            
            failedPoint.append(point)
            return false
        }
    }
    
    static func test() {
        let row = 4
        let coloum = 4
        
        let maze = Array<Array<Bool>>(repeating: Array<Bool>(repeating: true, count: coloum), count: row)
       print(Solution1.getPath(maze: maze))
    }
}
