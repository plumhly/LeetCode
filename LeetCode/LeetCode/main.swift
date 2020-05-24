//
//  main.swift
//  LeetCode
//
//  Created by Plum on 2020/5/23.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

print("Hello, World!")

//var number = 1
//for i in sequence(first: number, next: { value in
//    guard value < 10 else { return nil }
//    return number
//}) {
//    print("Loop: \(i)")
//}
//


func execute(description: String, block: () -> Void) {
    print("题目：\(description)")
    block()
}

var c = [5, 4, 3, 2, 1]
heapifySort(numbers: &c)
heapifySort(numbers: &c)
assert(c == [1, 2, 3, 4, 5])

var d = [3, 4, 3, 7, 1]
heapifySort(numbers: &d)
assert(d == [1, 3, 3, 4, 7])



execute(description: "数组中的重复元素") {
    let a = [2,3,1,0,2,5,3]
    let result = Topic1.depucateElement(in: a)
    assert(result.0)
    print(result.1)
}

execute(description: "数组中的任意一个") {
    let a = [2, 3, 5, 4, 3, 2, 6, 7]
    let result = Topic2.getDupicateElement(in: a)
    assert(result.0)
    print(result.1 == 3)
}
