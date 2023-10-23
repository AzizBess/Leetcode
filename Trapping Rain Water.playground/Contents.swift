/*
 
Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.

 Example 1:
 Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
 Output: 6
 Explanation: The above elevation map (black section) is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped.
 
 Example 2:
 Input: height = [4,2,0,3,2,5]
 Output: 9
 */
class Solution {
    // O(n) Memory solution
    func trap(_ height: [Int]) -> Int {
        guard height.count > 2 else { return 0 }
        var sum = 0

        var maxLeft = Array(repeating: 0, count: height.count)
        var maxRight = maxLeft
        let endIndex = height.count - 1

        for i in 1...endIndex {
            maxLeft[i] = max(maxLeft[i - 1], height[i - 1])
            maxRight[endIndex - i] = max(maxRight[endIndex - i + 1], height[endIndex - i + 1])
        }

        for i in height.indices {
            let value = min(maxLeft[i], maxRight[i]) - height[i]
            sum += value > 0 ? value : 0
        }

        return sum
    }
    
    // O(1) Memory solution
    func trapLinear(_ height: [Int]) -> Int {
        guard height.count > 2 else { return 0 }
        var sum = 0
        
        var left = 0, right = height.count - 1
        var maxLeft = height[left], maxRight = height[right]
        
        while left < right {
            if maxLeft <= maxRight {
                left += 1
                maxLeft = max(maxLeft, height[left])
                sum += maxLeft - height[left]
            } else {
                right -= 1
                maxRight = max(maxRight, height[right])
                sum += maxRight - height[right]
            }
        }
        
        return sum
    }
}

import XCTest

class Test: XCTestCase {
    let solution = Solution()
    
    func test1() {
        let height = [0,1,0,2,1,0,1,3,2,1,2,1]
        let output = 6
        let value = solution.trap(height)
        XCTAssertEqual(value, output)
    }
    
    func test2() {
        let height = [4,2,0,3,2,5]
        let output = 9
        let value = solution.trap(height)
        XCTAssertEqual(value, output)
    }
    
    func testLinear1() {
        let height = [0,1,0,2,1,0,1,3,2,1,2,1]
        let output = 6
        let value = solution.trapLinear(height)
        XCTAssertEqual(value, output)
    }
    
    func testLinear2() {
        let height = [4,2,0,3,2,5]
        let output = 9
        let value = solution.trapLinear(height)
        XCTAssertEqual(value, output)
    }
}

Test.defaultTestSuite.run()
