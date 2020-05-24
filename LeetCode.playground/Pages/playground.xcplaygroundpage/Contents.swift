//: [Previous](@previous)

import Foundation


var str = "Hello, playground"


func mesure(clousure: () -> Void) {
    let time = mach_absolute_time()
    clousure()
    let other = Float(mach_absolute_time() - time) / 1000_000.0
    print("execute time: \(other) ms")
}

//: [Next](@next)

// 走路
// d(i, j) = d(i, j-1) + d(i-1, j);
// d[4, 4] = d(4, 3) + d(3,4)
// d(4, 3) = d(4, 2) + d(3, 3)
// d(i, 0) = d(0, j) = 1



//var map: Dictionary<(Int, Int), Int>
//func step(i: Int, j: Int) -> Int {
//    if i == 0 || j == 0 {
//        return 1
//    }
//    return step(i: i, j: j - 1) + step(i: i - 1, j: j)
//}
//
//// 测试
//assert(step(i: 1, j: 1) == 2)
//assert(step(i: 2, j: 2) == 6)
//
//mesure {
//   let result = step(i: 4, j: 4)
//}

var num = false
//for i in sequence(first: 1, next: { value in
//    print("Closure")
//    print("\(num)")
//   return value < 10 ? 2 * value : nil
//}) {
//    num = !num
//    print("Loop: \(i)")
//}

for i in stride(from: 1, through: 0, by: -1) {
    print(i)
}
