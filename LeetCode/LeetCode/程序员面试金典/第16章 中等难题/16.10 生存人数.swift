//
//  16.10 生存人数.swift
//  算法
//
//  Created by Plum on 2021/6/8.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 16.10生存人数,给定一个列有出生年份和死年份的名,实现一个方法以计算生存人数最
 多的年份,你可以假设所有人都出生于1900年2000年(含1900和200)之间如果
 一个人在某一年的任意时期都处于生存状态,那么他们应该被纳人那一年的统计中,例
 如,生于1908年死于1909年的人应当被列人1908年和1909年的计数。
 */

struct Interview_16_10 {
    
    struct Person {
        let birth: Int
        let death: Int
    }
    
    /// 暴力法 时间复杂度 O(RP) R：年跨度，P 人数
    struct Solution1 {
        static func maxAliveYear(in people: [Person], minYear: Int, maxYear: Int) -> Int {
            guard !people.isEmpty else {
                return 0
            }
            
            var maxAliveYear = minYear
            var maxAliveCount = 0
            for year in minYear...maxYear {
                var aliveCount = 0
                for person in people {
                    if year >= person.birth && year <= person.death {
                        aliveCount += 1
                    }
                }
                
                if aliveCount > maxAliveCount {
                    maxAliveCount = aliveCount
                    maxAliveYear = year
                }
            }
            
            return maxAliveYear
        }
    }
    
    //O(Plog(P))P  人数
    struct Solution2 {
        static func maxAliveYear(in people: [Person], minYear: Int, maxYear: Int) -> Int {
            guard !people.isEmpty else {
                return 0
            }
            
            let birthYears = people.map {$0.birth}.sorted()
            let deathYears = people.map {$0.death}.sorted()
            
            // 这里只用遍历完出生数组，因为死亡年肯定有人数减少，不可能是人数最多的年
            var birthIndex = 0
            var deathIndex = 0
            var maxAliveYear = minYear
            var maxAliveCount = 0
            var currentAliveCount = 0
        
            while birthIndex < birthYears.count {
                if birthYears[birthIndex] <= deathYears[deathIndex] {
                    currentAliveCount += 1
                    if currentAliveCount > maxAliveCount {
                        maxAliveYear = birthYears[birthIndex]
                        maxAliveCount = currentAliveCount
                    }
                    
                    birthIndex += 1
                } else {
                    currentAliveCount -= 1
                    deathIndex += 1
                }
            }
            
            return maxAliveYear
        }
    }
    
    
    //O(R+P) R：年跨度，P 人数
    struct Solution3 {
        static func maxAliveYear(in people: [Person], minYear: Int, maxYear: Int) -> Int {
            guard !people.isEmpty else {
                return 0
            }
            
            let values = deal(people: people, minYear: minYear, maxYear: maxYear)
            let maxIndex = findMaxIndex(in: values)
            
            return maxIndex + minYear
        }
        
        private static func deal(people: [Person], minYear: Int, maxYear: Int) -> [Int] {
            var array = Array<Int>(repeating: 0, count: maxYear - minYear + 2)
            
            for person in people {
                let birthIndex = person.birth - minYear
                array[birthIndex] += 1
                
                
                let deathIndex = person.death - minYear
                array[deathIndex + 1] -= 1
            }
            
            return array
        }
        
        private static func findMaxIndex(in array: [Int]) -> Int {
            var maxAiveCount = 0
            var aliveCount = 0
            var maxIndex = 0
            for (index, value) in array.enumerated() {
                aliveCount += value
                if aliveCount > maxAiveCount {
                    maxAiveCount = aliveCount
                    maxIndex = index
                }
            }
            
            return maxIndex
        }
    }
    
    static func test() {
        let people = [
            Person(birth: 1900, death: 1980),
            Person(birth: 1900, death: 1981),
            Person(birth: 1900, death: 1982),
            Person(birth: 1900, death: 1983),
            Person(birth: 1900, death: 1984),
            Person(birth: 1900, death: 1985),
        ]
        
        do {
            
            assert(Solution1.maxAliveYear(in: people, minYear: 1900, maxYear: 2000) == 1900)
        }
        
        assert(Solution2.maxAliveYear(in: people, minYear: 1900, maxYear: 2000) == 1900)
        assert(Solution3.maxAliveYear(in: people, minYear: 1900, maxYear: 2000) == 1900)
        print("\(self) OVER")
    }
}
