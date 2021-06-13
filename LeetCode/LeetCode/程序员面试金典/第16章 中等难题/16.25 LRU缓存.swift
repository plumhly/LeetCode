//
//  16.25 URL缓存.swift
//  算法
//
//  Created by Plum on 2021/6/13.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P442
 
 16.25LRU缓存。设计和构建一个“最近最少使用”缓存,该缓存会删除最近最少使用的项目。缓存应该从键映射到值(允许你插入和检索特定键对应的值),并在初始化时指定最大容量。
 当缓存被填满时,它应该删除最近最少使用的项目。
 (提示:#523,#629,#693)
 
 
 */

struct Interview_16_25 {
    
    
    struct Solution {
        
        struct Cache : CustomStringConvertible {
            class ListNode {
                var pre: ListNode?
                var next: ListNode?
                let key: String
                let value: Int
                
                init(key: String, value: Int) {
                    self.key = key
                    self.value = value
                }
            }
          
            var map: [String: ListNode] = [:]
            
            var head: ListNode?
            var tail: ListNode?
            
            let catchSize: Int
            
            init(cacheSize: Int) {
                self.catchSize = cacheSize
            }
            
            //访问元素
            mutating
            func getValue(with key: String) -> Int? {
                guard let node = map[key] else {
                    return nil
                }
                
                // 将它放在头部
                removeLink(node: node)
                insertHead(node: node)
                
                return node.value
            }
            
            // 插入元素
            mutating
            func set(key: String, value: Int) {
                remove(key: key)
                
                /// 检查size
                if catchSize <= map.count {
                    /// 移除最近最少使用
                    removeLast()
                }
                
                let node = ListNode(key: key, value: value)
                insertHead(node: node)
                map[key] = node
                
            }
            
            mutating
            func removeLast() {
                if let tail = tail {
                    let preNode = tail.pre
                    
                    // 断线
                    tail.pre?.next = nil
                    tail.pre = nil
                    
                    remove(key: tail.key)
                    
                    self.tail = preNode
                    
                    // 表明head == tail
                    if self.tail == nil {
                        head = nil
                    }
                }
            }
            
        
            mutating
            func remove(key: String) {
                guard let node = map[key] else {
                    return
                }
                
                removeLink(node: node)
                map.removeValue(forKey: key)
            }
            
            mutating
            func removeLink(node: ListNode) {
                
                // ⚠️移除注意判断是否是头结点和尾节点
                // ⚠️ 可能该Node同时是Head和Tail
                // 断掉指向该Node的线
                if node.pre != nil {
                    node.next?.next = node.next
                }
                
                if node.next != nil {
                    node.next?.pre = node.pre
                }
                
                if node.key == head?.key {
                    head = node.next
                }
                
                if node.key == tail?.key {
                    tail = node.pre
                }
            }
            
            mutating
            func insertHead(node: ListNode) {
                if let head = head {
                    head.pre = node
                    node.next = head
                    self.head = node
                } else {
                    self.head = node
                    self.tail = node
                }
            }
            
            var description: String {
                var st = ""
                var head = self.head
                while head != nil  {
                    st.append("\(head!.value) ->")
                    head = head?.next
                }
                
                return st
            }
        }
    }
    
    static func test() {
        
        
        var cache = Solution.Cache(cacheSize: 3)
        
        cache.set(key: "1", value: 1)
        cache.set(key: "2", value: 2)
        cache.set(key: "3", value: 3)
        
        cache.getValue(with: "1")
        cache.set(key: "4", value: 4)
        print(cache)
        
        cache.set(key: "5", value: 5)
        print(cache)
        
        print("\(self) OVER")
    }
}
