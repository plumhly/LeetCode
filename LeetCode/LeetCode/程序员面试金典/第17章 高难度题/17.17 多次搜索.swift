//
//  17.16 多次搜索.swift
//  算法
//
//  Created by Plum on 2021/7/2.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation
/*
 P493
 
 17.17多次搜索,给定一个字符串b和一个包含较短字符串的数组T,设计一个方法,根据T
 中的每一个较短字符串,对b进行搜索。(提示:#479,581,#616,#742)
 */

struct Interview_17_17 {
    
    struct Soluttion1 {
        static func searchAll(big: String, smalls: [String]) -> [String : [String.Index]]? {
            guard smalls.count > 0 else { return nil }
            
            var result: [String: [String.Index]] = [:]
            for item in smalls {
                if let indece = search(item: item, in: big) {
                    result[item] = indece
                }
            }
            
            return result
        }
        
        private static func search(item: String, in big: String) -> [String.Index]? {
            
            /// ⚠️此处为-item.count
            let endIndex = big.index(big.endIndex, offsetBy: -item.count)
            var result: [String.Index] = []
            for index in big.indices where index <= endIndex {
                
                let subEndIndex = big.index(index, offsetBy: item.count)
                let subString = String(big[index..<subEndIndex])
                if subString == item {
                    result.append(index)
                }
            }
            
            return result.count > 0 ? result : nil
        }
    }
    
    
    /// O(kt+bk),  k T中最长的字符串长度，t是T中元素个数，b是字符串长度
    struct Solution2 {
        
        class Trie {
         
            let root = TrieNode()
            
            func insert(value: String) {
                root.insert(string: value)
            }
        }
        
        class TrieNode {
            var nodes: [Character: TrieNode] = [:]
            
            private(set) var isTerminal = false
            
            func insert(string: String) {
                guard let c = string.first else {
                    return
                }
                
                var tempNode: TrieNode?
                if let node = nodes[c] {
                    tempNode = node
                } else {
                    tempNode = TrieNode()
                    nodes[c] = tempNode
                }
                
                let nextIndex = string.index(after: string.startIndex)
                if nextIndex < string.endIndex {
                    let subString = String(string[nextIndex...])
                    tempNode?.insert(string: subString)
                } else {
                    // ⚠️这里不是 isTerminal = true,
                    tempNode?.isTerminal = true
                }
            }
        }
        
        static func searchAll(big: String, smalls: [String]) -> [String : [String.Index]]? {
            guard smalls.count > 0 else { return nil }
            
            let trie = creatTrie(from: smalls)
            
            var result: [String : [String.Index]] = [:]
            for index in big.indices {
                let tempResult = findString(begin: index, string: big, trie: trie)
                tempResult.forEach { item in
                    if var array = result[item] {
                        array.append(index)
                        result[item] = array
                    } else {
                        result[item] = [index]
                    }
                }
            }
            
            
            return result
        }
        
        private static func creatTrie(from array: [String]) -> Trie {
            let trie = Trie()
            array.forEach { item in
                trie.insert(value: item)
            }
            
            return trie
        }
        
        private static func findString(begin: String.Index, string: String, trie: Trie) -> [String] {
            var index = begin
            let endIndex = string.endIndex
            var root = trie.root
            var result: [String] = []
            while index < endIndex {
                if let value = root.nodes[string[index]] {
                    if value.isTerminal {
                        result.append(String(string[begin...index]))
                    }
                    root = value
                    index = string.index(after: index)
                    continue
                }
                break
            }
            
            return result
        }
        
    }
    
    static func test() {
        
        let t = ["is", "ppi", "hi", "sis", "i", "ssippi"]
        let b = "mississippi"
        
        print(Soluttion1.searchAll(big: b, smalls: t))
        print(Solution2.searchAll(big: b, smalls: t))
        
        
        
        print("\(self) OVER")
    }
}
