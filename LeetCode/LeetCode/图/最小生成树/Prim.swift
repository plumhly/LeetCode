//
//  Prime.swift
//  LeetCode
//
//  Created by Plum on 2020/7/15.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

struct Graph {
    var vertexs: [Vertex] = []
    var edges: [Edge] = []
    
    mutating func add(vertex: Vertex) {
        vertexs.append(vertex)
    }
    
    mutating func add(edge: Edge) {
        edges.append(edge)
    }
}

class Vertex: NSObject {
    let key: String
    
    init(key: String) {
        self.key = key
        super.init()
    }
}

class Edge: NSObject {
    let start: Vertex
    let end: Vertex
    let weight: Int
    
    init(start: Vertex, end: Vertex, weight: Int) {
        self.start = start
        self.end = end
        self.weight = weight
        super.init()
    }
}


// prim
//extension Graph {
//    func prim() -> [Edge]? {
//        guard vertexs.count > 1 else {
//            return nil
//        }
//        
//        var resultEdges: [Edge] = []
//        var newVetexs: [Vertex] = []
//        newVetexs.append(vertexs[0])
//        
//        for v in vertexs {
//            for newV in newVetexs {
//                for e in edges {
//                    
//                }
//            }
//        }
//    }
//}
