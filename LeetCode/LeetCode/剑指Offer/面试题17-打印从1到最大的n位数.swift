//
//  面试题17-打印从1到最大的n位数.swift
//  LeetCode
//
//  Created by Plum on 2020/6/9.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation


/**
 面试题17:打印从1到最大的n位数
 
 P114
 
 题目:输入数字n,按顺序打印出从1到最大的n位十进制数。比如输入3,则打印出1、2、3一直到最大的3位数999
 */

struct Topic17 {
    
    struct Round1 {
        static func printMaxNumber(n: Int) {
            var result = Array<Character>(repeating: "0", count: n)
            while isNotMax(number: &result) {
                printNumber(number: &result)
            }
        }
        
        static func isNotMax(number: inout [Character]) -> Bool {
            var maxValue: UInt8 = 0
            var carry: UInt8 = 0
            var isReachMax = false
            let zeroValue = ("0" as Character).asciiValue!
            for i in stride(from: number.count - 1, through: 0, by: -1) {
                maxValue = number[i].asciiValue! - zeroValue  + carry
                if i == number.count - 1 {
                    maxValue += 1
                }
                
                if maxValue >= 10 {
                    // 进位
                    // 最大位
                    if i == 0 {
                        isReachMax = true
                    } else {
                        maxValue -= 10
                        carry += 1
                        let assicValue = zeroValue + maxValue
                        number[i] = Character(UnicodeScalar(assicValue))
                    }
                } else {
                    let assicValue = zeroValue + maxValue
                    number[i] = Character(UnicodeScalar(assicValue))
                    break
                }
            }
            return !isReachMax
        }
        
        
    }
    
    // 全排列 空间复杂度 O(n): 数组 O(n)， 栈 O(n)
    struct Round2 {
        static  let zeroValue = ("0" as Character).asciiValue!
        static func printMaxNumber(n: Int) {
            guard n > 0 else {
                print("0")
                return
            }
            
            var result = Array<Character>(repeating: "0", count: n)
            for i in 0..<10 {
                // 高位
                result[0] = Character(UnicodeScalar(UInt8(i) + zeroValue)) //1
                printMaxNumber(result: &result, n: n, index: 0) // 1
            }
            
        }
        
        static func printMaxNumber(result: inout [Character], n: Int, index: Int) {
           
            // 最后一个
            if index == n - 1 {
                printNumber(number: &result)
                return
            }
            for i in 0..<10 {
                result[index + 1] = Character(UnicodeScalar(UInt8(i) + zeroValue))
                printMaxNumber(result: &result, n: n, index: index + 1)
            }
        }
    }
    
    static func printNumber(number: inout [Character]) {
        var begining0 = true
        for i in number {
            if begining0 && i != "0" {
                begining0 = false
                print(i, terminator: "")
            }
            if !begining0 {
                print(i, terminator: "")
            }
        }
        print("")
    }
    
    
    static func test() {
//        Round1.printMaxNumber(n: 2)
//        Round2.printMaxNumber(n: 20)
        
        
        // bitma
    }
}
