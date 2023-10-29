/**
 739. Daily Temperatures
 Medium
 11.8K
 258
 Companies
 Given an array of integers temperatures represents the daily temperatures, return an array answer such that answer[i] is the number of days you have to wait after the ith day to get a warmer temperature. If there is no future day for which this is possible, keep answer[i] == 0 instead.

  

 Example 1:

 Input: temperatures = [73,74,75,71,69,72,76,73]
 Output: [1,1,4,2,1,1,0,0]
 Example 2:

 Input: temperatures = [30,40,50,60]
 Output: [1,1,1,0]
 Example 3:

 Input: temperatures = [30,60,90]
 Output: [1,1,0]
 */


class Solution {
    /*
    // BRUT FORCE O(n2)
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: temperatures.count)
        for i in temperatures.indices {
            for j in i...temperatures.count - 1 {
                if i != j && temperatures[j] > temperatures[i] {
                    result[i] = j - i
                    break
                }
            }
        }
        return result
    }
    
     // Stack Solution
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: temperatures.count)
        
        var stack = Stack<Int>()
        
        for index in temperatures.indices {
            while let top = stack.top(), temperatures[index] > temperatures[top] {
                result[top] = index - top
                stack.pop()
            }
            stack.push(index)
        }
        
        return result
    }
    */
    //No Stack Solution
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: temperatures.count)
        
        var stack = [Int]()
        
        for index in temperatures.indices {
            while !stack.isEmpty && temperatures[index] > temperatures[stack[0]] {
                result[stack[0]] = index - stack[0]
                stack.removeFirst()
            }
            stack.insert(index, at: 0)
        }
        
        return result
    }
}
/*
class Stack<T> {
    private var stack = [T]()
    
    func push(_ item: T) {
        stack.insert(item, at: 0)
    }
    
    func pop() {
        stack.removeFirst()
    }
    
    func top() -> T? {
        return stack.first
    }
}
*/
import XCTest
class Test: XCTestCase {
    let solution = Solution()
    
    func test1() {
        let temperatures = [73,74,75,71,69,72,76,73]
        let expectedOutput = [1,1,4,2,1,1,0,0]
        let output = solution.dailyTemperatures(temperatures)
        XCTAssertEqual(output, expectedOutput)
    }
    
    func test2() {
        let temperatures = [30,40,50,60]
        let expectedOutput = [1,1,1,0]
        let output = solution.dailyTemperatures(temperatures)
        XCTAssertEqual(output, expectedOutput)
    }
    
    func test3() {
        let temperatures = [30,60,90]
        let expectedOutput = [1,1,0]
        let output = solution.dailyTemperatures(temperatures)
        XCTAssertEqual(output, expectedOutput)
    }
    
}

Test.defaultTestSuite.run()


let temperatures = [73,74,75,71,69,72,76,73]
let expectedOutput = [1,1,4,2,1,1,0,0]
let output = Solution().dailyTemperatures(temperatures)

print(output)
