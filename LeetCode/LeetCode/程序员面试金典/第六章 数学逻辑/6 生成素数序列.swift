//
//  6 生成素数序列.swift
//  算法
//
//  Created by Plum on 2021/2/21.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 欧拉算法相比埃氏筛法优秀在于，埃氏筛法会重复筛选！！！
 */

struct PrimeSequence {
    ///
    /// 时间复杂度：O(nloglogn)
    /// 它的核心思想是: sqrt(n)结束
    struct Eratrosthene {
        static func seqence(max: Int) -> [Int] {
            guard max >= 2 else {
                return []
            }
            
            var sequence = Array<Bool>(repeating: true, count: max + 1)
            sequence[0] = false
            sequence[1] = false
            
            var prime = 2
            while prime * prime <= max {
                change(flags: &sequence, currentPrime: prime)
                prime = nextPrime(flags: sequence, currentPrime: prime)
            }
            
            return sequence.enumerated().compactMap { (index, value) -> Int? in
                value ? index : nil
            }
        }
        
        private static func change(flags: inout [Bool], currentPrime: Int) {
            let begin = currentPrime * currentPrime
            for i in stride(from: begin, through: flags.count, by: currentPrime) {
                flags[i] = false
            }
        }
        
        private static func nextPrime(flags: [Bool], currentPrime: Int) -> Int {
            var index = currentPrime + 1
            while index < flags.count, !flags[index] {
                index += 1
            }
            return index
        }
    }
    
    /*
     可以在 O(n) 时间内完成对2~n的筛选。
     它的核心思想是：让每一个合数被其最小质因数筛到。每一个只筛选一次
     时间复杂度：O(n)
     */
    struct Euler {
        static func seqence(max: Int) -> [Int] {
            guard max >= 2 else {
                return []
            }
            
            var flags = Array<Bool>(repeating: true, count: max + 1)
            flags[0] = false
            flags[1] = false
            
            var primes: [Int] = []
            
            for i in 2...max {
                if flags[i] {
                    primes.append(i)
                }
                
                // j * i可能会超出范围
                for j in primes where j * i <= max {
                    flags[i * j] = false
                    /*
                     实际上，对于 x ，我们遍历到质数表中的 p ，且发现 x%p == 0 时，就应当停止遍历质数表。因为：设 x = pr(r >= p)（ p 本身是 x 的最小质因数），那么对于任意 p' > p ，有 p'x = pp'x = p(p'r) ，说明 p'x 的最小质因数不是 p' ，我们不应该在此划掉它。

                     这么说有点抽象，具体地说，如这里的2能整除4，则 4 = 2 x 2 ，那么对于任何大于2的质数 p ，都有 4p = 2 x 2p ，其中2是一个比 p 更小的质数，所以 4p 应该被2筛掉而不是被 p 筛掉。
                     */
                    if i % j == 0 {
                        break
                    }
                }
            }
            
            return primes
        }
    }
    
    static func test() {
        let a = [2, 3, 5, 7]
        assert(Eratrosthene.seqence(max: 10) == a)
        assert(Eratrosthene.seqence(max: 1) == [])
        
        assert(Euler.seqence(max: 10) == a)
        assert(Euler.seqence(max: 1) == [])
        print("PrimeSequence Over")
    }
}
