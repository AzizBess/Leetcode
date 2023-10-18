/*
 Given an array nums of size n, return the majority element.
 
 The majority element is the element that appears more than ⌊n / 2⌋ times. You may assume that the majority element always exists in the array.
 
 
 
 Example 1:
 
 Input: nums = [3,2,3]
 Output: 3
 Example 2:
 
 Input: nums = [2,2,1,1,1,2,2]
 Output: 2
 
 
 Constraints:
 
 n == nums.length
 1 <= n <= 5 * 104
 -109 <= nums[i] <= 109
 */


func majorityElement(_ nums: [Int]) -> Int {
    //    nums.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
    //        .reduce(into: Int()) {
    //            $0 = max($0, $1.value)
    //        }
//    var max = 0
//    var majority = nums.first ?? 0
//    let dict = nums.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
//    print("Dict \(dict)")
//    dict.forEach { key, value in
//        if value > max {
//            max = value
//        } else {
//            majority = key
//        }
//    }
//    return majority
    
//    let dict = nums.sorted().reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
//        
//    return dict.first(where: { $0.value == dict.values.max() })?.key ?? 0
    
    let dict = nums.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
    
    let maxVal = dict.values.max()
    
    return dict.first(where: { $0.value == maxVal })?.key ?? 0
    
    
}

let nums1 = [3,2,3]
//==>Output: 3

let nums2 = [2,2,1,1,1,2,2]
//==>Output: 2

majorityElement(nums2)

//assert(majorityElement(nums1) == 3)
//assert(majorityElement(nums2) == 2)
//print("All GOOD")
