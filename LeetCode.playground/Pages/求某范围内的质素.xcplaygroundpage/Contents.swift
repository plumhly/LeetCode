/*:

[上一页](@previous)

 # 描述
 筛选number范围内的质数

 
[下一页](@next)
*/

import Foundation


func allPrimeNumberTo(number: Int) -> [Int] {
    var isPrime: [Int: Bool] = [:]
    var allPrimeNumbers: [Int] = []
    
    for i in stride(from: 3, to: number, by: 2) {
        isPrime[i] = true
    }
    
    isPrime[2] = true
    
    var allPrime = 1
    allPrimeNumbers.append(2)
    for i in stride(from: 3, to: number, by: 2) {
        if isPrime[i]! {
            allPrimeNumbers.append(i)
            allPrime += 1
        }
        
        for j in 1 ..< allPrime where i * allPrimeNumbers[j] <= number {
            let value = allPrimeNumbers[j]
            isPrime[i * value] = false
            
            // 除了是最后一个数外，其他的情况是这个数不是质数，但是因为要通过它来把isPrime的所有和它是倍数关系的数设置为false
            /**
             欧式筛法的关键特别之处在于一条语句： if(i % prime[j] == 0)break; 这条语句保证了，每一个合数都只被筛除一次。为什么呢？由于  i % prime[i] == 0 ，那么如果继续筛下去，i * prime[j+1]一定也会是某一个合数，那么如果下一次判断这个合数的时候，它依然会被 prime[j] 筛掉。虽然prime[j+1] 也可以筛除它，不过它已经被prime[j]筛过了，prime[j+1]的筛除工作是多余的。
             */
            if i % value == 0 {
//                print("i: \(i), value: \(value) allnumerb: \(allPrimeNumbers)")
                break
            }
        }
        
    }
    return allPrimeNumbers
}

let before = CFAbsoluteTimeGetCurrent()
let number = allPrimeNumberTo(number: 10_000)
print(number.count)
print(CFAbsoluteTimeGetCurrent() - before)
