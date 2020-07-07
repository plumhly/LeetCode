//
//  面试题48-最长不含重复字符的子字符串.swift
//  LeetCode
//
//  Created by Plum on 2020/6/30.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题48:最长不含重复字符的子字符串
 
 P236
 
 题目:请从字符串中找出一个最长的不包含重复字符的子字符串,计算该最长子字符串的长度。假设字符串中只包含'a~z的字符。例如,在字符串" arabcacfr"中,最长的不含重复字符的子字符串是"acf",长度为4。
 
 分析：
 我们不难找出字符串的所有子字符串,然后就可以判断每个子字符串中是否包含重复的字符。这种蛮力法唯一的缺点就是效率。一个长度为n 的字符串有On)个子字符串,我们需要Om)的时间判断一个子字符串中是否包含重复的字符,因此该解法的总的时间效率是O(m)。
 
 接下来我们用动态规划算法来提高效率。首先定义函数()表示以第i 个字符为结尾的不包含重复字符的子字符串的最长长度。我们从左到右逐扫描字符串中的每个字符。当我们计算以第i个字符为结尾的不包含重复字符的子字符串的最长长度の)时,我们已经知道f-1)了。
 如果第i个字符之前没有出现过,那么の)=パi-1)+1。例如,在字符串arabcacfr'"中,显然(の)等于1。在计算1)时,下标为1的字符r之前没有出现过,因此A1)等于2,即1)=fO+1。到目前为止,最长的不含重复字符的子字符串是"ar 如果第i个字符之前已经出现过,那情况就要复杂一点了。我们先计算
 
 第个字符和它上次出现在字符串中的位置的距离,并记为d,接着分两种情形分析。第一种情形是d小于或者等于ー1),此时第i个字符上次出现在(i-1)对应的最长子字符串之中,因此A)-d。同时这也意味着在第i个字符出现两次所夹的子字符串中再也没有其他重复的字符了。在前面的例子中,我们继续计算八2),即以下标为2的字符a'为结尾的不含重复字符的子字符串的最长长度。我们注意到字符a'在之前出现过,该字符上一次出现在下标为0的位置,它们之间的距离d为2,也就是字符a'出现在八1)对应的最长不含重复字符的子字符串"ar"中,此时八2)=d,即八2)=2,对应的最长不含重复字符的子字符串是"ra 第二种情形是d大于fー1),此时第个字符上次出现在-1)对应的最长子字符串之前,因此仍然有(の)=iー1)+1。我们接下来分析以字符串arabcacfr"最后一个字符r为结尾的最长不含重复字符的子字符串的长度, 即求f8)。以它前一个字符为结尾的最长不含重复字符的子字符串是"acf", 因此∫7)=3。我们注意到最后一个字符之前在字符串" arabcacfrl"中出现过, 上一次出现在下标为1的位置,因此两次出现的距离d等于7,大于)。
 这说明上一个字符r不在7对应的最长不含重复字符的子字符串"acf"中, 此时把字符'拼接到"ac"的后面也不会出现重复字符。因此f8)=八7)+1,即8)-4,对应的最长不含重复字符的子字符串是"acfr"
 */

struct Topic48 {
    static func maxNoRepeatSubstringLength(str: String) -> Int {
        guard !str.isEmpty else {
            return 0
        }
        
        var array = Array<Int>(repeating: -1, count: 26)
        var currentLength = 0
        var maxLength = 0
        
        for (index, i) in str.indices.enumerated() {
            let idx = Int(str[i].asciiValue! - Character("a").asciiValue!)
            let value = array[idx]
            if value < 0 || index - value > currentLength {
                currentLength += 1
            } else {
                if currentLength > maxLength {
                    maxLength = currentLength
                }
                currentLength = index - value
            }
            array[idx] = index
        }
        
        if currentLength > maxLength {
            maxLength = currentLength
        }
        return maxLength
    }
    
    static func test() {
        let a = "arabcacfr"
        assert(maxNoRepeatSubstringLength(str: a) == 4)
        
        let b = "aaaaaa"
        assert(maxNoRepeatSubstringLength(str: b) == 1)
        
        let c = "a"
        assert(maxNoRepeatSubstringLength(str: c) == 1)
        
        print("Topic48 OVER")
    }
}
