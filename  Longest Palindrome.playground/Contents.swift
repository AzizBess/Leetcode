/*
 Given a string s which consists of lowercase or uppercase letters, return the length of the longest palindrome that can be built with those letters.
 
 Letters are case sensitive, for example, "Aa" is not considered a palindrome here.
 
 Example 1:
 
 Input: s = "abccccdd"
 Output: 7
 Explanation: One longest palindrome that can be built is "dccaccd", whose length is 7.
 Example 2:
 
 Input: s = "a"
 Output: 1
 Explanation: The longest palindrome that can be built is "a", whose length is 1.
 */

/*
// Working version
func longestPalindrome(_ s: String) -> Int {
    var count = 0
    
    s.reduce(into: [Character: Int]()) { $0[$1, default: 0] += 1 }
        .forEach {
        if $0.value % 2 == 0 {
            count += $0.value
        } else {
            count += $0.value - 1
        }
    }
    return count + (count < s.count ? 1: 0)
}
*/

func longestPalindrome(_ s: String) -> Int {
    let count = s.reduce(into: [Character: Int]()) { $0[$1, default: 0] += 1 }
        .reduce(into: Int()) {
            $0 += $1.value - ( $1.value % 2 != 0 ? 1 : 0 )
        }
    return count + (count < s.count ? 1: 0)
}

//longestPalindrome("abccccdd")
longestPalindrome("a")
