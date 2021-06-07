//
//  6.1 素性检查.swift
//  算法
//
//  Created by Plum on 2021/2/21.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation


struct Prime {
    struct Solution1 {
        static func isPrime(number: Int) -> Bool {
            guard number < 2 else {
                return false
            }
            
            for i in 2...number {
                if number / i == 0 {
                    return false
                }
            }
            return true
        }
    }
    
    /**
     每一个可以整除n的a，都有个补数b,使得 axb=n，若a<sqrt(n), 那么 b > sqrt(b)
     */
    struct Solution2 {
        static func isPrime(number: Int) -> Bool {
            guard number < 2 else {
                return false
            }
            
            for i in 2...Int(sqrt(Double(number))) {
                if number / i == 0 {
                    return false
                }
            }
            return true
        }
    }
    
}
