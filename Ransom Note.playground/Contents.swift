/*
 Given two strings ransomNote and magazine, return true if ransomNote can be constructed by using the letters from magazine and false otherwise.
 
 Each letter in magazine can only be used once in ransomNote.
 
 
 
 Example 1:
 
 Input: ransomNote = "a", magazine = "b"
 Output: false
 Example 2:
 
 Input: ransomNote = "aa", magazine = "ab"
 Output: false
 Example 3:
 
 Input: ransomNote = "aa", magazine = "aab"
 Output: true
 */


//func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
//    let dictRansomNote = ransomNote.reduce(into: [Character: Int]()) { result, char in
//        result[char, default: 0] += 1
//    }
//    
//    let dictMagazine = magazine.reduce(into: [Character: Int]()) { result, char in
//        result[char, default: 0] += 1
//    }
//    
//    print("dictRansomNote = \(dictRansomNote)")
//    print("dictMagazine = \(dictMagazine)")
//    print("common = \(dictMagazine.filter({ dictRansomNote.keys.contains($0.key) }))")
//    
//    let common = dictMagazine
//        .filter { dictRansomNote.keys.contains($0.key) && dictRansomNote[$0.key] ?? 0 <= $0.value }
//    
//    print("common after = \(common)")
//    
//    return !common.isEmpty
//}

/*
// Dictionary Approach
func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {

    var dictMagazine = magazine.reduce(into: [Character: Int]()) { result, char in
        result[char, default: 0] += 1
    }
    
    for char in ransomNote {
        guard let value = dictMagazine[char], value > 0 else { return false }
        dictMagazine[char, default: 0] -= 1
    }
    
    return true
}
*/

// Index Removal Approach The BEST ONE
func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    var magazine = magazine
    for char in ransomNote {
        if let index = magazine.firstIndex(of: char) {
            magazine.remove(at: index)
        } else {
            return false
        }
    }
    return true
}


let ransomNote1 = "a", magazine1 = "b" //Output: false
let ransomNote2 = "aa", magazine2 = "ab" //Output: false
let ransomNote3 = "aa", magazine3 = "aab" //Output: true
let ransomNote4 = "bg", magazine4 = "efjbdfbdgfjhhaiigfhbaejahgfbbgbjagbddfgdiaigdadhcfcj"

assert(canConstruct(ransomNote1, magazine1) == false)
assert(canConstruct(ransomNote2, magazine2) == false)
assert(canConstruct(ransomNote3, magazine3) == true)
assert(canConstruct(ransomNote4, magazine4) == true)

print("Everything's Working Fine")

