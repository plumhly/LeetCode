/*:
 
 [上一页](@previous)
 
 # 描述
 给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。您可以假设除了数字 0 之外，这两个数都不会以 0 开头

 
 ### 示例:
        输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
        输出：7 -> 0 -> 8
        原因：342 + 465 = 807
 
 [下一页](@next)
 */

import Foundation

var str = "Hello, playground"

//: [Next](@next)

class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int, next:ListNode? = nil) {
        self.val = val
        self.next = next
    }
}

extension ListNode: CustomStringConvertible {
    var description: String {
        var numbers = [String]()
        var other: ListNode? = self
        while let next = other {
            numbers.append("\(next.val)")
            other = next.next
        }
        return numbers.joined(separator: "->")
    }
}


func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var first = l1
    var second = l2
    var node: ListNode?
    var tempNode: ListNode?
    var step = 0
    while first != nil || second != nil  {
        var sum = step
        if let first = first {
            sum += first.val
        }
        if let second = second {
            sum += second.val
        }
        
        let result = sum % 10
        
        if node == nil {
            node = ListNode(result)
            tempNode = node
        } else {
            tempNode?.next = ListNode(result)
            tempNode = tempNode?.next
        }
        step = sum / 10
        first = first?.next
        second = second?.next
    }
    
    if step > 0 {
        tempNode?.next = ListNode(step)
    }
    return node
}


let first = ListNode(1)
let second = ListNode(9, next: ListNode(9))

let result = addTwoNumbers(first, second)
print(result!)
