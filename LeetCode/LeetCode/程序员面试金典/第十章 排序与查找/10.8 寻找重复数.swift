//
//  10.8 寻找重复数.swift
//  算法
//
//  Created by Plum on 2021/5/30.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 10.8寻找重复数,给定一个数组,包含1到N的整数,N最大为32000数可能含有重复
 的值,且N的取值不定。若只有4KB内存可用,该如何打印数组中所有重复的元素
 (提示:#289,#315)
 */

struct Interview_10_8 {
    
    
    static func test() {
        
        let a = [1, 2, 4, 2, 1]
        let bitset = BitSet(size: 32000)
        for number in a {
            if bitset.isAlreadySet(value: number) {
                print(number)
            } else {
                bitset.set(value: number)
            }
        }
        
        print("\(self) OVER")
    }
}

class BitSet {
    
    var numbers: [Int]
    let shift: Int
    init(size: Int, shift: Int = 6) {
        self.shift = shift
        let size = (size >> shift) + 1
        numbers = Array<Int>(repeating: 0, count: size)
    }
    
    func isAlreadySet(value: Int) -> Bool {
        let index = value >> shift
        let bitIndex = value & 0x3f
        return (numbers[index] >> bitIndex) & 1 == 1
    }
    
    func set(value: Int) {
        let index = value >> shift
        let bitIndex = value & 0x3f
        let bitValue = numbers[index] | (1 << bitIndex)
        numbers[index] = bitValue
    }
}
