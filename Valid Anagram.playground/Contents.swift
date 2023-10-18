/*
 242. Valid Anagram
 Easy
 
 Given two strings s and t, return true if t is an anagram of s, and false otherwise.
 
 An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.
 
 
 
 Example 1:
 
 Input: s = "anagram", t = "nagaram"
 Output: true
 Example 2:
 
 Input: s = "rat", t = "car"
 Output: false
 
 
 Constraints:
 
 1 <= s.length, t.length <= 5 * 104
 s and t consist of lowercase English letters.
 
 
 Follow up: What if the inputs contain Unicode characters? How would you adapt your solution to such a case?
 */

func isAnagram(_ s: String, _ t: String) -> Bool {
    s.reduce(into: [Character: Int]()) { $0[$1, default: 0] += 1 } == t.reduce(into: [Character: Int]()) { $0[$1, default: 0] += 1 }    
}

let s1 = "anagram", t1 = "nagaram"
let s2 = "rat", t2 = "car"

assert(isAnagram(s1, t1) == true)
assert(isAnagram(s2, t2) == false)
