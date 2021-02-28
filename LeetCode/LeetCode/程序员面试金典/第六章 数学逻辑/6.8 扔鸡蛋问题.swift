//
//  6.8 扔鸡蛋问题.swift
//  算法
//
//  Created by Plum on 2021/2/25.
//  Copyright © 2021 Plum. All rights reserved.
//

/*
 扔鸡蛋问题。有栋建筑物高100层，若从第N层或更高的楼层扔下来，鸡蛋就会破碎；
 若从第N层以下的楼层扔下来则不会破碎。给你两个鸡蛋，请找出N,并要求最差情况
 下扔鸡蛋的次数为最少。
 */


/*
 答案：
 (x+1)x/2 = 100
 
 x = 13.65 => 14
 */

import Foundation

struct Interview_6_8 {
    
    static let breakFloor = 34
    static let total = 100
    
    static func findFloor() -> Int? {
        guard total > 0 else {
            return nil
        }
        
        var interval = 14
        var privousFloor = 0
        var egg1 = interval
        
        while isEggNotBroken(floor: egg1), egg1 <= total  {
            privousFloor = egg1
            egg1 += interval - 1
            interval -= 1
        }
        
        var egg2 = privousFloor + 1
        
        while egg2 < egg1, isEggNotBroken(floor: egg2), egg2 <= total {
            egg2 += 1
        }
        
        return egg2
    }
    
    static func isEggNotBroken(floor: Int) -> Bool {
        return floor < breakFloor
    }
}
