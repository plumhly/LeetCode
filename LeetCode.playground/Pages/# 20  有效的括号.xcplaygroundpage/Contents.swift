/*:

[上一页](@previous)

 # 描述
    给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。
    有效字符串需满足：
        左括号必须用相同类型的右括号闭合。
        左括号必须以正确的顺序闭合。
    注意空字符串可被认为是有效字符串。

 
### 示例：
    输入: "()"
    输出: true

    输入: "()[]{}"
    输出: true

    输入: "(]"
    输出: false

    输入: "([)]"
    输出: false

    输入: "{[]}"
    输出: true

 
### 解题思路
    栈
 
[链接](https://leetcode-cn.com/problems/valid-parentheses)

[下一页](@next)
*/

import Foundation

class Solution {
    
    
    class Stack<E> {
        var result: [E] = []
        
        func pop() -> E? {
            return result.isEmpty ? nil : result.removeLast()
        }
        
        func push(val: E) {
            result.append(val)
        }
        
        var isEmpty: Bool {
            return result.isEmpty
        }
    }
    
    
    func isValid(_ s: String) -> Bool {
        
        if s.isEmpty {
            return true
        }
        let map: [Character: Character] = ["(": ")", "{": "}", "[": "]"]
        
        let stack = Stack<Character>()
        
        for key in s {
           if let _ = map[key] {
                stack.push(val: key)
            } else {
                guard let value = stack.pop(), let symbol = map[value], symbol == key else {
                    return false
                }
            }
        }
        return stack.isEmpty
    }
}





