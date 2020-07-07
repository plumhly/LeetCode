//
//  面试题16-数值的整数次方.swift
//  LeetCode
//
//  Created by Plum on 2020/6/7.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题16:数值的整数次方
 
 */

struct Topic16 {
    static func pow(base: Int, exponent: Int) -> (Bool, Double) {
        guard base != 0 else {
            return (false, 0)
        }
        
        if exponent == 0 {
            return (true, 1)
        }
        
        let unSignedExponent: UInt
        if exponent < 0 {
            unSignedExponent = UInt(-exponent)
        } else {
            unSignedExponent = UInt(exponent)
        }
        
//        var result = powUnsigned(base: base, exponent: unSignedExponent)
        var result = powUnsigned_fast(base: base, exponent: unSignedExponent)
        
        if exponent < 0 {
            result = 1 / result
        }
        
        
        return (true, result)
    }
    
    // round1
    static func powUnsigned(base: Int, exponent: UInt) -> Double {
        var result = base
        for _ in 1..<exponent {
            result *= base
        }
        return Double(result)
    }
    
    // round2
    static func powUnsigned_fast(base: Int, exponent: UInt) -> Double {
       // 边界
        if exponent == 0 {
            return 1
        }
        if exponent == 1 {
            return Double(base)
        }
        
        var result = Double(base)
        result = powUnsigned_fast(base: base, exponent: exponent >> 1)
        result = result * result
        // * 用 & 代替 %
        if exponent & 1 == 1 { //奇数
            result *= Double(base)
        }
        return result
    }
    
    static func test() {
        let res1 = pow(base: 0, exponent: 0)
        let res2 = pow(base: 2, exponent: -3)
        let res3 = pow(base: 2, exponent: 3)
        
        assert(res1.0 == false)
        assert(res2.0 && res2.1 == 1 / 8)
        assert(res3.0 && res3.1 == 8)
        print("Topic16 OVER")
    }
}
