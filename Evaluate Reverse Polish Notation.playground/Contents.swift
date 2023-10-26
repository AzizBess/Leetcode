/*
 
 150. Evaluate Reverse Polish Notation
 Medium
 6.6K
 966
 Companies
 You are given an array of strings tokens that represents an arithmetic expression in a Reverse Polish Notation.

 Evaluate the expression. Return an integer that represents the value of the expression.

 Note that:

 The valid operators are '+', '-', '*', and '/'.
 Each operand may be an integer or another expression.
 The division between two integers always truncates toward zero.
 There will not be any division by zero.
 The input represents a valid arithmetic expression in a reverse polish notation.
 The answer and all the intermediate calculations can be represented in a 32-bit integer.
   
 */

/*
 ALGORITHM !!!
 
 if current == number {
 numbersStack.push(current)
 } else {
 second = numberStack.top
 numberStack.pop
 first = numberStack.top
 numberStack.pop
 numberStack.push(first operand second)
 }
 
 */

import Foundation

class Solution {
    // First Code
    func evalRPN(_ tokens: [String]) -> Int {
        let stack = Stack<Int>()
        
        for t in tokens {
            if let number = Int(t) {
                stack.push(number)
            } else {
                guard let first = stack.topThenPop() else { continue }
                guard let second = stack.topThenPop() else { continue }
                switch t {
                case "+": stack.push(first + second)
                case "-": stack.push(second - first)
                case "*": stack.push(first * second)
                case "/": stack.push(second / first)
                    default: break
                }
            }
        }
        
        return stack.top()!
    }
}


class Stack<T> {
    private var stack = [T]()
    
    func push(_ item: T?) {
        guard let item else { return }
        stack.insert(item, at: 0)
    }
    
    func pop() {
        stack.removeFirst()
    }
    
    func top() -> T? {
        return stack.first
    }
    
    func topThenPop() -> T? {
        guard let top = top() else { return nil }
        pop()
        return top
    }
}

import XCTest

class Test: XCTestCase {
    let solution = Solution()
    func test1() {
        let tokens: [String] = ["2","1","+","3","*"]
        let expectedOutput = 9
        let evalRPN = solution.evalRPN(tokens)
        XCTAssertEqual(evalRPN, expectedOutput)
    }
    
    func test2() {
        let tokens: [String] = ["4","13","5","/","+"]
        let expectedOutput = 6
        let evalRPN = solution.evalRPN(tokens)
        XCTAssertEqual(evalRPN, expectedOutput)
    }
    
    func test3() {
        let tokens: [String] = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
        let expectedOutput = 22
        let evalRPN = solution.evalRPN(tokens)
        XCTAssertEqual(evalRPN, expectedOutput)
    }
}

//Solution().evalRPN(["2","1","+","3","*"])

Test.defaultTestSuite.run()



/* MANUAL RUN !!!
 numbersStack
 operandsStack
 ["4","13","5","/","+"]
 
 i = 0
 numbersStack = []
 operandsStack = []
 current is number
 numbersStack.isEmpty {
 we push tokens[0] to numbersStack
 continue
 }
 ----------------------------------------------------------
 i = 1
 numbersStack = [4]
 operandsStack = []
 we push current tokens[i] to numbersStack
 continue
 ----------------------------------------------------------
 i = 2
 numbersStack = [13, 4]
 operandsStack = []
 current is number { we push current to numbersStack }
 
 ----------------------------------------------------------
 i = 3
 numbersStack = [5, 13, 4]
 operandsStack = []
 current isOperand = "/"
 second = numbersStack.top = 5
 numbersStack.pop() ==> numbersStack = [13, 4]
 first = numberStack.top = 13
 numbersStack.pop() ==> numbersStack = [4]
 numberStack.push(first operand second) ==> numbersStack = [13/5 ,4] => [2, 4]
 ----------------------------------------------------------
 i = 4
 numbersStack = [2, 4]
 operandsStack = []
 current isOperand = "+"
 second = numbersStack.top = 2
 numbersStack.pop() ==> numbersStack = [4]
 first = numberStack.top = 4
 numbersStack.pop() ==> numbersStack = []
 numberStack.push(first operand second) ==> numbersStack = [2+4] => [6]
 
 
 
 return numberStack.top
 */



/*
 ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
 // // ((10 * (6 / ((9 + 3) * -11))) + 17) + 5 // //
 i = 0 ==> 10
 numbersStack = []
 operandsStack = []
 ----------------------------------------------------------
 i = 1  ==> 6
 numbersStack = [10]
 operandsStack = []
 ----------------------------------------------------------
 i = 2 ==> 9
 numbersStack = [6,10]
 operandsStack = []
 ----------------------------------------------------------
 i = 3 ==> 3
 numbersStack = [9,6,10]
 operandsStack = []
 ----------------------------------------------------------
 i = 4 ==> +
 numbersStack = [3,9,6,10]
 operandsStack = []
 first = 9
 second = 3
 total = 12
 ----------------------------------------------------------
 i = 5 ==> -11
 numbersStack = [12,6,10]
 operandsStack = []
 ----------------------------------------------------------
 i = 6 ==> *
 numbersStack = [-11,12,6,10]
 operandsStack = []
 first = 12
 second = -11
 total = -132
 ----------------------------------------------------------
 i = 7 ==> /
 
 ----------------------------------------------------------
 i = 8 ==> *
 
 ----------------------------------------------------------
 i = 9 ==> 17
 
 ----------------------------------------------------------
 i = 10 ==> +
 
 ----------------------------------------------------------
 i = 11 ==> 5
 
 ----------------------------------------------------------
 i = 12 ==> +
 
 */
