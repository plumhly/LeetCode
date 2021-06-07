//
//  8.10 颜色填充.swift
//  算法
//
//  Created by Plum on 2021/5/8.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 p303
 
 8.10颜色填充,编写函数,实现许多图片编辑软件都支持的“颜色填充”功能。给定一个屏
 幕(以二维数组表示,元素为颜色值)一个点和一个新的颜色值,将新颜色值填入这个
 点的周围区域,直到原来的颜色值全都改变。(提示:#364,#382)
 */

enum Color {
    case red, yellow, blue, green
}

struct Interview_8_10 {
    
    static func fillColor(screen: inout [[Color]], row: Int, column: Int, nColor: Color)  {
        guard
            row >= 0,
            row < screen.count,
            column >= 0,
            column < screen[0].count,
            screen[row][column] != nColor
        else {
            return
        }
        
        fillColor(screen: &screen, row: row, column: column, oColor: screen[row][column], nColor: nColor)
    }
    
    private static func fillColor(screen: inout [[Color]], row: Int, column: Int, oColor: Color, nColor: Color) {
        guard row >= 0, row < screen.count, column >= 0, column < screen[0].count else {
            return
        }
        
        if screen[row][column] == oColor {
            screen[row][column] = nColor
            fillColor(screen: &screen, row: row - 1, column: column, oColor: oColor, nColor: nColor)
            fillColor(screen: &screen, row: row, column: column - 1, oColor: oColor, nColor: nColor)
            fillColor(screen: &screen, row: row + 1, column: column, oColor: oColor, nColor: nColor)
            fillColor(screen: &screen, row: row, column: column + 1, oColor: oColor, nColor: nColor)
        }
    }
    
    static func test() {
        
        var screen = [[Color.red, Color.red], [Color.green, Color.green]]
        fillColor(screen: &screen, row: 0, column: 0, nColor: Color.yellow)
        print(screen)
        print("Interview_8_10 OVER")
    }
}
