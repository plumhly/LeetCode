//
//  17.7 婴儿的名字.swift
//  算法
//
//  Created by Plum on 2021/6/17.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P460
 
 17.7婴儿名字。每年,政府都会公布一万个最常见的婴儿名字和它们出现的频率,也就是同名婴儿的数量。有些名字有多种拼法,例如,John和Jon本质上是相同的名字,但被当
 成了两个名字公布出来。给定两个列表,一个是名字及对应的频率,另一个是本质相同的名字对。设计一个算法打印出每个真实名字的实际解率,注意,如果John和Jon是相
 同的,并且Jon和Johnny相同,则John与Johnny也相同,即它们有传递性和对称性在结果列表中,任选一个名字做为真实名字就可以
 示例:
    输入:
        Names: John(15). Jon(12). Chris(13). Kris(4). Christopher(19)
        Synonyms: (Jon, John). (John. Johnny). (Chris. Kris). (Chris. Christopher)
 
    输出
        John(27). Kris(36)
 
 
 
 13恢复空格。哦,不!你不小心把一个长篇文章中的空格、标点都删掉了,并且大写也弄
 成了小写,像句子“ reset the computer. It still didn't' boot
 已经变成了

 */

struct Interview_17_7 {
    
    /// 时间复杂度 O(NlogN)
    struct Solution1 {
        
        class NameSet {
            let rootName: String
            private(set) var names: Set<String> = []
            private(set) var frequency: Int = 0
            
            var size: Int {
                return names.count
            }
            
            
            init(name: String, frequency: Int) {
                rootName = name
                self.frequency = frequency
                names.insert(name)
            }
            
            func copyData(from nameSet: NameSet) {
                names.formUnion(nameSet.names)
                frequency += nameSet.frequency
            }
            
        }
        
        static func findPopulationCount(values: [String: Int], namePair: [(String, String)]) -> [String: Int] {
            guard values.count > 0 else {
                return values
            }
            
            /// 构建name->nameset的字典
            var group = constructData(values: values)
            
            /// 根据同名列表合并数据
            merge(group: &group, with: namePair)
            
            /// 转换成 [String : Int]
            return convert(group: group)
        }
        
        private static func convert(group: [String: NameSet]) -> [String: Int] {
            var result: [String: Int] = [:]
            for item in group.values {
                result[item.rootName] = item.frequency
            }
            
            return result
        }
        
        private static func merge(group: inout [String: NameSet], with namePaire: [(String, String)]) {
            namePaire.forEach { name1, name2 in
                if let set1 = group[name1], let set2 = group[name2] {
                    let bigger = set1.size > set2.size ? set1 : set2
                    let smaller = set1.size > set2.size ? set2 : set1
                    
                    bigger.copyData(from: smaller)
                    
                    for name in smaller.names {
                        group[name] = bigger
                    }
                }
            }
        }
        
        private static func constructData(values: [String: Int]) -> [String: NameSet] {
            var result: [String: NameSet] = [:]
            
            for (key, value) in values {
                result[key] = NameSet(name: key, frequency: value)
            }
            
            return result
        }
    }
    
    struct Solution2 {
        
        class GraphNode {
            let name: String
            let frequency: Int
            
            var isVisited = false
            
            private(set) var neighbors: [GraphNode] = []
            private(set) var neighborDic: [String: GraphNode] = [:]
            
            init(name: String, frequency: Int) {
                self.name = name
                self.frequency = frequency
            }
            
            func add(neighbor: GraphNode) {
                guard neighborDic[neighbor.name] == nil else {
                    return
                }
                
                neighbors.append(neighbor)
                neighborDic[neighbor.name] = neighbor
            }
            
            func getFrequencyCount() -> Int {
                guard !isVisited else {
                    return 0
                }
                
                /// ⚠️要先赋值
                isVisited = true
                
                var count = frequency
                
                for node in neighbors {
                    count += node.getFrequencyCount()
                }
                
                return count
            }
        }
        
        
        /// 时间复杂度： O(B+P), B: 婴儿统计数，P: 同义名对数
        class Graph {
            private(set) var graphNodes: [GraphNode] = []
            private(set) var graphDic: [String: GraphNode] = [:]
            
            
            func addNode(name: String, frequency: Int) {
                guard graphDic[name] == nil else {
                    return
                }
                
                let node = GraphNode(name: name, frequency: frequency)
                graphNodes.append(node)
                graphDic[name] = node
                
            }
            
            func addEdge(startName: String, endName: String) {
                guard let node1 = graphDic[startName], let node2 = graphDic[endName] else {
                    return
                }
                
                node1.add(neighbor: node2)
                node2.add(neighbor: node1)
            }
        }
        
        
        static func findPopulationCount(values: [String: Int], namePair: [(String, String)]) -> [String: Int] {
            
            /// 构建图
            let graph = constructGraph(with: values)
            
            /// 链接边
            addEdge(to: graph, with: namePair)
            
            /// 深度遍历
            return iterate(graph: graph)
        }
        
        private static func constructGraph(with nameDic: [String: Int]) -> Graph {
            let graph = Graph()
            
            for (key, value) in nameDic {
                graph.addNode(name: key, frequency: value)
            }
            
            return graph
        }
        
        private static func addEdge(to graph: Graph, with namePaire: [(String, String)]) {
            for (name1, name2) in namePaire {
                graph.addEdge(startName: name1, endName: name2)
            }
        }
        
        private static func iterate(graph: Graph) -> [String: Int] {
            var result: [String: Int] = [:]
            
            for node in graph.graphNodes where !node.isVisited {
                let count = node.getFrequencyCount()
                result[node.name] = count
            }
            
            return result
        }
    }
    
    
    static func test() {
        
        let values = ["John": 15, "Jon": 12, "Chris": 13, "Kris": 4, "Christophper": 19]
        let namePaire = [("Jon", "John"), ("John", "Johnny"), ("Chris", "Kris"), ("Chris", "Christophper")]
        
        print(Solution1.findPopulationCount(values: values, namePair: namePaire))
        print(Solution2.findPopulationCount(values: values, namePair: namePaire))
        
        print("\(self) OVER")
    }
}
