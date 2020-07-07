//
//  面试题38-字符串的排列.swift
//  LeetCode
//
//  Created by Plum on 2020/6/24.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 见 StringOperation
 面试题38:字符串的排列
 
 P197
 
 题目:输入一个字符串,打印出该字符串中字符的所有排列。例如, 输入字符串abc,则打印出由字符a、b、c所能排列出来的所有字符串abe acb、bac、bca、cab和cba
 
 分析：我们求整个字符串的排列,可以看成两步。第一步求所有可能出现在第一个位置的字符,即把第一个字符和后面所有的字符交换。图4.18就是分别把第一个字符a和后面的b、c等字符交换的情形。第二步固定第一个字符,如图4.18(a)所示,求后面所有字符的排列。这时候我们仍把后面的所有字符分成两部分:后面字符的第一个字符,以及这个字符之后的所有字符。然后把第一个字符逐一和它后面的字符交换,如图4.18(b)所示。
 */

//--------------去掉重复的全排列的-------------
// 题目：输入一个字符串，输出该字符串中字符的所有组合。举个例子，如果输入abc，它的组合有a、b、c、ab、ac、bc、abc。
// 分析：假设我们想在长度为n的字符串中求m个字符的组合。我们先从头扫描字符串的第一个字符。针对第一个字符，我们有两种选择：第一是把这个字符放到组合中去，接下来我们需要在剩下的n-1个字符中选取m-1个字符；第二是不把这个字符放到组合中去，接下来我们需要在剩下的n-1个字符中选择m个字符。这两种选择都很容易用递归实现。下面是这种思路的参考代码：

struct Topic38 {
    static func combination(str: String) {
        for i in 1...str.count {
            var result: [Character] = []
            combination(str: str, number: i, index: str.startIndex, result: &result)
        }
    }
    
    static func combination(str: String, number: Int, index: String.Index, result: inout [Character]) {
        if number == 0 {
            // 打印
            let re = String(result)
            print(re)
            return
        }
        if index == str.endIndex {
            return
        }
        // 添加到组合
        result.append(str[index])
        combination(str: str, number: number - 1, index: str.index(after: index), result: &result)
        
        // 不添加到组合
        result.removeLast()
        combination(str: str, number: number, index: str.index(after: index), result: &result)
    }
    
    static func test() {
        let s = "abc"
        combination(str: s)
        
        Queuen.queuen(number: 4)
        
        print("Topic38 OVER")
    }
    
    struct Queuen {
        static func queuen(number: Int) {
            guard number > 0 else {
                return
            }
            
            var columnIndex = Array<Int>(0..<number)
            permutation(array: &columnIndex, number: 0)
        }
        
        static func permutation(array: inout [Int], number: Int) {
            if number == array.endIndex - 1 {
                // 看是否满n皇后规则
                // 打印
                if chech(array: array) {
                    print(array)
                }
                return
            }
            for i in number...array.count - 1 {
                array.swapAt(i, number)
                permutation(array: &array, number: number + 1)
                array.swapAt(i, number)
            }
        }
        
        static func chech(array: [Int]) -> Bool {
            for i in 0..<array.count {
                for j in i+1..<array.count {
                    if i - j == array[i] - array[j] || j - i == array[i] - array[j] {
                        return false
                    }
                }
            }
            return true
        }
    }
}
