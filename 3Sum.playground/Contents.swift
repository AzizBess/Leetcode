/*
 15. 3Sum
 Medium
 
 28802
 
 2592
 
 Add to List
 
 Share
 Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.
 
 Notice that the solution set must not contain duplicate triplets.
 
 
 
 Example 1:
 
 Input: nums = [-1,0,1,2,-1,-4]
 Output: [[-1,-1,2],[-1,0,1]]
 Explanation:
 nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
 nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
 nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
 The distinct triplets are [-1,0,1] and [-1,-1,2].
 Notice that the order of the output and the order of the triplets does not matter.
 Example 2:
 
 Input: nums = [0,1,1]
 Output: []
 Explanation: The only possible triplet does not sum up to 0.
 Example 3:
 
 Input: nums = [0,0,0]
 Output: [[0,0,0]]
 Explanation: The only possible triplet sums up to 0.
 */

func threeSum(_ nums: [Int]) -> [[Int]] {
    var solutions = [[Int]]()
    var nums = nums.sorted()
    
    for i in nums.indices {
        if i > 0  && nums[i-1] == nums[i] { continue }
        var left = i + 1, right = nums.count - 1
        while left < right {
            let threeSum = nums[left] + nums[right] + nums[i]
            if threeSum < 0 {
                left += 1
            } else if threeSum > 0 {
                right -= 1
            } else {
                solutions.append([nums[i], nums[left], nums[right]])
                left += 1
                while nums[left] == nums[left - 1] && left < right {
                    left += 1
                }
            }
        }
    }
    return solutions
}


assert(threeSum([-1,0,1,2,-1,-4]) == [[-1,-1,2],[-1,0,1]], "Example 1 is not passing the test")
assert(threeSum([0,1,1]) == [], "Example 2 is not passing the test")
assert(threeSum([0,0,0]) == [[0,0,0]], "Example 3 is not passing the test")

print("All test are passing")
