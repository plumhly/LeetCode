//
//  面试题45-把数组排成最小的数.swift
//  LeetCode
//
//  Created by Plum on 2020/6/27.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation
/*
 面试题45:把数组排成最小的数
 
 P227
 
 
 
 */

struct Topic45 {
    static func minNumber(array: [Int]) -> String? {
        guard !array.isEmpty else {
            return nil
        }
        
        var strArray = array.map(String.init)
        strArray.sort { (str1, str2) -> Bool in
            let combination1 = str1 + str2
            let combination2 = str2 + str1
            return combination1.compare(combination2) == .orderedAscending
        }
        return strArray.joined()
    }
    
    static func test() {
        let a = [3, 32, 321]
        assert(minNumber(array: a) == "321323")
        
        let b = [5, 4, 3, 2, 1]
        assert(minNumber(array: b) == "12345")
        print("Topic45 OVER")
    }
}
