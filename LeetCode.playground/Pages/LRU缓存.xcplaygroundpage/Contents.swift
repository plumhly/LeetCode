/*:

[上一页](@previous)

 # 描述
运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制。它应该支持以下操作： 获取数据 get 和 写入数据 put 。

获取数据 get(key) - 如果密钥 (key) 存在于缓存中，则获取密钥的值（总是正数），否则返回 -1。
写入数据 put(key, value) - 如果密钥不存在，则写入其数据值。当缓存容量达到上限时，它应该在写入新数据之前删除最近最少使用的数据值，从而为新的数据值留出空间。

### 示例:
       LRUCache cache = new LRUCache( 2 //缓存容量  );

       cache.put(1, 1);
       cache.put(2, 2);
       cache.get(1);       // 返回  1
       cache.put(3, 3);    // 该操作会使得密钥 2 作废
       cache.get(2);       // 返回 -1 (未找到)
       cache.put(4, 4);    // 该操作会使得密钥 1 作废
       cache.get(1);       // 返回 -1 (未找到)
       cache.get(3);       // 返回  3
       cache.get(4);       // 返回  4

[下一页](@next)
*/

import Foundation
import XCTest

var str = "Hello, playground"


//class LinkedMapTestCase: XCTestCase {
//
//    var Link
//    override func setUp() {
//
//    }
//
//    override func tearDown() {
//
//    }
//}
//
//
//class LrlTestCase: XCTestCase {
//
//    override class func setUp() {
//
//    }
//
//    override func tearDown() {
//
//    }
//}




class Node {
    var key: Int?
    var value: Int?
    var pre: Node?
    var next: Node?
    
    init(_ key: Int? = nil, _ value: Int? = nil) {
        self.key = key
        self.value = value
    }
}

class LinkedMap {
    let header: Node
    let trail: Node
    var map = [Int: Node]()
    var size: Int = 0
    
    init() {
        header = Node()
        trail = Node()
        header.next = trail
        trail.pre = header
    }
    
    func dropLast() -> Node? {
        
        guard size > 0  else { return nil }
        let node = trail.pre!
        node.pre?.next = trail
        trail.pre = node.pre
        
        map[(node.key)!] = nil
        
        size -= 1
        return node
    }
    
    func add(node: Node) {
        if let key = node.key, let node = map[key] {
            remove(node: node)
        }
        
        node.next = header.next
        header.next = node
        node.pre = header
        node.next?.pre = node
        
        map[(node.key)!] = node
        size += 1
    }
    
    func remove(node: Node) {
        size -= 1
        node.pre?.next = node.next
        node.next?.pre = node.pre
    }
}


class LRUCache {
    
    let capacity: Int
    let linkedMap = LinkedMap()
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        if let node = linkedMap.map[key] {
            linkedMap.add(node: node)
            return node.value!
        } else {
            return -1
        }
    }
    
    func put(_ key: Int, _ value: Int) {
        
        if let node = linkedMap.map[key] {
            node.value = value
            linkedMap.add(node: node)
        } else {
            let node = Node(key, value)
            
            if linkedMap.size < capacity {
                linkedMap.add(node: node)
            } else {
                let removedNode = linkedMap.dropLast()!
                linkedMap.map[removedNode.key!] = nil
                linkedMap.add(node: node)
            }
        }
    }
}

let cache = LRUCache(2)

cache.put(1, 2)
cache.put(2, 3)

cache.get(2)

cache.put(3, 4)
cache.get(1)


//["LRUCache","get","put","get","put","put","get","get"]
//[[2],

//"get","put","get","put","put","get","get"]
//[2],  [2,6], [1], [1,5], [1,2],[1],  [2]]
