//
//  16.15 珠玑妙算.swift
//  算法
//
//  Created by Plum on 2021/6/10.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation
/*
 P
 
 16.15珠玩妙算,珠妙算游戏( the game of master mind)的玩法如下
 计算机有4个槽,每个槽放一个球,颜色可能是红色(R)黄色(Y)绿色(0)或蓝
 色(B)例如,计算机可能有RGGB4种(槽1为红色,槽23为绿色,槽4为蓝色
 作为用户,你试图猜出颜色组合,打个比方,你可能会猜YRGB
 要是猜对某个槽的颜色,则算一次“猜中”;要是只猜对颜色但槽位猜错了,则算一次伪
 猜中”。注意,“猜中”不能算人“伪猜中
 举个例子,实际颜色组合为RGBY,而你猜的是GGR则算一次猜中,一次伪猜中
 给定一个猜测和一种颜色组合,编写一个方法,返回猜中和伪猜中的次数。(提示
 */

struct Interview_16_15 {
    
    enum Color: Int {
        case red, yello, green, blue
    }
    
    
    static func calculateFrequency(colors: [Color], guess: [Color]) -> (right: Int, fake:Int) {
    
        var rightCount = 0
        var fakeCount = 0
        var fakeArray = Array<Int>(repeating: 0, count: colors.count)
        
        for index in 0 ..< colors.count {
            if colors[index] == guess[index] {
                rightCount += 1
            } else {
                fakeArray[colors[index].rawValue] += 1
            }
        }
        
        
        for index in 0 ..< colors.count {
            if colors[index] != guess[index], fakeArray[guess[index].rawValue] > 0 {
                fakeCount += 1
                fakeArray[guess[index].rawValue] -= 1
            }
        }
        
        return (rightCount, fakeCount)
    }
    
    static func test() {
        
        let result = calculateFrequency(colors: [Color.red, Color.green, Color.blue, Color.yello], guess: [Color.green, Color.green, Color.red, Color.red])
        assert(result.right == 1)
        assert(result.fake == 1)
        
        print("\(self) OVER")
    }
}
