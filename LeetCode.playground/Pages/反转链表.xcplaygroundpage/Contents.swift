/*:

[上一页](@previous)

# 描述
反转一个单链表。


### 示例:
       输入: 1->2->3->4->5->NULL
       输出: 5->4->3->2->1->NULL

[下一页](@next)
*/

import Foundation

var str = "Hello, playground"


public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init(_ val: Int) {
         self.val = val
         self.next = nil
     }
 }

extension ListNode : CustomStringConvertible {
    
    public var description: String {
        var node: ListNode? = self
        var results = [String]()
        while let temp = node {
            results.append("\(temp.val)")
            node = temp.next
        }
        return results.joined(separator: "->")
    }
}



// 迭代
//1->2->3->4->5->NULL
//func reverseList(_ head: ListNode?) -> ListNode? {
//    var node: ListNode? = head
//    var resultNode: ListNode?
//    while let temp = node {
//        if resultNode == nil {
//            resultNode = ListNode(temp.val)
//        } else {
//            let newNode = ListNode(temp.val)
//            newNode.next = resultNode
//            resultNode = newNode
//        }
//        node = temp.next
//    }
//    return resultNode
//}

// 递归
func reverseList(_ head: ListNode?) -> ListNode? {
    
    func reverseNode(_ head: ListNode?) -> (ListNode?, ListNode?) {
        guard let header = head, let next = head?.next else { return (head, head) }
        let new = ListNode(header.val)
        let (parent, son) = reverseNode(next)
//        print("parent:\(parent)")
//        print("son:\(son)")
        son?.next = new
        return (parent, new)
    }
    
    return reverseNode(head).0
}

func createNode(data: [Int]) -> ListNode? {
    var node: ListNode?
    var temp: ListNode?
    for value in data {
        if node == nil {
            node = ListNode(value)
            temp = node
        } else {
            temp?.next = ListNode(value)
            temp = temp?.next
        }
    }
    return node
}

var node1 = createNode(data: [1, 2, 3, 4, 5])
print(node1)

node1 = reverseList(node1)

print(node1)
