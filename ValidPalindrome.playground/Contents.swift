/*
 A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.
 
 Given a string s, return true if it is a palindrome, or false otherwise.
 
 
 
 Example 1:
 
 Input: s = "A man, a plan, a canal: Panama"
 Output: true
 Explanation: "amanaplanacanalpanama" is a palindrome.
 Example 2:
 
 Input: s = "race a car"
 Output: false
 Explanation: "raceacar" is not a palindrome.
 Example 3:
 
 Input: s = " "
 Output: true
 Explanation: s is an empty string "" after removing non-alphanumeric characters.
 Since an empty string reads the same forward and backward, it is a palindrome.
 */


func isPalindrome(_ s: String) -> Bool {
    guard s.count > 1 else {return true}
    var s = s.lowercased().filter { $0.isNumber || $0.isLetter }
    var left = 0
    var right = s.count - 1
    
    while left < right {
        if s[s.index(s.startIndex, offsetBy: left)] != s[s.index(s.startIndex, offsetBy: right)] {
            return false
        }
        left += 1
        right -= 1
    }
    return true
}


let s1 = "A man, a plan, a canal: Panama"
let s2 = "race a car"
let s3 = " "
assert(isPalindrome(s1) == true)
assert(isPalindrome(s2) == false)
assert(isPalindrome(s3) == true)

print("All Tests are passing 🎉")
