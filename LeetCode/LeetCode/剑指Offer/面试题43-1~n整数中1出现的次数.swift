//
//  面试题43-1~n整数中1出现的次数.swift
//  LeetCode
//
//  Created by Plum on 2020/6/26.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题43:1~η整数中1出现的次数
 
 P221
 
 题目:输入一个整数n,求1~n这n个整数的十进制表示中1出现的次数。例如,输入12,1~12这些整数中包含1的数字有1、10、11和12 一共出现了5次。
 
 分析：
 1. 如果直接遍历需要 O(nlogn)
 
 2. 如果希望不用计算每个数字的1的个数,那就只能去寻找1在数字中出现的规律了。为了找到规律,我们不妨用一个稍微大一点的数字如21345 作为例子来分析。我们把1~21345的所有数字分为两段:一段是1~1345: 另一段是1346~21345。
 我们先看1346~21345中1出现的次数。1的出现分为两种情况。首先分析1出现在最高位(本例中是万位)的情况。在1346~21345的数字中, 1出现在100019999这10000个数字的万位中,一共出现了10000 (10-)次。
 值得注意的是,并不是对所有5位数而言在万位出现的次数都是10000 次。对于万位是1的数字如输入12345,1只出现在100012345的万位出现的次数不是10次,而是2346次,也就是除去最高数字之后剩下的数字再加上1(2345+1=2346次)。
 接下来分析1出现在除最高位之外的其他4位数中的情况。例子中1346~21345这20000个数字中后4位中1出现的次数是8000次。由于最高位是2,我们可以再把1346~21345分成两段:1346~11345和11346 21345。每一段剩下的4位数字中,选择其中一位是1,其余三位可以在0~9这10个数字中任意选择,因此根据排列组合原则,总共出现的次数是2× 4×10-8000次。
 至于在1~1345中1出现的次数,我们就可以用递归求得了。这也是我们为什么要把1~21345分成1~1345和1346~21345两段的原因。因为把21345的最高位去掉就变成1345,便于我们采用递归的思路。
 */

struct Topic43 {
    static func numberOf1Between1AndN(_ n: Int) -> Int {
        guard n > 0 else { return 0 }
        let toString = "\(n)"
        return numberOf(str: toString, index: toString.startIndex)
    }
    
    static func numberOf(str: String, index: String.Index) -> Int {
        if index == str.endIndex {
            return 0
        }
        
        let first = str[index].asciiValue! - Character("0").asciiValue!
        let length = str.distance(from: index, to: str.endIndex)
        
        if length == 1, first == 0 {
            return 0
        }
        
        if length == 1, first > 0 {
            return 1
        }
        
        var firstNumber = 0
        if first > 1 {
            firstNumber = baseOf10(length - 1)
        } else if first == 1 {
            // 算最高位
            let afterIndex = str.index(after: index)
            if let count = Int(str[afterIndex..<str.endIndex]) {
                firstNumber = count + 1
            }
        }
        
        /// length - 1是除去最高位的剩下位数
        let otherNumber = Int(first) * (length - 1) * baseOf10(length - 2)
        
        // 移除高位递归计算
        let one = numberOf(str: str, index: str.index(after: index))
        
        return firstNumber + otherNumber + one
        
    }
    
    static func baseOf10(_ length: Int) -> Int {
        var result = 1
        for _ in 0..<length {
            result *= 10
        }
        return result
    }
    
    static func test() {
        assert(numberOf1Between1AndN(0) == 0)
        assert(numberOf1Between1AndN(1) == 1)
        assert(numberOf1Between1AndN(5) == 1)
        assert(numberOf1Between1AndN(20) == 12)
        print("Topic43 OVER")
    }
}
