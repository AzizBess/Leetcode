/*
 67. Add Binary
 Easy
 8.8K
 876
 Companies
 Given two binary strings a and b, return their sum as a binary string.
 
 
 
 Example 1:
 
 Input: a = "11", b = "1"
 Output: "100"
 Example 2:
 
 Input: a = "1010", b = "1011"
 Output: "10101"
 
 
 Constraints:
 
 1 <= a.length, b.length <= 104
 a and b consist only of '0' or '1' characters.
 Each string does not contain leading zeros except for the zero itself.
 */
/*
 
 func addBinary(_ a: String, _ b: String) -> String {
 
 var result = String()
 var first = String()
 var second = String()
 
 if a.count < b.count {
 // add zeros at the beginning of a
 first = prefixWithZeros(a: a, b: b)
 
 } else if b.count < a.count {
 // add zeros at the begging of b
 second = prefixWithZeros(a: b, b: a)
 }
 
 print("a => \(a)")
 print("b => \(b)")
 
 for i in a.indices {
 
 }
 
 
 if let a = a.convertToDecimal(), let b = b.convertToDecimal() {
 print("a \(a)")
 print("b \(b)")
 return (a + b).convertToBinaryString()
 }
 
 return ""
 
 //    (a.convertToDecimal() ?? 0 + (b.convertToDecimal() ?? 0)).convertToBinaryString()
 
 
 }
 */

func addBinary(_ a: String, _ b: String) -> String {
    var carry = 0
    var result = String()
    
    var a = String(a.reversed())
    var b = String(b.reversed())
    for i in 0...max(a.count, b.count) - 1 {
        let sum = Int(String((i <= a.count - 1) ? a[i] : "0"))! + Int(String((i <= b.count - 1) ? b[i] : "0"))!
        carry = sum / 2
        result.append(String(sum % 2))
    }
    
    if carry != 0 { result.append("1") }
    
    return String(result.reversed())
}

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
}

addBinary("1", "11")
//addBinary("1010", "1011")
