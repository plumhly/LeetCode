//
//  面试题56-数组中数字出现的次数.swift
//  LeetCode
//
//  Created by Plum on 2020/7/5.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

/*
 面试题56:数组中数字出现的次数
 
 P275
 
 
 */

struct Topic56 {
    /*
     个整型数组里除两个数字之外,其他数字都出现了两次。请写程序找出这两个只出现一次的数字。要求时间复杂度是Oの),空间复杂度是O()。
     
     分析：这两道题目都在强调一个(或两个)数字只出现一次,其他数字出现两次。这有什么意义呢?我们想到异或运算的一个性质:任何一个数字异或它自己都等于0。也就是说,如果我们从头到尾依次异或数组中的每个数字,那么最终的结果刚好是那个只出现一次的数字,因为那些成对出现两次的数字全部在异或中抵消了。
     想明白怎么解决这个简单的问题之后,我们再回到原始的问题,看看能不能运用相同的思路。我们试着把原数组分成两个子数组,使得每个子数组包含一个只出现一次的数字,而其他数字都成对出现两次。如果能够这样拆分成两个数组,那么我们就可以按照前面的办法分别找出两个只出现一次的数字了。
     */
    struct Topic1 {
        static func findTwoNumberOnlyAppearOnce(in array: [Int]) -> [Int]? {
            guard array.count > 1 else {
                return nil
            }
            
            var result = 0
            array.forEach { result ^= $0 }
            
            let index = findFirstBite(in: result)
            
            var value1 = 0
            var value2 = 0
            // 把数组分为两部分，每部分包含一个只出现一次的数字
            array.forEach { value in
                if isBit1(number: value, at: index) {
                    value1 ^= value
                } else {
                    value2 ^= value
                }
            }
            return [value1, value2]
        }
        
        static func findFirstBite(in number: Int) -> Int {
            var index = 0
            var number = number
            let size = MemoryLayout.size(ofValue: number) * 8
            while (number & 1) == 0  && index < size {
                number >>= 1
                index += 1
            }
            return index
        }
        
        static func isBit1(number: Int, at index: Int) -> Bool {
            return (number >> index) & 1 == 1
        }
        
        static func test() {
            
            let a = [0, 1]
            let resulta = findTwoNumberOnlyAppearOnce(in: a)
            assert(resulta == a || resulta == [1, 0])
            
            let b = [1, 2, 3, 2, 4, 3]
            let result = findTwoNumberOnlyAppearOnce(in: b)
            assert(result == [1, 4] || result == [4, 1])
            
            print("Topic56.Topic1 OVER")
        }
    }
    
    
    /*
     题目二:数组中唯一只出现一次的数字。
     
     在一个数组中除一个数字只出现一次之外,其他数字都出现了三次。
     请找出那个只出现一次的数字。
     
     分析：
     可惜这种思路不能解决这里的问题,因为三个相同的数字的异或结果还是该数字。尽管我们这里不能应用异或运算,我们还是可以沿用位运算的思路。如果一个数字出现三次,那么它的二进制表示的每一位(0或者1) 也出现三次。如果把所有出现三次的数字的二进制表示的每一位都分别加起来,那么每一位的和都能被3整除。
     我们把数组中所有数字的二进制表示的每一位都加起来。如果某一位的和能被3整除,那么那个只出现一次的数字二进制表示中对应的那一位是0:否则就是1。
     */
    struct Topic2 {
        static func findNumberOnlyAppearOnce(in  array: [Int]) -> Int? {
            guard array.count > 0 else {
                return nil
            }
            let size = MemoryLayout.size(ofValue: Int()) * 8
            var resultArray = Array(repeating: 0, count: size)
            array.forEach { value in
                var mask = 1
                
                /// ⚠️这里是从把最低位存在63，把最高位存在0
                for i in (0..<size).reversed() {
                    let bit = value & mask
                    //* & 不只是 0 1， 因为前面还有位
                    if bit != 0 {
                        resultArray[i] += 1
                    }
                    mask <<= 1
                }
            }
            
            var result = 0
            for i in 0..<size {
                /// ⚠️0是最高位
                result <<= 1
                result += resultArray[i] % 3
            }
            return result
        }
        
        static func test() {
            
            let a = [1, 1, 1, 2, 2, 2, 0]
            let b = [1, 1, 1, 2, 2, 2, 4]
            let c = [1, 1, 1, 2, 2, 2, -1]
            
            assert(findNumberOnlyAppearOnce(in: a) == 0)
            assert(findNumberOnlyAppearOnce(in: b) == 4)
            assert(findNumberOnlyAppearOnce(in: c) == -1)
            
            print("Topic56.Topic1 OVER")
        }
    }
}
