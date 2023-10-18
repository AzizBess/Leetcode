/*
 49. Group Anagrams
 Medium
 17.4K
 514
 Companies
 Given an array of strings strs, group the anagrams together. You can return the answer in any order.
 
 An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.
 
 
 
 Example 1:
 
 Input: strs = ["eat","tea","tan","ate","nat","bat"]
 Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
 Example 2:
 
 Input: strs = [""]
 Output: [[""]]
 Example 3:
 
 Input: strs = ["a"]
 Output: [["a"]]
 
 
 Constraints:
 
 1 <= strs.length <= 104
 0 <= strs[i].length <= 100
 strs[i] consists of lowercase English letters.
 */


// Working Solution
func groupAnagrams(_ strs: [String]) -> [[String]] {
    var hash = [String: [String]]()
    
    strs.sorted().forEach {
        hash[String($0.sorted()), default: []].append($0)
    }
    
    return hash.map { $0.value }
}

// One Liner
func groupAnagramsOneLiner(_ strs: [String]) -> [[String]] {
    strs.sorted().reduce(into: [String: [String]]()) { $0[String($1.sorted()), default: []].append($1) }.map { $0.value }
}



let strs = ["eat","tea","tan","ate","nat","bat"]
groupAnagrams(strs)

//func isValidAnagram(_ s: String, t: String) {
//    s.reduce(into: [Character: Int]()) { $0[$0, default: 0] += 1 } == t.reduce(into: [Character: Int]()) { $0[$0, default: 0] += 1 }
//}
