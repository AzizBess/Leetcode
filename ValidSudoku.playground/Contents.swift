/*
 
 36. Valid Sudoku
 Medium
 9.8K
 1K
 Companies
 Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:

 Each row must contain the digits 1-9 without repetition.
 Each column must contain the digits 1-9 without repetition.
 Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.
 Note:

 A Sudoku board (partially filled) could be valid but is not necessarily solvable.
 Only the filled cells need to be validated according to the mentioned rules.
 
 */

func isValidSudoku(_ board: [[Character]]) -> Bool {
        var rows = [Int : Set<Character>](), cols = rows
        var squares = [[Int] : Set<Character>]()
        
        for r in 0..<9 {
            for c in 0..<9 {
                if board[r][c] == "." { continue }
                let rowsCondition = rows[r, default: []].insert(board[r][c]).inserted
                let colsCondition = cols[c, default: []].insert(board[r][c]).inserted
                let squaresCondition = squares[[r / 3, c / 3], default: []].insert(board[r][c]).inserted
                if !rowsCondition || !colsCondition || !squaresCondition {
                    return false
                }
            }
        }
        return true
    }

let board1: [[Character]] = [["5","3",".",".","7",".",".",".","."]
              ,["6",".",".","1","9","5",".",".","."]
              ,[".","9","8",".",".",".",".","6","."]
              ,["8",".",".",".","6",".",".",".","3"]
              ,["4",".",".","8",".","3",".",".","1"]
              ,["7",".",".",".","2",".",".",".","6"]
              ,[".","6",".",".",".",".","2","8","."]
              ,[".",".",".","4","1","9",".",".","5"]
              ,[".",".",".",".","8",".",".","7","9"]]

let board2: [[Character]] = [["8","3",".",".","7",".",".",".","."]
              ,["6",".",".","1","9","5",".",".","."]
              ,[".","9","8",".",".",".",".","6","."]
              ,["8",".",".",".","6",".",".",".","3"]
              ,["4",".",".","8",".","3",".",".","1"]
              ,["7",".",".",".","2",".",".",".","6"]
              ,[".","6",".",".",".",".","2","8","."]
              ,[".",".",".","4","1","9",".",".","5"]
              ,[".",".",".",".","8",".",".","7","9"]]

assert(isValidSudoku(board1) == true, "Example 1 is passing the tests")
assert(isValidSudoku(board2) == false, "Example 1 is passing the tests")
