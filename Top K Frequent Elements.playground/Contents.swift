/*
 347. Top K Frequent Elements
 Medium
 16.1K
 583
 Companies
 Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.
 
 Example 1:
 
 Input: nums = [1,1,1,2,2,3], k = 2
 Output: [1,2]
 Example 2:
 
 Input: nums = [1], k = 1
 Output: [1]
 */


func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    nums.sorted { $0 > $1 }.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }.sorted { $0.1 > $1.1 }[..<k].map { $0.key }
}

let  nums = [1,1,1,2,2,3], k = 2
topKFrequent(nums, k)
