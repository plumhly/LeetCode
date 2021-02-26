//
//  6.7 大灾难.swift
//  算法
//
//  Created by Plum on 2021/2/25.
//  Copyright © 2021 Plum. All rights reserved.
//


/*
 大灾难。在大灾难后的新世界，世界女王非常关心出生率。因此，她规定所有家庭都必
 须有一个女孩，否则将面临巨额罚款。如果所有的家庭都遵守这个政策－所有家庭在
 得到一个女孩之前不断生育，生了女孩之后立即停止生育－那么新一代的性别比例是
 多少（假设每次怀孕后生男生女的概率是相等的）？通过逻辑推理解决这个问题，然后
 使用计算机进行模拟。
 */

/*
 答案：50%, 之前的出生不会印象后面出生性别的概率
 */

import Foundation

struct Generation {
    static func generaion(with familly: Int) -> Double {
        guard familly > 0 else {
            return 0
        }
        
        var totalG = 0
        var totalB = 0
        for _ in 1...familly {
            let result = simulateGenerate()
            totalG += result.g
            totalB += result.b
        }
        return Double(totalG) / Double(totalB + totalG)
    }
    
    static func simulateGenerate() -> (g: Int, b: Int) {
        var boys = 0
        var girls = 0
        while girls == 0 {
            Bool.random() ? (girls += 1) : (boys += 1)
        }
        return (girls, boys)
    }
}


