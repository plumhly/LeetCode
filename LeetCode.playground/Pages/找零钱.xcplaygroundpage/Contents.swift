/*:

[上一页](@previous)

 # 描述
    假设有25，20，5，1面值的硬币，现在要找给用户41分，如何办到硬币个数最少？

 
### 解题思路
    分解问题：
        如果 结果为 d(n)
        如果第一次跨找25分，那么后面有 d(n) = d(n-25) + 1
        如果第一次跨找20分，那么后面有 d(n) = d(n-20) + 1
        如果第一次跨找5分，那么后面有 d(n) = d(n-5) + 1
        如果第一次跨找1分，那么后面有 d(n) = d(n-1) + 1


[下一页](@next)
*/

import Foundation

func conins(n: Int, faces: [Int]) -> Int? {
    guard n > 0, !faces.isEmpty else {
        return nil
    }
    
    var dp: [Int?] = Array(repeating: 0, count: n + 1)
    for i in 1...n {
        var min = Int.max
        for face in faces {
            if i < face { continue }
            if let value = dp[i - face], value < min {
                min = value
            }
        }
        
        if min == Int.max {
            dp[i] = nil
        } else {
            dp[i] = min + 1
        }
    }
    return dp[n]
}
