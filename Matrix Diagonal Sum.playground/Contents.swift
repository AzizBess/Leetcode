/*
 Given a square matrix mat, return the sum of the matrix diagonals.

 Only include the sum of all the elements on the primary diagonal and all the elements on the secondary diagonal that are not part of the primary diagonal.
 */


func diagonalSum(_ mat: [[Int]]) -> Int {
    let size = mat[0].count - 1
    var sum = 0
    
    for i in mat.indices {
        sum += mat[i][i] + (i != size - i ? mat[i][size - i] : 0)
    }
    
    return sum
}


//Example 1:
let mat1 = [[1,2,3],
              [4,5,6],
              [7,8,9]]
let output1 = 25
/*
 Explanation: Diagonals sum: 1 + 5 + 9 + 3 + 7 = 25
Notice that element mat[1][1] = 5 is counted only once.
 */

//Example 2:
let mat2 = [[1,1,1,1],
              [1,1,1,1],
              [1,1,1,1],
              [1,1,1,1]]
let output2 = 8

//Example 3:
let mat3 = [[5]]
let output3 = 5

assert(diagonalSum(mat1) == output1, "First Test Case is not passing")
assert(diagonalSum(mat2) == output2, "Second Test Case is not passing")
assert(diagonalSum(mat3) == output3, "Third Test Case is not passing")

print("All Tests are passing 🎉")
