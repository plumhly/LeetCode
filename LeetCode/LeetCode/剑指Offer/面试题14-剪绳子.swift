//
//  面试题14-剪绳子.swift
//  LeetCode
//
//  Created by Plum on 2020/6/7.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation


/**
 面试题14:剪绳子
 
 P96
 
 题目:给你一根长度为n的绳子,请把绳子剪成m段(m、n都是整数, m>1并且m>1),每段绳子的长度记为시이],서[1],…,m]。请问시이x11x…km]可能的最大乘积是多少?例如,当绳子的长度是8时,我们把它剪成长度分别为2、3、3的三段,此时得到的最大乘积是18。
 */

struct Topic14 {
    
    // 动态规划
    /*
      动态规划现在是编程面试中的热门话题。如果面试题是求一个问题的最优解(通常是求最大值或者最小值),
     而且该问题能够分解成若干个子问题,并且子问题之间还有重叠的更小的子问题,就可以考虑用动态规划来解决这个问题。
    
     
     首先定义函数f(n)为把长度为n的绳子剪成若干段后各段长度乘积的最大值。在剪第一刀的时候,我们有n-1种可能的选择
     ,也就是剪出来的第段绳子的可能长度分别为1,2,…n-1。因此f(n)=max((i)x(m-1),其中0<i<n。
     
     动态规划的四个特点：
     1.求最优解
     2.整体最优解依赖子问题最优解
     3.小问题之间有重叠的更小的子问题
     4.以上往下分析问题，以下往上解决问题
     
     */
    /**
     O(n^2)
     S(n)
     
     */
    static func maxValueForCutingString(with length: Int) -> Int {
        if length < 2 {
            return 0
        }
        if length == 2 {
            return 1
        } else if length == 3 {
            return 2
        }
        
        var result = Array<Int>(repeating: 0, count: length + 1)
        result[0] = 0
        result[1] = 1
        result[2] = 2
        result[3] = 3
        
        for i in 4...length {
            var max = 0
            /// ⚠️ 1...i/2是因为类似：1+3 = 4 ，3+1 = 4， 重复计算了
            for j in 1...i/2 {
                let value = result[j] * result[i-j]
                if max < value {
                    max = value
                }
            }
            result[i] = max
        }
        return result[length]
    }
    
    // 贪婪算法
    static func stringCut_greed(length: Int) -> Int {
        if length < 2 {
            return 0
        }
        if length == 2 {
            return 1
        } else if length == 3 {
            return 2
        }
        
        /// 当n>=5时，尽可能剪3，但是如果最后是4，那就要转成2x2
        var timeOf3 = length / 3
        if length - timeOf3 * 3 == 1 { //表示可以组合成4，而4 的最大 2 * 2
            timeOf3 -= 1
        }
        let timeOf2 = (length - timeOf3 * 3) / 2
        return Int(pow(Double(3), Double(timeOf3))) * Int(pow(Double(2), Double(timeOf2)))
    }
    
    static func test() {
        
        print("DP")
        assert(maxValueForCutingString(with: 0) == 0)
        assert(maxValueForCutingString(with: 2) == 1)
        assert(maxValueForCutingString(with: 3) == 2)
        assert(maxValueForCutingString(with: 8) == 18)
        
        print("GREED")
        assert(maxValueForCutingString(with: 0) == 0)
        assert(maxValueForCutingString(with: 2) == 1)
        assert(maxValueForCutingString(with: 3) == 2)
        assert(maxValueForCutingString(with: 8) == 18)
        
        print("Topic14 OVER")
    }
}
