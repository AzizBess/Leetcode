
/*
 128. Longest Consecutive Sequence
 Medium
 18.5K
 839
 Companies
 Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.
 
 You must write an algorithm that runs in O(n) time.
 
 
 
 Example 1:
 
 Input: nums = [100,4,200,1,3,2]
 Output: 4
 Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.
 Example 2:
 
 Input: nums = [0,3,7,2,5,8,4,6,0,1]
 Output: 9
 */

/*// Good no bad
func longestConsecutive(_ nums: [Int]) -> Int {
    var longest = 0
    let hash = nums.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }

    Set(nums).forEach { num in
        // check if it's a start of a sequence : num - 1 does not exist
        if hash[num - 1] == nil {
            var length = 0
            while hash[num + length] != nil {
                length += 1
            }
            longest = max(longest, length)
        }
    }

    return longest

}
*/
func longestConsecutive(_ nums: [Int]) -> Int {
    var nums = Set(nums).sorted()
    guard nums.count > 1 else { return nums.count }
    var longest = 0
    var prev = nums[0]
    var length = 1
    for i in 1...nums.count - 1 {
        length = abs(nums[i] - prev) == 1 ? length + 1 : 1
        longest = max(length, longest)
        prev = nums[i]
    }
    longest = max(length, longest)
    
    return longest
}

let nums1 = [100,4,200,1,3,2]
let nums2 = [0,3,7,2,5,8,4,6,0,1]
let nums3 = [9,1,4,7,3,-1,0,5,8,-1,6]

assert(longestConsecutive(nums1) == 4, "error 1")
assert(longestConsecutive(nums2) == 9, "error 2")
assert(longestConsecutive(nums3) == 7, "error 2")
print("OK")
