/*
 
 Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
 
 An input string is valid if:
 
 Open brackets must be closed by the same type of brackets.
 Open brackets must be closed in the correct order.
 Every close bracket has a corresponding open bracket of the same type.
 
 
 Example 1:
 
 Input: s = "()"
 Output: true
 Example 2:
 
 Input: s = "()[]{}"
 Output: true
 Example 3:
 
 Input: s = "(]"
 Output: false
 
 */


class Solution {
    func isValid(_ s: String) -> Bool {
        guard s.count % 2 == 0 else { return false }
        var stack = [Character]()
        let dict: [Character : Character] = [
            "(" : ")",
            "[" : "]",
            "{" : "}"
        ]
        for c in s {
            if let closing = dict[c] {
                stack.insert(closing, at: 0)
            } else {
                if c != stack.first {
                    return false
                } else {
                    stack.removeFirst()
                }
            }
        }
        
        return stack.isEmpty
    }
}

import XCTest

class Tests: XCTestCase {
    
    private let solution = Solution()

    // Example 1
    func test1() {
        let s = "()"
        let output = true
        let value = solution.isValid(s)
        XCTAssertEqual(value, output)
    }

    // Example 2:
    func test2() {
        let s = "()[]{}"
        let output = true
        let value = solution.isValid(s)
        XCTAssertEqual(value, output)
    }

    // Example 3:
    func test3() {
        let s = "()[]{}"
        let output = false
        let value = solution.isValid(s)
        XCTAssertEqual(value, output)
    }
    
    // Example 4:
    func test4() {
        let s = "["
        let output = false
        let value = solution.isValid(s)
        XCTAssertEqual(value, output)
    }
    
    // Example 5:
    func test5() {
        let s = "(("
        let output = false
        let value = solution.isValid(s)
        XCTAssertEqual(value, output)
    }
    
    // Example 6:
    func test6() {
        let s = "({[]})"
        let output = true
        let value = solution.isValid(s)
        XCTAssertEqual(value, output)
    }
    
    // Example 7:
    func test7() {
        let s = "({[}])"
        let output = false
        let value = solution.isValid(s)
        XCTAssertEqual(value, output)
    }
}

Tests.defaultTestSuite.run()
print("All Tests are passing 🎉")
