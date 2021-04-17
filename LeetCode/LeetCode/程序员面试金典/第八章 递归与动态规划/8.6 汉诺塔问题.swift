//
//  8.6 汉诺塔问题.swift
//  算法
//
//  Created by Plum on 2021/4/17.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/**
 P296
 
 8.6汉诺塔问题。在经典汉诺塔问题中,有3根柱子及N个不同大小的穿孔圆盘,盘子可以
 滑入任意一根柱子。一开始,所有盘子自上而下按升序依次套在第一根柱子上(即每一
 个盘子只能放在更大的盘子上面)。移动圆盘时受到以下限制:
 (1)每次只能移动一个盘子;
 (2)盘子只能从柱子顶端滑出移到下一根柱子;
 (3)盘子只能叠在比它大的盘子上。
 请编写程序,用栈将所有盘子从第一根柱子移到最后一根柱子。(提示:#144,#224,#272,#318)
 */


struct Interview_8_6 {
    static func tower(cycleCount: Int, src: inout Stack<Int>, des: inout Stack<Int>, buffer: inout Stack<Int>) {
        if cycleCount < 1 { // 这里是控制pop的次数
            return
        }
        // 把n-1移动到buffer
        tower(cycleCount: cycleCount - 1, src: &src, des: &buffer, buffer: &des )
        
        // 然后移动n到des
        des.push(value: src.pop()!)
        
        // 把buffer移动到des
        tower(cycleCount: cycleCount - 1, src: &buffer, des: &des, buffer: &src)
    }
    
    static func test() {
        var src = Stack<Int>()
        src.push(value: 4)
        src.push(value: 3)
        src.push(value: 2)
        src.push(value: 1)
        
        var buffer = Stack<Int>()
        var des = Stack<Int>()
        
        tower(cycleCount: src.size, src: &src, des: &des, buffer: &buffer)
        
        print(des)
    
    }
}
