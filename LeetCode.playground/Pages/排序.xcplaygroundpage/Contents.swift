//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


// MARK: - 快速排序
func quickSort(numbers: inout [Int]) {
    guard numbers.count > 1 else {
        return
    }
    _quickSort(numbers: &numbers, low: 0, high: numbers.count - 1)
}


func _quickSort(numbers: inout [Int], low: Int, high: Int) {
    guard low < high else {
        return
    }
    
    var i = low
    var j = high
    let key = numbers[i]
    
    while i < j {
        while i < j, key <= numbers[j] {
            j -= 1
        }
        numbers[i] = numbers[j]
        
        while i < j, numbers[i] < key {
            i += 1
        }
        numbers[j] = numbers[i]
    }
    // i == j
    numbers[j] = key

    _quickSort(numbers: &numbers, low: low, high: j - 1)
    _quickSort(numbers: &numbers, low: j + 1, high: high)
}

do {
    var a: [Int] = []
    quickSort(numbers: &a)
    assert(a == [])

    var b = [1]
    quickSort(numbers: &b)
    assert(b == [1])
    //
    var c = [5, 1, 4, 3, 2, 1]
    quickSort(numbers: &c)
    assert(c == [1, 1, 2, 3, 4, 5])
}



// MARK: - 归并排序（mergesort）

func mergeSort( numbers: inout [Int])  {
    guard numbers.count > 1 else {
        return
    }
    
//    return _mergeSort(numbers, start: 0, end: numbers.count - 1)
    _mergeSort2(&numbers, result: NSMutableArray(), start: 0, end: numbers.count - 1)
}

// 方式1， 内存暂用太懂 2^n
func _mergeSort(_ numbers: [Int], start: Int, end: Int) -> [Int] {
    
    guard start < end else {
        return [numbers[start]]
    }
    
    let mid = (start + end) >> 1
    let start1 = start
    let end1 = mid
    
    let start2 = mid + 1
    let end2 = end
    print(start1)
    let array1 = _mergeSort(numbers, start: start1, end: end1)
    print(array1)
    let array2 = _mergeSort(numbers, start: start2, end: end2)
    print(array2)
    
    
    // 合并
    
    var result: [Int] = []
    var i = 0
    var j = 0
    
    while i <= array1.count - 1, j <= array2.count - 1 {
        if array1[i] <= array2[j] {
            result.append(array1[i])
            i += 1
        } else {
            result.append(array2[j])
            j += 1
        }
    }
    
    while i <= array1.count - 1 {
        result.append(array1[i])
        i += 1
    }
    
    while j <= array2.count - 1 {
        result.append(array2[j])
        j += 1
    }
    
    print(result)
    return result
}

// 2： 固定result容器减少开销， 最后 result -> numbers
func _mergeSort2(_ numbers: inout [Int], result: NSMutableArray, start: Int, end: Int) {
    
    guard start < end else {
        return
    }
    
    let mid = (start + end) >> 1
    var start1 = start
    let end1 = mid
    
    var start2 = mid + 1
    print("start2:---\(start2)")
    let end2 = end
    
    
    _mergeSort2(&numbers, result: result, start: start1, end: end1)
    _mergeSort2(&numbers, result: result, start: start2, end: end2)
    
    print("numbers: \(numbers)")
    // 合并
    result.removeAllObjects()
    while start1 <= end1, start2 <= end2 {
        print("start1:\(start1) start2:\(start2)")
        if numbers[start1] <= numbers[start2] {
            result.add(numbers[start1])
            start1 += 1
        } else {
            result.add(numbers[start2])
            start2 += 1
        }
    }
    
    print(result)
    while start1 <= end1 {
        result.add(numbers[start1])
        start1 += 1
    }
    
    while start2 <= end2 {
        result.add(numbers[start2])
        start2 += 1
    }

    print(result)
    print("start: \(start)  end:\(end)")
    numbers.replaceSubrange(start...end, with: result as! [Int])
}




do {
//    let a: [Int] = []
//    assert(a == mergeSort(numbers: a))
//
//    let b = [1]
//    assert(b == mergeSort(numbers:b))
//    //
//    let c = [5, 4, 3, 2, 1]
//    assert(mergeSort(numbers: c) == [1, 2, 3, 4, 5])
}

//do {
//    var a: [Int] = []
//    mergeSort(numbers: &a)
//    assert(a == [])
//
//    var b = [1]
//    mergeSort(numbers: &b)
//    assert(b == [1])
//    //
//    var c = [5, 4, 3, 2, 1]
//    mergeSort(numbers: &c)
//    assert(c == [1, 2, 3, 4, 5])
//}


// 堆排序
// 自上而下的上滤（从第一个根节点（root）比较） 效率低于 自下而上的下滤（从最后一个父亲节点比较），无论上滤和下滤，
// 每次更新了节点，而该节点是父亲节点，都要调整树
func heapify(numbers: inout [Int], node: Int, lastIndex: Int) {
    
    let leftNode = 2 * node + 1
    let rightNode = 2 * node + 2
    var largeNode = node // large
    
    if leftNode < lastIndex, numbers[leftNode] > numbers[largeNode] {
        largeNode = leftNode
    }
    
    if rightNode < lastIndex, rightNode < numbers.count - 1, numbers[rightNode] > numbers[largeNode]  {
        largeNode = rightNode
    }
    
    // swap
    print(largeNode)
    if node != largeNode {
        let temp = numbers[node]
        numbers[node] = numbers[largeNode]
        numbers[largeNode] = temp
        
        heapify(numbers: &numbers, node: largeNode, lastIndex: lastIndex)
    }
}

// 迭代
func heapifyIterate(numbers: inout [Int], node: Int, lastIndex: Int) {
    var large = node
    for i in sequence(first: large, next: { value in
        guard value != large else { return nil }
        return large
    }) {
        let left = 2 * i + 1
        let right = 2 * i + 2
        large = i
        if left < lastIndex, numbers[i] < numbers[left] {
            large = lastIndex
        }
        
        if right < lastIndex, numbers[large] < numbers[right] {
            large = right
        }
        
        // swap
        if large != i {
            let temp = numbers[i]
            numbers[i] = numbers[large]
            numbers[large] = temp
        }
    }
}


func buildMaxHeap(numbers: inout [Int]) {
    let lastParentNode = (numbers.count - 1 - 1) / 2
    
    // 递归
//    for i in stride(from: lastParentNode , to: 0, by: -1) {
//        heapify(numbers: &numbers, node: i, lastIndex: numbers.count)
//    }
    
    // 迭代
    for i in stride(from: lastParentNode , to: 0, by: -1) {
        heapifyIterate(numbers: &numbers, node: i, lastIndex: numbers.count)
    }
}

func heapifySort(numbers: inout [Int]) {
    buildMaxHeap(numbers: &numbers)
    
    // 把堆顶和末尾元素交换，并减少index
    for i in stride(from: numbers.count - 1, to: 0, by: -1) {
        let temp = numbers[0]
        numbers[0] = numbers[i]
        numbers[i] = temp
        heapify(numbers: &numbers, node: 0, lastIndex: i)
    }
}

//
//do {
//    var c = [5, 4, 3, 2, 1]
//    heapifySort(numbers: &c)
//    assert(c == [1, 2, 3, 4, 5])
//
//    var d = [3, 4, 3, 7, 1]
//    heapifySort(numbers: &d)
//    assert(d == [1, 3, 3, 4, 7])
//}

struct Sort {
    static func bubble(numbers: inout [Int]) {
        guard numbers.count > 1 else { return }
        
        for i in 0..<numbers.count - 1 {
            for j in 0..<numbers.count - 1 - i {
                if numbers[j] > numbers[j + 1] {
                    let temp = numbers[j + 1]
                    numbers[j + 1] = numbers[j]
                    numbers[j] = temp
                }
            }
        }
    }
    
    static func choice(numbers: inout [Int]) {
        guard numbers.count > 1 else { return }
        
        for i in 0..<numbers.count - 1 {
            var minIndex = i
            for j in i...numbers.count - 1 {
                if numbers[j] < numbers[minIndex] {
                    minIndex = j
                }
            }
            if minIndex != i {
                let temp = numbers[i]
                numbers[i] = numbers[minIndex]
                numbers[minIndex] = temp
            }
        }
    }
    
    static func insert(numbers: inout [Int]) {
        guard numbers.count > 1 else { return }
        for i in 1..<numbers.count {
            let temp = numbers[i]
            var currentIndex = i - 1
            while currentIndex >= 0 && numbers[currentIndex] > temp {
                numbers[currentIndex + 1] = numbers[currentIndex]
                currentIndex -= 1
            }
            numbers[currentIndex + 1] = temp
        }
    }
    
    static func counting(numbers: inout [Int]) {
        guard numbers.count > 1, let max = numbers.max() else { return }
        
        var result = Array<Int>(repeating: 0, count: max + 1) // *
        numbers.forEach { value in
            result[value] = result[value] + 1
        }
        numbers.removeAll()
        for (index, value) in result.enumerated() {
            guard value > 0 else { continue }
            for i in 0...value - 1 { //*
                numbers.append(index)
            }
        }
    }
    
    static func shell(numbers: inout [Int]) {
        guard numbers.count > 1 else { return }

        // * sequence
        for i in sequence(first: numbers.count / 2, next: { $0 > 0 ? $0/2 : nil }) {
            for j in i..<numbers.count {
                var index = j
                var temp = numbers[j] // 没有必要每次移动，找到最终的位置在移动
                while index - i >= 0, numbers[index - i] > temp {
                    numbers[index] = numbers[index - i]
                    index -= i
                }
                numbers[index] = temp
            }
        }

    }
    
    static func test() {
        var a = [4, 3, 2, 1]
        bubble(numbers: &a)
        assert(a == [1, 2, 3, 4])
        print("Sort 1")
        a = [4, 3, 2, 1]
        choice(numbers: &a)
        assert(a == [1, 2, 3, 4])
        print("Sort 2")
        
        a = [4, 3, 2, 1]
        insert(numbers: &a)
        print(a)
        assert(a == [1, 2, 3, 4])
        
        a = [4, 3, 2, 1]
        counting(numbers: &a)
        print(a)
        assert(a == [1, 2, 3, 4])
        
        a = [4, 3, 2, 1]
        shell(numbers: &a)
        print(a)
        assert(a == [1, 2, 3, 4])
        
        print("Sort OVER")
    }
}

Sort.test()

for i in sequence(first: 16, next: { $0 > 0 ? $0/2 : nil }) {
    print(i)
}
