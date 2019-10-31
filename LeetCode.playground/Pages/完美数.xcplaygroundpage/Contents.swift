//: [Previous](@previous)

import Foundation
import UIKit


var str = "Hello, playground"

//: [Next](@next)

func checkPerfectNumber(_ num: Int) -> Bool {

    guard num != 1, num > 0 else {
        return false
    }
    var sum = 1
    let sqr = Int(sqrt(Double(num)))
   
    var low: Int
    var high: Int
    
    if sqr < 2 {
        low = sqr
        high = 2
    } else {
        low = 2
        high = sqr
    }
    
    for item in low...high {
        if num % item == 0 {
            sum += item + num / item
        }
    }

    if sqr * sqr == num {
        sum += sqr
    }

    return sum == num
}

checkPerfectNumber(28)

//let num = 3
//let sqr = Int(sqrt(3))
