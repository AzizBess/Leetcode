/*
 Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].
 
 The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
 
 You must write an algorithm that runs in O(n) time and without using the division operation.
 
 */


func productExceptSelf(_ nums: [Int]) -> [Int] {
    
    var lp = [Int](repeating: 1, count: nums.count), rp = lp
    for i in nums.indices {
        lp[i] = i > 0 ? lp[i - 1] * nums[i - 1] : 1
        rp[nums.count - 1 - i] = i > 0 ? rp[nums.count - i] * nums[nums.count - i] : 1
    }
    
    for i in nums.indices {
        rp[i] *= lp[i]
    }
    
    return rp
}


//Example 1:
let nums1 = [1,2,3,4]
let output1 = [24,12,8,6]

//Example 2:
let nums2 = [-1,1,0,-3,3]
let output2 = [0,0,9,0,0]


assert(productExceptSelf(nums1) == output1, "First Test Case is not passing")
assert(productExceptSelf(nums2) == output2, "Second Test Case is not passing")


print("All Tests are passing 🎉")

