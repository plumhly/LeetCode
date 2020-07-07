//
//  面试题15-二进制中1的个数.swift
//  LeetCode
//
//  Created by Plum on 2020/6/7.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

struct Topic15 {
    
    // round1, 这样解决不了负数
    static func numberOfOneInBanary(value: Int) -> Int {
        var value = value
        var count = 0
        while value > 0 {
            if value & 1 == 1 {
                count += 1
            }
            value = value >> 1
        }
        return count
    }
    
    //round2
    /**
     在这个解法中,循环的次数等于整数二进制的位数,32位的整数需要循环32次。下面再介绍一种算法,整数中有几个1就只需要循环几次
     */
//    static func numberOfOneInBanary_round2(value: Int) -> Int {
//        var flag: UInt = 1
//        var count = 0
//        while flag > 0 {
//            if value & Int(flag) > 0 {
//                count += 1
//            }
//            flag = flag << 1
//        }
//        return count
//    }
    
    // round3
    /**
     
     在分析这种算法之前,我们先来分析把一个数减去1的情况。如果个整数不等于0,那么该整数的二进制表示中至少有一位是1。先假设这个数的最右边一位是1,那么减去1时,最后一位变成0而其他所有位都保持不变。也就是最后一位相当于做了取反操作,由1变成了0。
     接下来假设最后一位不是1而是0的情況。如果该整数的二进制表示中最右边的1位于第m位,那么减去1时,第m位由1变成0,而第m位之后的所有0都变成1,整数中第m位之前的所有位都保持不变。举个例子:一个二进制数1100,它的第二位是从最右边数起的一个1。减去1后, 第二位变成0,它后面的两位0变成1,而前面的1保持不变,因此得到的结果是1011。
     在前面两种情况中,我们发现把一个整数减去1,都是把最右边的1变成0。如果它的右边还有0,则所有的0都变成1,而它左边的所有位都保持不变。接下来我们把一个整数和它减去1的结果做位与运算,相当于把它最右边的1变成0。还是以前面的1100为例,它减去1的结果是1011。
     我们再把1100和1011做位与运算,得到的结果是1000。我们把1100最右边的1变成了0,结果刚好就是1000。
     我们把上面的分析总结起来就是:把一个整数减去1,再和原整数做与运算,会把该整数最右边的1変成0那么一个整数的二进制表示中有多少个1,
     */
    static func numberOfOneInBanary_round3(value: Int) -> Int {
        var value = value
        var count = 0
        while value != 0 {
            count += 1
            value = (value - 1) & value
        }
        return count
    }
    
    static func test() {
        assert(numberOfOneInBanary(value: 4) == 1)
        assert(numberOfOneInBanary(value: 0) == 0)
        assert(numberOfOneInBanary(value: 1) == 1)
        
//        assert(numberOfOneInBanary_round2(value: 4) == 1)
//        assert(numberOfOneInBanary_round2(value: 0) == 0)
//        assert(numberOfOneInBanary_round2(value: 1) == 1)
//        assert(numberOfOneInBanary_round2(value: -1) == 32)
        
        assert(numberOfOneInBanary_round3(value: 4) == 1)
        assert(numberOfOneInBanary_round3(value: 0) == 0)
        assert(numberOfOneInBanary_round3(value: 1) == 1)
//        assert(numberOfOneInBanary_round3(value: -1) == 64)
        
        print("Topic15 OVER")
    }
}
