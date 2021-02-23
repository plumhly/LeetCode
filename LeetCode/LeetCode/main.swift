//
//  main.swift
//  LeetCode
//
//  Created by Plum on 2020/5/23.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

//print("Hello, World!")

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

//var c = [5, 4, 3, 2, 1]
//heapifySort(numbers: &c)
//heapifySort(numbers: &c)
//assert(c == [1, 2, 3, 4, 5])
//
//var d = [3, 4, 3, 7, 1]
//heapifySort(numbers: &d)
//assert(d == [1, 3, 3, 4, 7])



//execute(description: "数组中的重复元素") {
//    let a = [2,3,1,0,2,5,3]
//    let result = Topic1.depucateElement(in: a)
//    assert(result.0)
//    print(result.1)
//}
//
//execute(description: "数组中的任意一个") {
//    let a = [2, 3, 5, 4, 3, 2, 6, 7]
//    let result = Topic2.getDupicateElement(in: a)
//    assert(result.0)
//    print(result.1 == 3)
//}

/****************5.25****************/
// 快速排序

struct Fast {
   static func quickSort(numbers:  inout [Int]) {
        guard numbers.count > 2 else {
            return
        }
        
        _quickSort(numbers: &numbers, start: 0, end: numbers.count - 1)
    }
    
   static func _quickSort(numbers:  inout [Int], start: Int, end: Int) {
        guard start < end else {
            return
        }
        var tempStart = start
        var tempEnd = end
        let value = numbers[start]
        
        while tempStart < tempEnd {
            
            while numbers[tempEnd] > value, tempStart < tempEnd {
                tempEnd -= 1
            }
            numbers[tempStart] = numbers[tempEnd]
            
            while numbers[tempStart] < value, tempStart < tempEnd {
                tempStart += 1
            }
             numbers[tempEnd] = numbers[tempStart]
        }
        
        numbers[tempStart] = value
        
        _quickSort(numbers: &numbers, start: 0, end: tempEnd - 1)
        _quickSort(numbers: &numbers, start: tempEnd + 1, end: end)
    }
}


//interview4_test()

//Exercise.E5_26.Fast.test()
//Exercise.E5_26.Merge.test()
//Exercise.E5_26.Heap.test()
//StringOperation.test()

//Exercise.E5_28.Fast.test()
//Exercise.E5_28.Topic2.test()
//Topic6.test()

//Tree.preorderTest()
//Tree.inorderTest()
//Tree.postOrderTest()
//Tree.levelTest()

//Topic7.test()
//Topic8.test()

//Exercise.E6_1.Preoder.test()
//Exercise.E6_1.Inorder.test()
//Exercise.E6_1.PostOrder.test()
//Exercise.E6_1.Level.test()

//Exercise.E6_2.Preorder.test()
//Exercise.E6_2.Inorder.test()
//Exercise.E6_2.Postorder.test()

//Topic9.test()
//Topic10.test()
//Topic10.timeTest()

//Exercise.E6_4.Fibonacci.test()

//func insert(numbers: inout [Int]) {
//    guard numbers.count > 1 else { return }
//    for i in 1..<numbers.count {
//        let temp = numbers[i]
//        var currentIndex = i - 1
//        while numbers[currentIndex] > temp && currentIndex >= 0 {
//            numbers[currentIndex + 1] = numbers[currentIndex]
//            currentIndex -= 1
//        }
//        numbers[currentIndex + 1] = temp
//    }
//}
//
//var a = [4, 3, 2, 1]
//insert(numbers: &a)
//print(a)
//assert(a == [1, 2, 3, 4])

//Topic11.test()
//Topic12.test()
//Topic13.test()
//Topic14.test()
//Topic15.test()
//Topic16.test()
//CPlus.test()
//Topic17.test()

//Exercise.E6_11.test()
//Topic18.test()
//Topic19.test()
//StringOperation.testReg()

//Topic20.test()
//StringOperation.testNumber()
//Topic21.test()
//Topic22.test()
//Topic22.test2()
//Topic23.test()
//Topic24.test()
//Topic25.test()
//Exercise.E6_16.test()
//Topic26.test()
//Topic27.test()
//Exercise.E6_17.test()
//Topic28.test()
//Topic29.test()
//Exercise.E6_19.test()
//Topic30.test()
//Topic31.test()
//Exercise.E6_21.test()
//Topic32.test()
//Topic33.test()
//Topic34.test()
//Topic35.test()
//Topic36.test()
//Topic37.test()
//Exercise.E6_24.testBST()
//StringOperation.testPrintString()
//Topic38.test()
//Topic39.Solution2.test()
//Topic40.test()
//Topic42.test()
//Topic43.test()
//Exercise.E6_27.test()
//Topic44.test()
//Topic45.test()
//Exercise.E6_28.test()
//Topic46.test()
//Exercise.E6_29.test()
//Topic47.test()
//Exercise.E_30.test()
//Topic48.test()
//Topic49.test()
//Topic50.Topic2.test()
//Topic51.test()
//Exercise.E7_02.test()
//Topic52.test()
//Exercise.E7_03.test()
//Topic53.Topic1.test()
//Topic53.Topic2.test()
//Topic53.Topic3.test()
//Topic54.test()
//Topic55.Topic1.test()
//Topic55.Topic2.test()
//Topic56.Topic1.test()
//Topic56.Topic2.test()
//Topic57.Topic1.test()
//Topic57.Topic2.test()
//Topic58.test()
//Topic59.Topic1.test()
//Topic59.Topic2.test()
//Topic60.Solution1.test()
//Topic60.test()
//Topic61.test()
//Exercise.E7_09.test()
//Topic62.Solution1.test()
//Topic62.Solution2.test()
//Topic63.test()
//Topic64.Solution1.test()
//Topic65.test()
//Topic66.test()
//Topic67.test()
//Topic68.test()
//Test.testMaxPriorityQueue()
//Interview_1_1.test()
//BitMap.test()

//Interview_1_2.test()
//Interview_1_4.test()
//Interview_1_5.test()
//Interview_1_6.test()
//Interview_1_7.test()
//Interview_1_8.test()
//Interview_1_9.test()
//Interview_2_1.test()
//InterView_2_2.test()
//Interview_2_3.test()
//Interview_2_4.test()
//Interview_2_5.test()
//Interview_2_6.test()
//Interview_2_7.test()
Interview_2_8.test()
PrimeSequence.test()
