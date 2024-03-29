//
//  Exercise.swift
//  LeetCode
//
//  Created by Plum on 2020/5/25.
//  Copyright © 2020 Plum. All rights reserved.
//

import Foundation

struct Exercise {
    struct E5_25 {
        struct Fast {
           static func quickSort(numbers:  inout [Int]) {
                guard numbers.count > 2 else {
                    return
                }
                
                _quickSort(numbers: &numbers, start: 0, end: numbers.count - 1)
            }
            
           static func _quickSort(numbers:  inout [Int], start: Int, end: Int) {
                guard start < end else {
                    return
                }
                var tempStart = start
                var tempEnd = end
                let value = numbers[start]
                
                while tempStart < tempEnd {
                    
                    while numbers[tempEnd] > value, tempStart < tempEnd {
                        tempEnd -= 1
                    }
                    numbers[tempStart] = numbers[tempEnd]
                    
                    while numbers[tempStart] < value, tempStart < tempEnd {
                        tempStart += 1
                    }
                     numbers[tempEnd] = numbers[tempStart]
                }
                
                numbers[tempStart] = value
                
                _quickSort(numbers: &numbers, start: 0, end: tempEnd - 1)
                _quickSort(numbers: &numbers, start: tempEnd + 1, end: end)
            }
            
            static func test() {
                var cd: [Int] = []
                Fast.quickSort(numbers: &cd)
                assert(cd == [])


                var b = [1]
                Fast.quickSort(numbers: &b)
                assert(b == [1])


                var a = [4, 3, 2, 1]
                Fast.quickSort(numbers: &a)
                assert(a == [1, 2, 3, 4])
            }
        }
    }
}

extension Exercise {
    struct E5_26 {
        struct Fast {
            static func quickSort(numbers: inout [Int]) {
                guard numbers.count > 1 else {
                    return
                }
                
                _quickSort(numbers: &numbers, start: 0, end: numbers.count - 1)
            }
            
            static func _quickSort(numbers: inout [Int], start: Int, end: Int) {
                guard start < end else {
                    return
                }
                var i = start
                var j = end
                let value = numbers[start]
                while i < j {
                    // 比较要完整，包含 >=<
                    while i < j, numbers[j] >= value {
                        j -= 1
                    }
                    numbers[i] = numbers[j]
                    while i < j, numbers[i] < value {
                        i += 1
                    }
                    numbers[j] = numbers[i]
                }
                numbers[i] = value
                
                _quickSort(numbers: &numbers, start: start, end: i - 1)
                _quickSort(numbers: &numbers, start: i + 1, end: end)
            }
            
            static func test() {
                var t1: [Int] = []
                E5_26.Fast.quickSort(numbers: &t1)
                assert(t1 == [])
                
                var t2: [Int] = [1]
                E5_26.Fast.quickSort(numbers: &t2)
                assert(t2 == [1])
                
                var t3: [Int] = [5, 4, 3, 2, 1]
                E5_26.Fast.quickSort(numbers: &t3)
                assert(t3 == [1, 2, 3, 4, 5])
                
                var t4: [Int] = [5, 4, 1, 3, 2, 1]
                E5_26.Fast.quickSort(numbers: &t4)
                assert(t4 == [1, 1, 2, 3, 4, 5])
                print("OVER")
            }
        }
        
        struct Merge {
            static func mergeSort(numbers: inout [Int]) {
                guard numbers.count > 1 else {
                    return
                }
                
                _mergeSort(numbers: &numbers, start: 0, end: numbers.count - 1, result: NSMutableArray())
            }
            
            static func _mergeSort(numbers: inout [Int], start: Int, end: Int, result: NSMutableArray) {
                guard start < end else {
                    return
                }
                
                let middle = (start + end) >> 1
                
                var start1 = start
                let end1 = middle
                
                var start2 = middle + 1
                let end2 = end
                
                _mergeSort(numbers: &numbers, start: start1, end: end1, result: result)
                _mergeSort(numbers: &numbers, start: start2, end: end2, result: result)
                
                // 合并
                result.removeAllObjects()
                
                while start1 <= end1, start2 <= end2 {
                    if numbers[start1] < numbers[start2] {
                        result.add(numbers[start1])
                        start1 += 1
                    } else {
                        result.add(numbers[start2])
                        start2 += 1
                    }
                }
                
                while start1 <= end1 {
                    result.add(numbers[start1])
                    start1 += 1
                }
                
                while start2 <= end2 {
                    result.add(numbers[start2])
                    start2 += 1
                }
                
                numbers.replaceSubrange(start...end, with: result as! [Int])
            }
            
            static func test() {
                var t1: [Int] = []
                E5_26.Merge.mergeSort(numbers: &t1)
                assert(t1 == [])
                
                var t2: [Int] = [1]
                E5_26.Merge.mergeSort(numbers: &t2)
                assert(t2 == [1])
                
                var t3: [Int] = [5, 4, 3, 2, 1]
                E5_26.Merge.mergeSort(numbers: &t3)
                assert(t3 == [1, 2, 3, 4, 5])
                
                var t4: [Int] = [5, 4, 1, 3, 2, 1]
                E5_26.Merge.mergeSort(numbers: &t4)
                assert(t4 == [1, 1, 2, 3, 4, 5])
                
                print("OVER")
            }
            
        }
        
        struct Heap {
            static func maxHeapSort(numbers: inout [Int]) {
                buildMaxHeap(numbers: &numbers)
                
                for i in stride(from: numbers.count - 1, through: 0, by: -1) {
                    let temp = numbers[0]
                    numbers[0] = numbers[i]
                    numbers[i] = temp
                    heapify(numbers: &numbers, node: 0, lastIndex: i)
                }
                
            }
            
            static func buildMaxHeap(numbers: inout [Int]) {
                let lastParentNode = (numbers.count - 1 - 1) / 2
                for i in stride(from: lastParentNode, through: 0, by: -1) {
                    heapify(numbers: &numbers, node: i, lastIndex: numbers.count - 1)
                }
            }
            
            static func heapify(numbers: inout [Int], node: Int, lastIndex: Int) {
                guard 2 * node + 1 < lastIndex else { return }
                let leftNode = 2 * node + 1
                let rightNode = 2 * node + 2
                var largeNode = node
                
                if leftNode < lastIndex, numbers[leftNode] > numbers[largeNode] {
                    largeNode = leftNode
                }
                
                if rightNode < lastIndex, numbers[rightNode] > numbers[largeNode] {
                    largeNode = rightNode
                }
                
                if largeNode != node {
                    let temp = numbers[node]
                    numbers[node] = numbers[largeNode]
                    numbers[largeNode] = temp
                    
                    heapify(numbers: &numbers, node: largeNode, lastIndex: lastIndex)
                }
                
            }
            
            static func test() {
                var t1: [Int] = []
                E5_26.Heap.maxHeapSort(numbers: &t1)
                assert(t1 == [])
                
                var t2: [Int] = [1]
                E5_26.Heap.maxHeapSort(numbers: &t2)
                assert(t2 == [1])
                
                var t3: [Int] = [5, 4, 3, 2, 1]
                E5_26.Heap.maxHeapSort(numbers: &t3)
                assert(t3 == [1, 2, 3, 4, 5])
                
                var t4: [Int] = [5, 4, 1, 3, 2, 1]
                E5_26.Heap.maxHeapSort(numbers: &t4)
                assert(t4 == [1, 1, 2, 3, 4, 5])
                
                print("OVER")
            }
        }
    }
}


extension Exercise {
    struct E5_28 {
        struct Fast {
            static func quickSort(numbers: inout [Int]) {
                _quickSort(numbers: &numbers, start: 0, end: numbers.count - 1)
            }
            
            static func _quickSort(numbers: inout [Int], start: Int, end: Int) {
                guard start < end else {
                    return
                }
                
                var i = start
                var j = end
                let value = numbers[i]
                
                while i < j {
                    while i < j, numbers[j] >= value {
                        j -= 1
                    }
                    numbers[i] = numbers[j]
                    
                    while i < j, numbers[i] < value {
                        i += 1
                    }
                    numbers[j] = numbers[i]
                }
                
                _quickSort(numbers: &numbers, start: start, end: i)
                _quickSort(numbers: &numbers, start: i + 1, end: end)
            }
            
            static func test() {
                var t1: [Int] = []
                E5_26.Fast.quickSort(numbers: &t1)
                assert(t1 == [])
                
                var t2: [Int] = [1]
                E5_26.Fast.quickSort(numbers: &t2)
                assert(t2 == [1])
                
                var t3: [Int] = [5, 4, 3, 2, 1]
                E5_26.Fast.quickSort(numbers: &t3)
                assert(t3 == [1, 2, 3, 4, 5])
                
                var t4: [Int] = [5, 4, 1, 3, 2, 1]
                E5_26.Fast.quickSort(numbers: &t4)
                assert(t4 == [1, 1, 2, 3, 4, 5])
                print("OVER")
            }
        }
        
        struct Topic2 {
            static func findDupliacte(numbers: [Int]) -> Int? {
                guard !numbers.isEmpty else {
                    return nil
                }
                
                for i in numbers {
                    if i < 0 || i > numbers.count - 1 {
                        return nil
                    }
                }
                
                
                var start = 1
                var end = numbers.count - 1
                
                while start < end {
                    let middle = (start + end) >> 1
                    let count = self.count(numbers: numbers, value: middle)
                    if count > middle {
                        end = middle
                    } else {
                        start = middle + 1
                    }
                }
                return start
            }
            
            static func count(numbers: [Int], value: Int) -> Int {
                return numbers.filter { $0 <= value }.count
            }
            
            static func test() {
                let a = [2, 3, 5, 4, 3, 2, 6, 7]
                let result = Topic2.findDupliacte(numbers: a)
                assert(result != nil)
                print(result!)
            }
        }
        
    }
}


extension Exercise {
    struct E6_1 {
        struct Preoder {
           static func traversal(tree: Tree?) -> [Int]? {
                guard tree != nil else {
                    return nil
                }
                
                var tempTree = tree
                var stack = Stack<Tree>()
                var result: [Int] = []
                while tempTree != nil || !stack.isEmpty {
                    
                    if let t = tempTree {
                        result.append(t.value)
                        if let right = tempTree?.right {
                            stack.push(value: right)
                        }
                        tempTree = tempTree?.left
                    } else {
                        tempTree = stack.pop()
                    }
                    
                }
                return result
            }
            
            static func test() {
                let tree = traversalTree()
                let result = traversal(tree: tree)
                assert(result == [10, 6, 4, 8, 14, 12, 16])
                print("Preoder OVER")
            }
        }
        
        struct Inorder {
            static func traversal(tree: Tree?) -> [Int]? {
                guard tree != nil else {
                    return nil
                }
                
                var stack = Stack<Tree>()
                var tempTree = tree
                var result: [Int] = []
                while tempTree != nil || !stack.isEmpty {
                    if let t = tempTree {
                        stack.push(value: t)
                        tempTree = tempTree?.left
                    } else {
                        tempTree = stack.pop()
                        if let t = tempTree {
                            result.append(t.value)
                        }
                        tempTree = tempTree?.right
                    }
                }
                return result
            }
            
            static func test() {
                let tree = traversalTree()
                let result = traversal(tree: tree)
                assert(result == [4, 6, 8, 10, 12, 14, 16])
                print("Inorder OVER")
            }
        }
        
        struct PostOrder {
            static func traversal(tree: Tree?) -> [Int]? {
                guard tree != nil else {
                    return nil
                }
                
                var result: [Int] = []
                var stack = Stack<Tree>()
                var tempTree = tree
                var pre: Tree? = nil
                
                while tempTree != nil || !stack.isEmpty {
                    if let t = tempTree {
                        stack.push(value: t)
                        tempTree = t.left
                    } else {
                        let tree = stack.peek()
                        if let r = tree?.right, pre != r {
                            //pre != r
                            tempTree = tree?.right
                        } else {
                            // 右子树为空 || pre == r
                            result.append(tree!.value)
                            let _ = stack.pop()
                            tempTree = nil
                            pre = tree
                        }
                    }
                }
                
                return result
                
            }
            
            static func test() {
                let tree = traversalTree()
                let result = traversal(tree: tree)
                assert(result == [4, 8, 6, 12, 16, 14, 10])
                print("PostOrder OVER")
            }
        }
        
        struct Level {
            static func traversal(tree: Tree?) -> [Int]? {
                guard let tree = tree else {
                    return nil
                }
                
                var result: [Int] = []
                var queue = MyQueue<Tree>()
                queue.enqueue(element: tree)
                while !queue.isEmpty {
                    if let tree = queue.dequeue() {
                        result.append(tree.value)
                        if let l = tree.left {
                            queue.enqueue(element: l)
                        }
                        if let r = tree.right {
                            queue.enqueue(element: r)
                        }
                    }
                }
                return result
            }
            
            static func test() {
                let tree = traversalTree()
                let result = traversal(tree: tree)
                assert(result == [10, 6, 14, 4, 8, 12, 16])
                print("Level OVER")
            }
        }
    }
    
}

extension Exercise {
    struct E6_2 {
        struct Preorder {
            static func traversal(tree: Tree?) -> [Int]? {
                guard tree != nil else {
                    return nil
                }
                
                var stack = Stack<Tree>()
                var tempTree = tree
                var result: [Int] = []
                while tempTree != nil || !stack.isEmpty {
                    if let t = tempTree {
                        result.append(t.value)
                        if let r = tempTree?.right {
                            stack.push(value: r)
                        }
                        tempTree = tempTree?.left
                    } else {
                        tempTree = stack.pop()
                    }
                }
                
                return result
            }
            
            static func test() {
                let tree = traversalTree()
                let result = traversal(tree: tree)
                assert(result == [10, 6, 4, 8, 14, 12, 16])
                print("Preoder OVER")
            }
        }
        
        
        struct Inorder {
            static func traversal(tree: Tree?) -> [Int]? {
                guard tree != nil else {
                    return nil
                }
                
                var stack = Stack<Tree>()
                var tempTree = tree
                var result: [Int] = []
                while tempTree != nil || !stack.isEmpty {
                    if let t = tempTree {
                        stack.push(value: t)
                        tempTree = t.left
                    } else {
                        let tree = stack.pop()
                        if let t = tree {
                            result.append(t.value)
                        }
                        tempTree = tree?.right
                    }
                }
                return result
            }
            
            static func test() {
                let tree = traversalTree()
                let result = traversal(tree: tree)
                assert(result == [4, 6, 8, 10, 12, 14, 16])
                print("Inorder OVER")
            }
        }
        
        
        struct Postorder {
            static func traversal(tree: Tree?) -> [Int]? {
                guard tree != nil else {
                    return nil
                }
                
                var stack = Stack<Tree>()
                var tempTree = tree
                var result: [Int] = []
                var pre: Tree?
                
                while tempTree != nil || !stack.isEmpty {
                    if let t = tempTree {
                        stack.push(value: t)
                        tempTree = t.left
                    } else {
                        let tree = stack.peek()
                        if let r = tree?.right, r != pre {
                            tempTree = r
                        } else {
                            let _ = stack.pop()
                            result.append(tree!.value)
                            pre = tree
                            tempTree = nil
                        }
                    }
                }
                
                return result
            }
            
            static func test() {
                let tree = traversalTree()
                let result = traversal(tree: tree)
                assert(result == [4, 8, 6, 12, 16, 14, 10])
                print("PostOrder OVER")
            }
        }
    }
}

extension Exercise {
    struct E6_4 {
        struct Fibonacci {
            static func fib_iterate(_ n: Int) -> Int {
                if n < 2 {
                    return n
                }
                
                var first = 0
                var second = 1
                for _ in 2...n {
                    second = second + first
                    first = second - first
                }
                return second
            }
            
            static func fib_recursive(_ n: Int) -> Int {
                return _fib_recursive(n)
            }
            
            static func _fib_recursive(_ n: Int, f0: Int = 0, f1: Int = 1) -> Int {
                if n == 0 {
                    return f0
                }
                return _fib_recursive(n - 1, f0: f0 + f1, f1: f0)
            }
            
            static func fib_format(_ n: Int) -> Int {
                let a = sqrt(5)
                return Int((pow(((1 + a) / 2), Double(n)) -  pow(((1 - a) / 2), Double(n))) / a)
            }
            
            static func test() {
                assert(fib_iterate(0) == 0)
                assert(fib_iterate(1) == 1)
                assert(fib_iterate(5) == 5)
                
                assert(fib_recursive(0) == 0)
                assert(fib_recursive(1) == 1)
                assert(fib_recursive(5) == 5)
                
                assert(fib_format(0) == 0)
                assert(fib_format(1) == 1)
                assert(fib_format(5) == 5)
                
                print("E6_4 Fibonacci OVER")
            }
        }
    }
}

extension Exercise {
    struct E6_11 {
        
        static let zeroAssi = ("0" as Character).asciiValue!
        static func printMaxNumber(n: Int) {
            guard n > 0 else { return }
            var result = Array<Character>(repeating: "0", count: n)
            for i in 0..<10 {
                // 最高位
                result[0] = Character(UnicodeScalar(zeroAssi + UInt8(i)))
                printNumber(result: &result, length: n, index: 0)
            }
        }
        
        static func printNumber(result: inout [Character], length: Int, index: Int) {
            // 表示最末位，个位u
            if index == length - 1 {
                printNumber(result: result)
                return
            }
            
            for i in 0..<10 {
                result[index + 1] = Character(UnicodeScalar(zeroAssi + UInt8(i)))
                printNumber(result: &result, length: length, index: index + 1)
            }
            
        }
        
        static func printNumber(result: [Character]) {
            var isZero = true
            result.forEach { (value) in
                if isZero && value != "0" {
                    isZero = false
                }
                if !isZero {
                    print(value, terminator: "")
                }
            }
            print("")
        }
        
        static func test() {
            printMaxNumber(n: 2)
        }
    }
}

extension Exercise {
    struct E6_16 {
        static func merge(left: Node?, right: Node?) -> Node? {
            guard let left = left else { return right }
            guard let right = right else { return left }
            
            var head: Node? = nil
            if left.value < right.value {
                head = left
                head?.next = merge(left: left.next, right: right)
            } else {
                head = right
                head?.next = merge(left: left, right: right.next)
            }
            
            return head
        }
        
        static func test() {
            let node3 = Node(value: 1, next: Node(value: 3, next: Node(value: 5, next: nil)))
            let node4 = Node(value: 2, next: Node(value: 4, next: Node(value: 6, next: nil)))
            assert(merge(left: nil, right: nil) == nil)
            assert(merge(left: node3, right: nil) === node3)
            assert(merge(left: nil, right: node4) === node4)
            let result1 = merge(left: node3, right: node4)
            assert(result1?.values == [1, 2, 3, 4, 5, 6])
            
            print("E6_17 OVER")
        }
    }
}

extension Exercise {
    struct E6_17 {
        static func isSubTree(tree: Tree?, sub: Tree?) -> Bool {
            if sub == nil {
                return true
            }
            
            if tree == nil {
                return false
            }
            
            var isSame = tree?.value == sub?.value
            if isSame {
                isSame = same(tree: tree, sub: sub)
            }
            
            if !isSame {
                isSame = isSubTree(tree: tree?.left, sub: sub)
            }
            if !isSame {
                isSame = isSubTree(tree: tree?.right, sub: sub)
            }
            return isSame
        }
        
        static func same(tree: Tree?, sub: Tree?) -> Bool {
            if sub == nil {
                return true
            }
            
            if tree == nil {
                return false
            }
            
            let isSame = tree?.value == sub?.value
            if isSame {
                return same(tree: tree?.left, sub: sub?.left) && same(tree: tree?.right, sub: sub?.right)
            } else {
                return false
            }
        }
        
        static func test() {
            
            let a = Tree(value: 1)
            let b = Tree(value: 2)
            let c = Tree(value: 3)
            let d = Tree(value: 4)
            let e = Tree(value: 5)
            let f = Tree(value: 6)
            
            a.left = b
            a.right = c
            b.left = e
            c.left = f
            
            let g = Tree(value: 6)
            
            assert(isSubTree(tree: nil, sub: nil) == true)
            assert(isSubTree(tree: a, sub: nil) == true)
            
            assert(isSubTree(tree: a, sub: d) == false)
            assert(isSubTree(tree: a, sub: b) == true)
            assert(isSubTree(tree: a, sub: g) == true)
            print("E6_17 OVER")
        }
    }
}

extension Exercise {
    struct E6_19 {
        static func printMatrixClockwise(_ array: [[Int]]) -> [Int]? {
            guard array.count > 0, array[0].count > 0  else {
                return nil
            }
            
            let row = array.count
            let column = array[0].count
            var start = 0
            var result: [Int] = []
            while start * 2 < row, 2 * start < column {
                let array = printCirecle(array: array, start: start)
                result.append(contentsOf: array)
                start += 1
            }
            return result
        }
        
        static func printCirecle(array: [[Int]], start: Int) -> [Int] {
            let maxRow = array.count - 1 - start
            let maxColumn = array[0].count - 1 - start
            
            var result: [Int] = []
            
            /// 从start开始
            // 肯定有第一步
            for i in start...maxColumn {
                result.append(array[start][i])
            }
            
            // 上 -> 下
            if maxRow > start {
                for i in start+1...maxRow {
                    result.append(array[i][maxColumn])
                }
            }
            
            // 右 -> 左, 要满足这个情况，必须有两列, 并且有两行
            if maxRow > start, maxColumn > start {
                for i in stride(from: maxColumn - 1, through: start, by: -1) {
                    result.append(array[maxRow][i])
                }
            }
            
            // 下 -> 上， 要满足这个情况，必须有2列, 并且有3行
            if maxColumn > start, maxRow >= start + 2 {
                for i in stride(from: maxRow - 1, through: start + 1, by: -1) {
                     result.append(array[i][start])
                }
            }
            return result
        }
        
        static func test() {
            // 一行
            let a = [[1, 2, 3]]
            assert(printMatrixClockwise(a) == [1, 2, 3])
            // 1列
            let b = [[1], [2], [3]]
            assert(printMatrixClockwise(b) == [1, 2, 3])
            // 1行1列
            let c = [[1]]
            assert(printMatrixClockwise(c) == [1])
            
            let d = [[1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]]
            assert(printMatrixClockwise(d) == [1, 2, 3, 4, 4, 4, 4, 3, 2, 1, 1,1, 2, 3,3,2])
            
            print("E6_19 OVER")
        }
     }
}

extension Exercise {
    struct E6_21 {
        static func isPopOrder(input: [Int], out: [Int]) -> Bool {
            guard input.count == out.count else {
                return false
            }
            
            var inputIndex = 0
            var outputIndex = 0
            var stack = Stack<Int>()
            
            while outputIndex < out.count {
                if stack.isEmpty || stack.peek() != out[outputIndex] {
                    if inputIndex >= input.count {
                        return false
                    }
                    stack.push(value: input[inputIndex])
                    inputIndex += 1
                } else {
                    _ = stack.pop()
                    outputIndex += 1
                }
            }
            return stack.isEmpty
        }
        
        static func test() {
            let inArray = [1, 2, 3, 4, 5]
            let out1 = [4 , 5 ,3 ,2 ,1]
            let out2 = [5, 4, 3, 2, 1]
            let out3 = [5, 4, 3, 1, 2]
            
           let inArray1 = [1, 1, 1, 1, 1]
            let out4 = [1, 1, 1, 1, 1]
            
            assert(isPopOrder(input: inArray, out: out1))
            assert(isPopOrder(input: inArray, out: out2))
            assert(isPopOrder(input: inArray, out: out3) == false)
            assert(isPopOrder(input: inArray1, out: out4))
            print("E6_21 OVER")
        }
    }
}

extension Exercise {
    struct E6_24 {
        static func changeBSTToList(tree: Tree?) -> Tree? {
            guard let tree = tree else {
                return nil
            }
            
            var current: Tree? = nil
            change(tree: tree, current: &current)
            
            // **
            // 返回头结点
            while current?.left != nil {
                current = current?.left
            }
            
            return current
        }
        
        static func change(tree: Tree?, current: inout Tree?) {
            let pCurrent: Tree? = tree
            if let left = pCurrent?.left {
                change(tree: left, current: &current)
            }
            pCurrent?.left = current
            if current != nil {
                current?.right = pCurrent
            }
            current = pCurrent
            if let right = pCurrent?.right {
                change(tree: right, current: &current)
            }
        }
        
        
        static func buildTree(array: [Any]) -> Tree? {
            guard !array.isEmpty else {
                return nil
            }
            var index = 0
            return build(array: array, index: &index)
        }
        
        static func build(array: [Any], index: inout Int) -> Tree? {
            guard index < array.endIndex else {
                return nil
            }
            if array[index] is Int {
                let tree = Tree(value: array[index] as! Int)
                index += 1
                tree.left = build(array: array, index: &index)
                tree.right = build(array: array, index: &index)
                // **
                return tree
            }
            index += 1
            return nil
        }
        
        static func testBST() {
             let tree = Tree(value: 10, left: Tree(value: 6, left: Tree(value: 4), right: Tree(value: 8)), right: Tree(value: 14, left: Tree(value: 12), right: Tree(value: 16)))
             let current = changeBSTToList(tree: tree)
            let ltr = Topic36.leftToRight(tree: current)
            let rtl = Topic36.rightToLeft(tree: current)
             
             assert(ltr == [4, 6, 8, 10, 12, 14, 16])
             assert(rtl == [16, 14, 12, 10, 8, 6, 4])
            
            let result: [Any] = [1, 2, 4, "", "", "", 3, 5, "", "", 6, "", ""]
            let tree1 = buildTree(array: result)
             print("E6_24 OVER")
         }
    }
}

extension Exercise {
    struct E6_27 {
        static func numberOf1Between1AndN(_ n: Int) -> Int {
            guard n > 0 else {
                return 0
            }
            let str = String(n)
            return numberOf1(str: str, index: str.startIndex)
        }
        
        static func numberOf1(str: String, index: String.Index) -> Int {
            guard index < str.endIndex else { return 0 }
            
            let first = str[index].asciiValue! - Character("0").asciiValue!
            let length = str.distance(from: index, to: str.endIndex)
            let ofterIndex = str.index(after: index)
            
            if first == 0, length == 1 {
                return 0
            }
            
            if length == 1, first > 0 {
                return 1
            }
            
            var firstNumber = 0
            if first > 1 {
                //
                firstNumber = baseOf10(length - 1)
            } else if first == 1 {
                // 后面的
                
                if let n = Int(str[ofterIndex..<str.endIndex]) {
                    firstNumber = n + 1
                }
            }
            
            let otherNumber = Int(first) * (length - 1) * baseOf10(length - 2)
            let one = numberOf1(str: str, index: ofterIndex)
            return firstNumber + otherNumber + one
        }
        
        static func baseOf10(_ n: Int) -> Int {
            var result = 1
            for _ in 0..<n {
                result *= 10
            }
            return result
        }
        
        static func test() {
            assert(numberOf1Between1AndN(0) == 0)
            assert(numberOf1Between1AndN(1) == 1)
            assert(numberOf1Between1AndN(5) == 1)
            assert(numberOf1Between1AndN(20) == 12)
            print("E6_27 OVER")
        }
    }
}

extension Exercise {
    struct E6_28 {
        static func minNumber(of array: [Int]) -> String? {
            guard !array.isEmpty else { return nil }
            
            return array.map(String.init).sorted { (va1, va2) -> Bool in
                let combination1 = va1 + va2
                let combination2 = va2 + va1
                return combination1.compare(combination2) == .orderedAscending
            }.joined()
        }
        
        static func numberOf(index: Int) -> Int? {
            guard index >= 0 else { return nil }
            
            var digit = 1
            var index = index
            while true {
                let all = allIndex(with: digit)
                if index > all {
                    index -= all
                    digit += 1
                } else {
                    return finalIndex(index: index, digit: digit)
                }
            }
            
        }
        
        static func allIndex(with digit: Int) -> Int {
            if digit == 1 {
                return 10
            }
            return 9 * Int(pow(10, (Double(digit) - 1) as Double)) * digit
        }
        
        static func beginNumberOf(digit: Int) -> Int {
            if digit == 1 {
                return 0
            }
            return Int(pow(10, (Double(digit) - 1) as Double))
        }
        
        static func finalIndex(index: Int, digit: Int) -> Int {
            var idx = beginNumberOf(digit: digit) + index / digit
            let indexFromRight = digit - index % digit
            for _ in 1..<indexFromRight {
                idx /= 10
            }
            return idx % 10
        }
        
        static func test() {
            let a = [3, 32, 321]
            assert(minNumber(of: a) == "321323")
            
            let b = [5, 4, 3, 2, 1]
            assert(minNumber(of: b) == "12345")
            
            assert(numberOf(index: 0) == 0)
            assert(numberOf(index: 9) == 9)
            assert(numberOf(index: 1001) == 7)
            assert(numberOf(index: 1000) == 3)
            assert(numberOf(index: 1002) == 0)
            
            print("E6_28 OVER")
        }
    }
}

extension Exercise {
    struct E6_29 {
        static func translateCount(value: Int) -> Int? {
            guard value >= 0 else { return nil }
            return translateCount(with: "\(value)")
        }
        
        static func translateCount(with str: String) -> Int {
            var result = Array<Int>(repeating: 0, count: str.count)
            var count = 0
            for i in str.indices.reversed() {
                count = 0
                let index = str.distance(from: str.startIndex, to: i)
                if i < str.index(before: str.endIndex) {
                    count = result[index + 1]
                    
                    let max = str[i].asciiValue! - Character("0").asciiValue!
                    let min = str[str.index(after: i)].asciiValue! - Character("0").asciiValue!
                    let combination = max * 10 + min
                    if combination >= 10, combination <= 25 {
                        if i < str.index(str.endIndex, offsetBy: -2) {
                            count += result[index + 2]
                        } else {
                            count += 1
                        }
                    }
                    
                } else {
                    count = 1
                }
                result[index] = count
            }
            return result[0]
        }
        
        static func test() {
               assert(translateCount(value: 1) == 1)
               assert(translateCount(value: 12258) == 5)
               print( "E6_29 OVER ")
           }
    }
}

extension Exercise {
    struct E_30 {
        static func maxGiftValue(array: [[Int]]) -> Int? {
            guard array.count > 0 else { return nil }
            let row = array.count
            let col = array[0].count
            
            var result = Array<Int>(repeating: 0, count: col)
            for i in 0..<row {
                for j in 0..<col {
                    var up = 0
                    var left = 0
                    if i > 0 {
                        up = result[j]
                    }
                    if j > 0 {
                        left = result[j - 1]
                    }
                    result[j] = max(left, up) + array[i][j]
                }
            }
            return result[col - 1]
        }
        
        static func test() {
            let a = [[1, 10, 3, 8], [12, 2, 9, 6], [5, 7, 4, 11], [3, 7, 16, 5]]
            assert(maxGiftValue(array: a) == 53)
            assert(maxGiftValue(array: a) == 53)
            
            print("E_30 OVER")
        }
    }
}


extension Exercise {
    struct E7_02 {
        static func reversePaireCount(array: [Int]) -> Int? {
            guard array.count > 1 else { return nil }
            
            var array = array
            var copy = array
            return findReversePaire(array: &array, copy: &copy, start: 0, end: array.count - 1)
        }
        
        static func findReversePaire(array: inout [Int], copy: inout [Int], start: Int, end: Int) -> Int {
            guard start != end else {
                copy[start] = array[start]
                return 0
            }
            
            let middle = (start + end) >> 1
            var startIndex = middle
            var endIndex = end
            
            var copyIndex = end
            
            let left = findReversePaire(array: &copy, copy: &array, start: start, end: middle)
            let right = findReversePaire(array: &copy, copy: &array, start: middle + 1, end: end)
            
            var count = 0
            while startIndex >= start, endIndex > middle {
                if array[startIndex] > array[endIndex] {
                    count += endIndex - middle
                    copy[copyIndex] = array[startIndex]
                    copyIndex -= 1
                    startIndex -= 1
                } else {
                    copy[copyIndex] = array[endIndex]
                    copyIndex -= 1
                    endIndex -= 1
                }
            }
            
            while startIndex >= start {
                copy[copyIndex] = array[startIndex]
                copyIndex -= 1
                startIndex -= 1
            }
            
            while endIndex > middle {
                copy[copyIndex] = array[endIndex]
                copyIndex -= 1
                endIndex -= 1
            }
            
            return left + right + count
        }
        
        static func test() {
            let a = [7, 5, 6, 4]
            assert(reversePaireCount(array: a) == 5)
            
            let b = [4]
            assert(reversePaireCount(array: b) == nil)
            
            let c = [5, 4]
            assert(reversePaireCount(array: c) == 1)
            
            print("Topic51 OVER")
        }
    }
}


extension Exercise {
    struct E7_03 {
        static func findReversePaire(array: [Int]) -> Int? {
            guard array.count > 1 else {
                return nil
            }
            
            var array = array
            var copy = array
            return reversePaire(array: &array, copy: &copy, start: 0, end: array.count - 1)
        }
        
        static func reversePaire(array: inout [Int], copy: inout [Int], start: Int, end: Int) -> Int {
            guard start != end else {
                copy[start] = array[start]
                return 0
            }
            
            let middle = (start + end) >> 1
            let left = reversePaire(array: &copy, copy: &array, start: start, end: middle)
            let right = reversePaire(array: &copy, copy: &array, start: middle + 1, end: end)
            
            var startIndex = middle
            var endIndex = end
            var copyIndex = end
            var count = 0
            while startIndex >= start, endIndex > middle {
                if array[startIndex] > array[endIndex] {
                    count += endIndex - middle
                    copy[copyIndex] = array[startIndex]
                    copyIndex -= 1
                    startIndex -= 1
                } else {
                    copy[copyIndex] = array[endIndex]
                    endIndex -= 1
                    copyIndex -= 1
                }
            }
            
            while startIndex >= start {
                copy[copyIndex] = array[startIndex]
                copyIndex -= 1
                startIndex -= 1
            }
            
            while endIndex > middle {
                copy[copyIndex] = array[endIndex]
                endIndex -= 1
                copyIndex -= 1
            }
            
            return left + right + count
        }
        
        static func test() {
            let a = [7, 5, 6, 4]
            assert(findReversePaire(array: a) == 5)
            
            let b = [4]
            assert(findReversePaire(array: b) == nil)
            
            let c = [5, 4]
            assert(findReversePaire(array: c) == 1)
            
            print("E7_03 OVER")
        }
    }
}

extension Exercise {
    static let maxValue = 6
    struct E7_09 {
        static func allPercentWithNumber(_ number: Int) {
            guard number > 0 else {
                return
            }
            
            let count = number * maxValue + 1
            
            var result = Array<[Int]>(repeating: Array<Int>(repeating: 0, count: count), count: 2)
            var flag = 0
            for i in 1...maxValue {
                result[flag][i] = 1
            }
            
            for k in 2...number {
                
                for j in 0..<k {
                    result[1-flag][j] = 0
                }
                
                for i in k...(k * maxValue) {
                    result[1-flag][i] = 0
                    for j in 1..<i where j <= maxValue {
                        result[1-flag][i] += result[flag][i - j]
                    }
                }
                flag = 1 - flag
            }
            
            let all = pow(Double(6), Double(number))
            let finalResult = result[flag]
            for i in number...(number * maxValue) {
                print("\(i) percent: \(finalResult[i])/\(all)")
            }
            
        }
        
        static func test() {
            allPercentWithNumber(2)
        }
    }
}


extension Exercise {
    struct E21_7_31 {
        class Tree: NSObject {
            let value: Int
            var left: Tree?
            var right: Tree?
            
            init(value: Int, left: Tree? = nil, right: Tree? = nil) {
                self.value = value
                self.left = left
                self.right = right
            }
            
        }
        
        struct TreeOrder {
            // 树的后续遍历
            
            /// 左右中
            static func postOrder(on tree: Tree) -> [Int] {
                var stack = Stack<Tree>()
                var this: Tree? = tree
                
                var pre: Tree? = nil
                var result: [Int] = []
                
                while this != nil || !stack.isEmpty {
                    if let t = this {
                        stack.push(value: t)
                        this = this?.left
                    } else {
                        this = stack.peek()
                        // 若有右子树，并且之前访问的树，不是右子树，那么就访问该树
                        // 否则, 表明右子树已经访问，应该访问根节点，然后弹出栈
                        if let r = this?.right, r != pre {
                            this = r
                        } else {
                            /// 记录当前树
                            pre = this
                            
                            /// 弹出当前树
                            _ = stack.pop()
                            
                            if let t = this {
                                result.append(t.value)
                            }
                            this = nil
                        }
                    }
                }
                
                return result
            }
            
            static func test() {
                let tree = Tree(value: 4, left: Tree(value: 3, left: Tree(value: 2), right: Tree(value: 1)), right: Tree(value: 5, left: Tree(value: 6), right: Tree(value: 7)))
                
                assert(postOrder(on: tree) == [2, 1, 3, 6, 7, 5, 4])
                print("\(self) over")
            }
        }
        
        
        /// 前序和中序 => 构建树
        struct ConstructTree {
            
            static func createTree(with preOrder: [Int], inOrder: [Int]) -> Tree? {
                return _createTree(with: preOrder, preStart: 0, preEnd: preOrder.count - 1, inOrder: inOrder, inStart: 0, inEnd: inOrder.count - 1)
            }
            
            static func _createTree(with preOrder: [Int], preStart: Int, preEnd: Int, inOrder: [Int], inStart: Int, inEnd: Int) -> Tree? {
                
                guard preStart < preEnd else {
                    return Tree(value: preOrder[preStart])
                }
                
                let rootValue = preOrder[preStart]
                let root = Tree(value: rootValue)
                
                var start = inStart
                
                while start <= inEnd, inOrder[start] != rootValue {
                    start += 1
                }
                
                
                let leftChildSize = start - inStart
                
                let leftPreStart = preStart + 1
                let leftPreEnd = preStart + leftChildSize
                let leftInStart = inStart
                let leftInEnd = inStart + leftChildSize - 1
                
                if leftChildSize > 0 {
                    root.left = _createTree(with: preOrder, preStart: leftPreStart, preEnd: leftPreEnd, inOrder: inOrder, inStart: leftInStart, inEnd: leftInEnd)
                }
                
                
                if leftChildSize < preEnd - preStart {
                    let rPreStart = leftPreEnd + 1
                    let rPreEnd = preEnd
                    let rInStart = leftInEnd + 2
                    let rInEnd = inEnd
                    
                    
                    root.right = _createTree(with: preOrder, preStart: rPreStart, preEnd: rPreEnd, inOrder: inOrder, inStart: rInStart, inEnd: rInEnd)
                }
                
                return root
            }
        }
        
        static func test() {
            TreeOrder.test()
        }
    }
}

extension Exercise {

    struct E21_8_7 {
        class Tree: NSObject {
            let value: Int
            var left: Tree?
            var right: Tree?
            
            init(value: Int, left: Tree? = nil, right: Tree? = nil) {
                self.value = value
                self.left = left
                self.right = right
            }
            
        }
        
        struct Interview_36 {
            static func createList(from tree: Tree?) -> Tree? {
                return _createList(from: tree)?.head
            }
            
            static func _createList(from tree: Tree?) -> (head: Tree?, tail: Tree?)? {
                guard let root = tree else {
                    return nil
                }
                
                var head: Tree? = root
                var tail: Tree? = root
                
                if let leftListInfo = _createList(from: root.left) {
                    head = leftListInfo.head ?? root
                    root.left = leftListInfo.tail
                    leftListInfo.tail?.right = root
                }
                
                if let rightListInfo = _createList(from: root.right) {
                    tail = rightListInfo.tail ?? root
                    root.right = rightListInfo.head
                    rightListInfo.head?.left = root
                }
                
                return (head, tail)
            }
            
            static func test() {
                let tree = Tree(value: 10, left: Tree(value: 6, left: Tree(value: 4), right: Tree(value: 8)), right: Tree(value: 14, left: Tree(value: 12), right: Tree(value: 16)))
                let tree2 = Tree(value: 6, right: Tree(value: 7, right: Tree(value: 8)))
                let tree3 = Tree(value: 6, left: Tree(value: 5, left: Tree(value: 4)))
                
                let result = createList(from: tree)
                let result2 = createList(from: tree2)
                let result3 = createList(from: tree3)
                print("OVer")
            }
        }
        
        struct I38 {
            static func permutation(string: String?) {
                guard let s = string else {
                    return
                }
                
                var result = Array(s)
                _permitation(index: 0, result: &result)
            }
            
            static func _permitation(index: Int, result: inout [Character]) {
                
                guard index < result.count - 1 else {
                    print(String(result))
                    return
                }
            
                /// ⚠️ 自己和自己交换，才能保证打印后边变动的组合
                for idx in index ..< result.count {
                    /// ⚠️1.交换
                    result.swapAt(index, idx)
                    _permitation(index: index + 1, result: &result)
                    
                    // 还原
                    result.swapAt(index, idx)
                }
            }
            
            
            static func composite(string: String?) {
                guard let s = string else {
                    return
                }
                
                for length in 1...s.count {
                    var result = ""
                    _composite(s: s, length: length, index: s.startIndex, result: &result)
                }
            }
            
            static func _composite(s: String, length: Int, index: String.Index, result: inout String) {
                guard length > 0 else {
                    print(result)
                    return
                }
                
                guard index < s.endIndex else {
                    return
                }
                
                /// 加入
                result.append(String(s[index]))
                _composite(s: s, length: length - 1, index: s.index(after: index), result: &result)
                
                /// 不加入
                /// 恢复
                result.removeLast()
                _composite(s: s, length: length, index: s.index(after: index), result: &result)
            }
            
            static func queeen(size: Int) {
                guard size > 0 else {
                    return
                }
                
                var result: [Int] = []
                _queen(row: 0, size: size, result: &result)
            }
            
            
            static func _queen(row: Int, size: Int, result: inout [Int]) {
                
                func isValid(row: Int, column: Int, result: inout [Int]) -> Bool {
                    guard !result.isEmpty else {
                        return true
                    }
                    
                    
                    var isValid = true
                    for (r, c) in result.enumerated() {
                        
                        /// 是否同一列
                        /// 是否对角线
                        if c == column || row - r == abs(column - c) {
                            isValid = false
                            break
                        }
                    }
                    
                    return isValid
                }
                
                guard row < size else {
                    print(result)
                    return
                }
                
                for column in 0 ..< size where isValid(row: row, column: column, result: &result) {
                    result.append(column)
                    _queen(row: row + 1, size: size, result: &result)
                    result.removeLast()
                }
            }
            
            
            static func test() {
                permutation(string: "abc")
                composite(string: "abc")
                queeen(size: 8)
            }
        }
        
        static func test() {
            Interview_36.test()
            I38.test()
        }
    }
}


extension Exercise {
    struct E21_8_8 {
        struct I43 {
            static func findOneNumberTo(number: Int) -> Int {
                guard number > 0 else {
                    return 0
                }
                
                /// 获取最高位
                let maxPositionValue = findMaxPositionValue(on: number)
                let length = findLength(of: number)
                
                if length == 1 {
                    return maxPositionValue > 0 ? 1 : 0
                }
                
                /// 算最高位
                var numberOfMaxPosition = 0
                if maxPositionValue > 1 {
                    numberOfMaxPosition = powOf10(length: length - 1)
                } else {
                    let nextNumber = number % powOf10(length: length - 1)
                    numberOfMaxPosition = nextNumber + 1
                }
                
                /// 剩下位出现1的情况，最高位数值 x 剩下位个数 x 除去设置1之后，其他位数
                /// 举例：21345, 最高位2，剩下的位数是4， 如果一位设置1，那么其他三位可以随便变化。4 x 2 x 10^(3)
                let numberOfRemainPosition = maxPositionValue * (length - 1) * powOf10(length: length - 2)
                
                /// 除去最高位，再计算
                let nextNumber = findOneNumberTo(number: number % powOf10(length: length - 1))
                
                return numberOfMaxPosition + numberOfRemainPosition + nextNumber
            }
            
            static func findMaxPositionValue(on number: Int) -> Int {
                guard number > 0 else {
                    return 0
                }
                
                var number = number
                while number > 9 {
                    number /= 10
                }
                
                return number
            }
            
            static func findLength(of number: Int) -> Int {
                
                var length = 1
                var number = number
                while number > 9 {
                    number /= 10
                    length += 1
                }
                
                return length
            }
            
            static func powOf10(length: Int) -> Int {
                var length = length
                var value = 1
                while length > 0 {
                    value *= 10
                    length -= 1
                }
                
                return value
            }
            
            static func test() {
                assert(findOneNumberTo(number: 0) == 0)
                assert(findOneNumberTo(number: 1) == 1)
                assert(findOneNumberTo(number: 5) == 1)
                assert(findOneNumberTo(number: 20) == 12)
                print("Topic43 OVER")
            }
            
        }
        
        static func test() {
            I43.test()
        }
    }
}


extension Exercise {
    struct E21_8_16 {
        static func print(tree: Tree?) {
            guard let root = tree else {
                return
            }
            var queue = MyQueue<Tree>()
            
            var result = ""
            
            var count = 1
            var nextCount = 0
            queue.enqueue(element: root)
            while !queue.isEmpty {
                let t = queue.dequeue()!
                result.append("\(t.value)")
                count -= 1
                
                if let leftTree = t.left {
                    nextCount += 1
                    queue.enqueue(element: leftTree)
                }
                
                if let rightTree = t.right {
                    nextCount += 1
                    queue.enqueue(element: rightTree)
                }
                
                if count == 0 {
                    result.append("\n")
                    count = nextCount
                    nextCount = 0
                    continue
                }

            }
            
            Swift.print(result)
        }
        
        static func test() {
            let t = Tree(value: 1, left: Tree(value: 2, left: Tree(value: 4)), right: Tree(value: 3, left: Tree(value: 5)))
            print(tree: t)
        }
    }
}

extension Exercise {
    struct E_21_8_17 {
        static func findKMaxValue(in tree: Tree?, k: Int) -> Int? {
            guard let t = tree, k > 0 else {
                return nil
            }
            
            var k = k
            return _findMaxNode(in: t, k: &k)?.value
        }
        
        static func _findMaxNode(in tree: Tree, k: inout Int) -> Tree? {
            var targe: Tree?
            
            if let left = tree.left {
                targe = _findMaxNode(in: left, k: &k)
            }
            
            if targe == nil {
                if k == 1 {
                    return tree
                }
                
                k -= 1
            }
            
            if targe == nil, let right = tree.right {
                targe = _findMaxNode(in: right, k: &k)
            }
            
            return targe
        }
        
        static func test() {
            let t = Tree(value: 5, left: Tree(value: 3, left: Tree(value: 2), right: Tree(value: 4)), right: Tree(value: 6))
            print(findKMaxValue(in: t, k: 3))
        }
    }
}
