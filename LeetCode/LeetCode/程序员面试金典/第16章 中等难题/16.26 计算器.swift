//
//  16.26 计算器.swift
//  算法
//
//  Created by Plum on 2021/6/13.
//  Copyright © 2021 Plum. All rights reserved.
//

import Foundation

/*
 P
 
 16.26计算器。给定一个包含正整数、加(+)、减(-)、乘(×)、除(/)的算数表达式(括号除外),计算其结果。
 示例:
    输入:2 * 3 + 5/6 *3 + 15
    输出:23.5
 
 (提示:#520,#623,#664,#697)
 */

struct Interview_16_26 {
    
    enum Operator: Comparable {
        case add, sub, multiple, divide, blank
        
        static func < (lhs: Self, rhs: Self) -> Bool {
            
            switch (lhs, rhs) {
            case (sub, sub):
                return true
                
            case (add, sub):
                return true
                
            case (sub, add):
                return true
                
            case (add, add):
                return true
                
            case (_, multiple):
                return true
                
            case (_, divide):
                return true
                
            default:
                return false
            }
        }
    }
    
    
    static func isValid(express: String) -> Bool {
        return true
    }
    
    static func toOperator(value: Character) -> Operator {
        var op = Operator.blank
        if value == "+" {
            op = .add
        } else if value == "-" {
            op = .sub
        } else if value == "*" {
            op = .multiple
        } else if value == "/" {
            op = .divide
        }
        
        return op
    }
    
    struct Solution1 {
        
        struct Term {
            
            enum TermError: Error {
                case parameterInvalid
            }
            
            
            var value: Double
            let op: Operator
            
            init(value: Double, op: Operator = .blank) {
                self.value = value
                self.op = op
            }
            
            mutating
            func caculate(other: Term) throws {
                switch other.op {
                case .add:
                    value += other.value
                    
                case .sub:
                    value -= other.value
                    
                case .multiple:
                    value *= other.value
                    
                case .divide:
                    if other.value == 0 {
                        throw TermError.parameterInvalid
                    }
                    value /= other.value
                    
                default:
                    break
                }
            }
            
            var signedValue: Double {
                return op == .sub ? -value : value
            }
            
        }
        
        
        static func caculate(express: String) -> Double? {
            guard isValid(express: express) else {
                return nil
            }
            
            let terms = parse(sequence: express)
            
            var process: Term?
            var result: Double = 0
            
            for (index, item) in terms.enumerated() {
                
                if process == nil {
                    process = item
                } else {
                    // 如果下一个是高优先级的先不算结果,反之计算结果
                    let next = index + 1 < terms.count ? terms[index + 1] : nil
                    if next == nil || next?.op == .add || next?.op == .sub {
                        try? process?.caculate(other: item)
                        result += process?.value ?? 0
                        process = nil
                    } else {
                        try? process?.caculate(other: item)
                    }
                }
                
                if index == terms.count - 1 {
                    result += process?.value ?? 0
                }
            }
            
            return result
        }
        
        static func parse(sequence: String) -> [Term] {
            var result: [Term] = []
            
            var isFirst = true
            var symbol: Operator?
            for item in sequence {
                if isFirst {
                    result.append(Term(value: Double(String(item))!))
                    isFirst = false
                } else {
                    
                    if let op = symbol {
                        result.append(Term(value: Double(String(item))!, op: op))
                        symbol = nil
                    } else {
                        symbol = toOperator(value: item)
                    }
                    
                }
            }
            
            return result
        }
        
    }
    
    struct Solution2 {
        static func caculate(express: String) -> Double? {
            guard isValid(express: express) else {
                return nil
            }
            
            var numberStack = Stack<Double>()
            var operationStack = Stack<Operator>()
            
            var result = 0.0
            
            for (index, item) in express.enumerated() {
                if index % 2 == 1 {
                    /// 和栈定的符号对比
                    let symple = toOperator(value: item)
                    while let top = operationStack.peek(), symple < top {
                        _ = operationStack.pop()
                        if let second = numberStack.pop(), let first = numberStack.pop() {
                            // ⚠️ 这里不用累加
                            let result = operation(first: first, second: second, op: top)
                            numberStack.push(value: result)
                        }
                    }
                    operationStack.push(value: symple)
                } else {
                    let value = Double(String(item))!
                    numberStack.push(value: value)
                }
                
                
                // 最后计算
                if index == express.count - 1, !numberStack.isEmpty {
                    if let op = operationStack.pop(), let second = numberStack.pop(), let first = numberStack.pop() {
                        result = operation(first: first, second: second, op: op)
                        numberStack.push(value: result)
                    }
                }
            }
            
            return result
        }
        
        static func operation(first: Double, second: Double, op: Operator) -> Double {
            if op == .divide, second == 0 {
                fatalError()
            }
            
            var result = 0.0
            switch op {
            case .add:
                result = first + second
                
            case .sub:
                result = first - second
                
            case .multiple:
                result = first * second
            
            case .divide:
                result = first / second
                
            default:
                break
            }
            
            return result
        }
    }
    
    
    static func test() {
        
        print(Solution1.caculate(express: "2*3+5/6*3+1"))
        print(Solution2.caculate(express: "2*3+5/6*3+1"))
        
        print("\(self) OVER")
    }
}
