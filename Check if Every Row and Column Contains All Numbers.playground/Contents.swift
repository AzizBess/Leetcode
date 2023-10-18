/*
 An n x n matrix is valid if every row and every column contains all the integers from 1 to n (inclusive).

 Given an n x n integer matrix matrix, return true if the matrix is valid. Otherwise, return false.


 */

func checkValid(_ matrix: [[Int]]) -> Bool {
    for i in matrix.indices {
        let rows = matrix[i]
        let cols = matrix.map { $0[i] }
        
        if Set(rows).count != rows.count || Set(cols).count != cols.count {
            return false
        }
    }
    
    return true
}


//Example 1:

let matrix1 = [[1,2,3],[3,1,2],[2,3,1]]
let output1 = true
/*
 Explanation: In this case, n = 3, and every row and column contains the numbers 1, 2, and 3.
Hence, we return true.
 */

//Example 2:
let matrix2 = [[1,1,1],[1,2,3],[1,2,3]]
let output2 = false
/*
 Explanation: In this case, n = 3, but the first row and the first column do not contain the numbers 2 or 3.
 Hence, we return false.
 
 */

assert(checkValid(matrix1) == output1, "First Test Case is not passing")
assert(checkValid(matrix2) == output2, "Second Test Case is not passing")

print("All tests are passing 🎉")

