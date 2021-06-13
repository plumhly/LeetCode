//
//  16.21 兰顿蚂蚁.swift
//  算法
//
//  Created by Plum on 2021/6/12.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P434
 
 16.22兰顿蚂蚁。一只蚂蚁坐在由白色和黑色方格构成的无限网格上。开始时,网格全白,蚂蚁面向右侧,每行走一步,蚂蚁执行以下操作
    (1)如果在白色方格上,则翻转方格的颜色,向右(顺时针)转90度,并向前移动个单位
    (2)如果在黑色方格上,则翻转方格的颜色,向左(逆时针方向)转90度,并向前移动一个单位
 编写程序来模拟蚂蚁执行的前K个动作,并打印最终的网格。请注意,题目没有提供表示网格的数据结构,你需要自行设计,你编写的方法接受的唯一输入是你应该打印最终的网格,
 不需要返回任何值。方法签名类似于 void printKMoves(int k)
 
 (提示#473,#480,#532,#539,#558,#569,#598,#615,#626)

 */

struct Interview_16_22 {
    
    
    struct Solution {
        
        struct Position : Hashable {
            var row: Int
            var column: Int
            
            mutating
            func change(row: Int, column: Int) {
                self.row += row
                self.column = column
            }
        }
        
        
        enum Orientation: String {
            case left = "←", right = "→", up = "↑", down = "↓"
            
            mutating func turn(isClockwise: Bool) {
                switch self {
                case .left:
                    self = isClockwise ? .up : .down
                    
                case .right:
                    self = isClockwise ? .down : .up
                    
                case .up:
                    self = isClockwise ? .right : .left
                    
                case .down:
                    self = isClockwise ? .left : .right
                }
            }
        }
        
        struct Ant {
            private(set) var orientation = Orientation.right
            private(set) var positon = Position(row: 0, column: 0)
            
            
            mutating func turn(isClockwise: Bool = true) {
                orientation.turn(isClockwise: isClockwise)
            }
            
            mutating func move() {
                let currentRow = positon.row
                let currentColumn = positon.column
                
                switch orientation {
                case .left:
                    positon.change(row: currentRow, column: currentColumn - 1)
                    
                case .right:
                    positon.change(row: currentRow, column: currentColumn + 1)
                    
                case .up:
                    positon.change(row: currentRow - 1, column: currentColumn)
                    
                case .down:
                    positon.change(row: currentRow + 1, column: currentColumn)
            
                }
            }
            
        }
        
        struct Board: CustomStringConvertible {
            var whites: Set<Position> = []
            var leftTopCorner = Position(row: 0, column: 0)
            var rightBottomCorner = Position(row: 0, column: 0)
            var ant = Ant()
            
            mutating
            func flip(on position: Position) {
                if whites.contains(position) {
                    whites.remove(position)
                } else {
                    whites.insert(position)
                }
            }
            
            mutating
            func move() {
                ant.turn(isClockwise: isInWhites(postion: ant.positon))
                flip(on: ant.positon)
                ant.move()
                changeCorner()
            }
            
            func isInWhites(postion: Position) -> Bool {
                return whites.contains(postion)
            }
            
            func isInWhites(row: Int, column: Int) -> Bool {
                return whites.contains(Position(row: row, column: column))
            }
            

            mutating
            func changeCorner() {
                let lMinRow = min(leftTopCorner.row, ant.positon.row)
                let lMinColumn = min(leftTopCorner.column, ant.positon.column)
                
                leftTopCorner.change(row: lMinRow, column: lMinColumn)
                
                let rMaxRow = max(rightBottomCorner.row, ant.positon.column)
                let rMaxColumn = max(rightBottomCorner.column, ant.positon.column)
                
                rightBottomCorner.change(row: rMaxRow, column: rMaxColumn)
            }
            
            
            
            var description: String {
                var des = ""
                for row in leftTopCorner.row...rightBottomCorner.row {
                    for column in leftTopCorner.column...rightBottomCorner.column {
                        if row == ant.positon.row, column == ant.positon.column {
                            des.append(ant.orientation.rawValue)
                        } else if (isInWhites(row: row, column: column)) {
                            des.append("W")
                        } else {
                            des.append("B")
                        }
                    }
                    
                    des.append("\n")
                }
                
                return des
            }
            
            
        }
        
    }
    
    static func test() {
        
        print("\(self) OVER")
    }
}
