/*
 Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order, find two numbers such that they add up to a specific target number. Let these two numbers be numbers[index1] and numbers[index2] where 1 <= index1 < index2 < numbers.length.
 
 Return the indices of the two numbers, index1 and index2, added by one as an integer array [index1, index2] of length 2.
 
 The tests are generated such that there is exactly one solution. You may not use the same element twice.
 
 Your solution must use only constant extra space.
 */

func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    var left = 0, right = numbers.count - 1
    
    while left < right {
        let sum = numbers[left] + numbers[right]
        if sum < target { left += 1 }
        else if sum > target { right -= 1 }
        else { return [left + 1, right + 1] }
    }
    return []
}

//Example 1:
let numbers1 = [2,7,11,15], target1 = 9
let output1 = [1,2]
//Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].

//Example 2:
let numbers2 = [2,3,4], target2 = 6
let output2 = [1,3]
//Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].

//Example 3:
let numbers3 = [-1,0], target3 = -1
let output3 = [1,2]
//Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2. We return [1, 2].

assert(twoSum(numbers1, target1) == output1, "First Test case is not passing")
assert(twoSum(numbers2, target2) == output2, "Second Test case is not passing")
assert(twoSum(numbers3, target3) == output3, "Third Test case is not passing")

print("All tests are passing 🎉")
