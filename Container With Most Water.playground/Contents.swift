/*
 You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).
 
 Find two lines that together with the x-axis form a container, such that the container contains the most water.
 
 Return the maximum amount of water a container can store.
 
 Notice that you may not slant the container.
 
 */

class Solution {
    
    
    /*
     // BRUT FORCE METHOD
     func maxArea(_ height: [Int]) -> Int {
     var maxArea = 0
     
     for left in 0...height.count - 1 {
     if left > 0 && height[left] < height[left - 1] { continue }
     for right in left..<height.count where left != right {
     print("Left \(left) | Right \(right)")
     let width = right - left
     let height = min(height[right], height[left])
     let area = width * height
     maxArea = max(maxArea, area)
     }
     }
     
     return maxArea
     }
     */
    /*
    // O(n) solution
    func maxArea(_ height: [Int]) -> Int {
        var maxArea = 0
        
        var left = 0, right = height.count - 1
        
        while left < right {
            let area = (right - left) * min(height[left], height[right])
            maxArea = max(maxArea, area)
            
            if height[left] < height[right] {
                left += 1
            } else if height[left] > height[right] {
                right -= 1
            } else {
                if height[left + 1] > height[right - 1] {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        
        return maxArea
    }
    */
    
    // Shorter Solution
    func maxArea(_ height: [Int]) -> Int {
        var result = 0
        var l = 0, r = height.count - 1
        
        while l < r {
            result = max(result, min(height[l], height[r]) * (r - l))
            height[l] < height[r] ? (l += 1) : (r -= 1)
        }
        return result
    }
    
}


import XCTest

class Tests: XCTestCase {
    
    private let solution = Solution()
    
    // The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7].
    // In this case, the max area of water (blue section) the container can contain is 49.
    
    // Example 1:
    /*
     Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
     */
    func test1() {
        let height1 = [1,8,6,2,5,4,8,3,7]
        let output1 = 49
        let value = solution.maxArea(height1)
        XCTAssertEqual(value, output1)
    }
    
    // Example 2:
    func test2() {
        let height2 = [1,1]
        let output2 = 1
        let value = solution.maxArea(height2)
        XCTAssertEqual(value, output2)
    }
    
    // Example 3:
    func test3() {
        let height3 = [4,3,2,1,4]
        let output3 = 16
        let value = solution.maxArea(height3)
        XCTAssertEqual(value, output3)
    }
}

Tests.defaultTestSuite.run()
print("All Tests are passing 🎉")
