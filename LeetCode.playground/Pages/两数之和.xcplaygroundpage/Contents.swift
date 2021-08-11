/*:
 
 # 描述
 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
 你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

 
 ### 示例:
        给定 nums = [2, 7, 11, 15], target = 9
        因为 nums[0] + nums[1] = 2 + 7 = 9
        所以返回 [0, 1]
 
 [下一页](@next)
*/

import Foundation
import UIKit

var str = "Hello, playground"

func twoSum(numbers: [Int], target: Int) -> [Int] {
    var numberDic = [Int: Int]()
    for (index, num) in numbers.enumerated() {
        if let firstIndex = numberDic[target - num] {
            return [firstIndex, index]
        }
        numberDic[num] = index
    }
    fatalError("not fond")
}


let numbers = [2, 3, 6, 9, 7]
let target = 13

let result = twoSum(numbers: numbers, target: target)

let value = "0123456"
//print(value[value.startIndex...value.index(value.startIndex, offsetBy: 1)])
let index1 = value.index(after: value.startIndex)
//let index2 = value.index(after: value.startIndex)
//let dic = [index1: "1"]
//print(dic[index2])
print(value[value.startIndex...index1])

//floor(1.3)

do {
    let c1 = Character("0")
    let c2 = Character("0")
    print(c1 == c2)
}
