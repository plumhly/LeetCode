//
//  BitMap.swift
//  算法
//
//  Created by Plum on 2020/8/1.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

//参考资料 https://www.jianshu.com/p/6082a2f7df8e

struct BitMap {
    
    static let shift = MemoryLayout.alignment(ofValue: Int()) * 8
    var array: [Int]
    let size: Int
    let shiftPow = 6 // 2^6
    let mask = BitMap.shift - 1
    
    init(size: Int) {
        self.size = size
        
        // 0 代表 0 的位置， 8在第二行
        let count = (size >> shiftPow) + 1
        array = Array<Int>(repeating: 0, count: count)
    }
    
    // 加入数字在数组中的index
    func index(of number: Int) -> Int {
        return number >> shiftPow
    }
    
    // 加入数字在数组中的index中的位置
    func position(of number: Int) -> Int {
        return number & mask
    }
    
    @discardableResult
    mutating func add(_ number: Int) -> Bool {
        guard number <= size else { return false }
        let index = self.index(of: number)
        let value = array[index]
        let shiftValue = 1 << position(of: number)
        array[index] = value | shiftValue
        return true
    }
    
    @discardableResult
    mutating func remove(_ number: Int) -> Bool {
        guard number <= size else { return false }
        let index = self.index(of: number)
        let value = array[index]
        let shiftValue = ~(1 << position(of: number))
        array[index] = value & shiftValue
        return true
    }
    
    @discardableResult
    func value(_ number: Int) -> Int? {
        guard number <= size else { return nil }
        let index = self.index(of: number)
        let value = array[index]
        return (value >> position(of: number)) & 1
    }
    
    func contains(_ number: Int) -> Bool {
        guard number <= size else { return false }
        let index = self.index(of: number)
        let value = array[index]
        let shiftValue = 1 << position(of: number)
        return shiftValue & value > 0
    }
    
    
    static func test() {
        var bitmap = BitMap(size: 64)
        bitmap.add(1)
        bitmap.add(61)
        bitmap.add(0)
        bitmap.add(64)
        
        assert(bitmap.add(65) == false)
        assert(bitmap.contains(1))
        
        assert(bitmap.remove(1))
        assert(bitmap.contains(1) == false)
        
        assert(bitmap.contains(0))
        assert(bitmap.contains(61))
        assert(bitmap.contains(64))
        assert(bitmap.contains(62) == false)
        print("BitMap OVER")
    }
}


extension BitMap: Sequence {
    func makeIterator() -> BitMapIterator {
        return BitMapIterator(self)
    }
}


struct BitMapIterator: IteratorProtocol {
    
    let bitmap: BitMap
    var times = 0
    
    init(_ bitmap: BitMap) {
        self.bitmap = bitmap
    }
    
    mutating
    func next() -> Int? {
        let nextNumber = times
        guard nextNumber <= bitmap.size else {
            return nil
        }
        times += 1
        return bitmap.value(nextNumber)
    }
}
