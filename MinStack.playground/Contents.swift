/*
 
 Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

 Implement the MinStack class:

 MinStack() initializes the stack object.
 void push(int val) pushes the element val onto the stack.
 void pop() removes the element on the top of the stack.
 int top() gets the top element of the stack.
 int getMin() retrieves the minimum element in the stack.
 You must implement a solution with O(1) time complexity for each function.

  

 Example 1:

 Input
 ["MinStack","push","push","push","getMin","pop","top","getMin"]
 [[],[-2],[0],[-3],[],[],[],[]]

 Output
 [null,null,null,null,-3,null,0,-2]

 Explanation
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin(); // return -3
 minStack.pop();
 minStack.top();    // return 0
 minStack.getMin(); // return -2
 
 */
class MinStack {
    
    var stack: [(value: Int, minValue: Int)]
    
    init() {
        stack = [(value: Int, minValue: Int)]()
        
    }
    
    func push(_ val: Int) {
        stack.append((
            value: val,
            minValue: min(val, self.getMin())
        ))
    }
    
    func pop() {
        stack.removeLast()
    }
    
    func top() -> Int {
        stack.last?.value ?? -1
    }
    
    func getMin() -> Int {
        stack.last?.minValue ?? -1
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * let obj = MinStack()
 * obj.push(val)
 * obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Int = obj.getMin()
 */


//Your MinStack object will be instantiated and called as such:

let val = 2
let obj = MinStack()
obj.push(val)
obj.pop()
let ret_3: Int = obj.top()
let ret_4: Int = obj.getMin()
