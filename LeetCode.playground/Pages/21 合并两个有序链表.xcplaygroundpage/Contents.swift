/*:

[上一页](@previous)

 # 描述
    将两个升序链表合并为一个新的升序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。

 
### 示例：
    输入：1->2->4, 1->3->4
    输出：1->1->2->3->4->4
        


[下一页](@next)
*/

import Foundation

public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init(_ val: Int) {
         self.val = val
         self.next = nil
     }
}



class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        guard l1 != nil else {
            return l2
        }
        
        guard l2 != nil else {
            return l1
        }
        
        
        // 都不为空
        var list: ListNode? = nil
        var tempList: ListNode? = nil
        
        var list1 = l1
        var list2 = l2

        while let tempL1 = list1, let tempL2 = list2 {
            if tempL1.val < tempL2.val {
                
                if list === nil {
                    list = ListNode(tempL1.val)
                    tempList = list
                } else {
                    tempList?.next = ListNode(tempL1.val)
                    tempList = tempList?.next
                }
                list1 = tempL1.next
            } else {
                if list === nil {
                    list = ListNode(tempL2.val)
                    tempList = list
                } else {
                    tempList?.next = ListNode(tempL2.val)
                    tempList = tempList?.next
                }
                list2 = tempL2.next
            }
        }
        
        if let temp = tempList {
            temp.next = list1 ?? list2
        }
        
        return list
    }
}
