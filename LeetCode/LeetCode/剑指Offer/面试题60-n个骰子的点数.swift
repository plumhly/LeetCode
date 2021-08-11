//
//  面试题60-n个骰子的点数.swift
//  LeetCode
//
//  Created by Plum on 2020/7/8.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题60:n个骰子的点数
 
 P294
 
 题目:把n个骰子扔在地上,所有骰子朝上一面的点数之和为s。输n,打印出s的所有可能的值出现的概率
 */

struct Topic60 {
    static let maxPoint = 6
    struct Solution1 {
        static func printPercentOfAllSum(number: Int) {
            guard number > 0 else {
                return
            }
            // 6n - n + 1, 【n, 6n】
            let count = maxPoint * number - number + 1
            var counts = Array<Int>(repeating: 0, count: count)
            for i in 1...maxPoint {
                sumOf(counts: &counts, number: number, index: number, sum: i)
            }
            
            let all = Int(pow(Double(maxPoint), Double(number)))
            
            for (index, value) in counts.enumerated() {
                /// 存的时候是 sum - number = index
                print("sum:\(index + number) percent: \(value)/\(all)")
            }
        }
        
        static func sumOf(counts: inout [Int], number: Int, index: Int, sum: Int) {
            if index == 1 {
                counts[sum - number] += 1
                return
            }
            for i in 1...maxPoint {
                // **
                let current = sum + i
                sumOf(counts: &counts, number: number, index: index - 1, sum: current)
            }
        }
        
    }
    
    /*
     令解法二:基于循环求骰子点数,时间性能好
     
     P296
     
     分析：
     可以换一种思路来解决这个问题。我们可以考虑用两个数组来存储骰子点数的每个总数出现的次数。在一轮循环中,第一个数组中的第n个数字表示骰子和为n出现的次数。在下一轮循环中,我们加上一个新的骰子, 此时和为n的骰子出现的次数应该等于上一轮循环中骰子点数和为n1、n-2、n-3、n-4、n-5与n-6的次数的总和,所以我们把另一个数组的第n 个数字设为前一个数组对应的第n1、n-2、n-3、n-4、n-5与n-6个数字之和。基于这种思路,我们可以写出如下代码:
     */
    struct Solution2 {
        static func printPercentOfAllSum(number: Int) {
            guard number > 0 else {
                return
            }
            let count = number * maxPoint + 1
            
            
            var result = Array<[Int]>(repeating: Array<Int>(repeating: 0, count: count), count: 2)
            
            var flag = 0
            // 填充只有一个骰子的数据
            for i in 1...maxPoint {
                result[flag][i] = 1
            }
            
            //*
            for k in 2...number {
                
                // 这里表示最小的和前面的数据清空
                for i in 0..<k {
                    result[1-flag][i] = 0
                }
                
                // 和的范围
                for i in k...(maxPoint * k) {
                    // 先把当前的数据清空，因为这里的数据用他之前的推算出来
                    result[1-flag][i] = 0
                    
                    //从 n-1 到 n-6的和
                    for j in 1...maxPoint where j <= i {
                        result[1-flag][i] += result[flag][i - j]
                    }
                }
                
                // 轮换 flag
                flag = 1 - flag
            }
            
            let all = Int(pow(Double(maxPoint), Double(number)))
            let finalResult = result[flag]
            for i in number...(maxPoint * number) {
                print("sum:\(i) percent: \(finalResult[i])/\(all)")
            }
        }
    }
    
    static func test() {
//        Solution1.printPercentOfAllSum(number: 2)
        Solution2.printPercentOfAllSum(number: 2)
    }
}
