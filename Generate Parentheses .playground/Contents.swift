
/**
 Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

  

 Example 1:

 Input: n = 3
 Output: ["((()))","(()())","(())()","()(())","()()()"]
 Example 2:

 Input: n = 1
 Output: ["()"]
  

 Constraints:

 1 <= n <= 8
 */
import Foundation

class Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        
        var stack = [String()]
        var possibilities = [String]()
        
        func backtrack(openCount: Int, closedCount: Int) {
            print("stack \(stack)")
            if openCount == n && closedCount == n {
                // we append the stack to the possibilities
                //and we return
                possibilities.append(stack.joined())
                return
            }
            
            if openCount < n {
                // we can add an open parenthesis
                stack.append("(")
                // we increment openCount
                // call again generatePossibility with new openCount and closedCount
                backtrack(openCount: openCount + 1, closedCount: closedCount)
                stack.removeLast()
            }
            
            if closedCount < openCount {
                // we can add a closed parenthesis
                stack.append(")")
                // we increment closedCount
                // call again generatePossibility with new openCount and closedCount
                backtrack(openCount: openCount, closedCount: closedCount + 1)
                stack.removeLast()
            }
        }
        backtrack(openCount: 0, closedCount: 0)
        
        return possibilities
    }
}

let n = 2
let expectedOutput = ["((()))","(()())","(())()","()(())","()()()"]

let output = Solution().generateParenthesis(n)
print("Output \n\(output)")

import XCTest
class Test: XCTestCase {
    let solution = Solution()
    
    func test1() {
        let n = 3
        let expectedOutput = ["((()))","(()())","(())()","()(())","()()()"]
        let output = solution.generateParenthesis(n)
        XCTAssertEqual(output, expectedOutput)
    }
    
    func test2() {
        let n = 1
        let expectedOutput = ["()"]
        let output = solution.generateParenthesis(n)
        XCTAssertEqual(output, expectedOutput)
    }
}

Test.defaultTestSuite.run()
