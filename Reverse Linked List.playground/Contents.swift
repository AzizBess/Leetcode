import Cocoa

var greeting = "Hello, playground"

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    
    public func toString() -> String {
        var result = String(val) + " ";
        if let next {
            result += next.toString();
        }
        return result;
    }
}

func reverseList2(_ head: ListNode?) -> ListNode? {
    guard var head = head, var next = head.next else { return head }
    
    (head, next) = (reverseList2(next)!, head)
    
    return head
}

//func reverseList(_ head: ListNode?) -> ListNode? {
//    
////    guard let head = head else {
////            return nil
////        }
////
////        guard let next = head.next else {
////            return head
////        }
//    
//    var prev: ListNode?
//    var cur: ListNode? = head
//    
//    if cur?.next == nil { return head }
//    
////    while cur != nil {
//    let tmp = reverseList(cur?.next) //cur?.next
//    cur?.next = prev
//    prev = cur
//    cur = tmp
////    }
//    return prev
//}

func reverseList(_ head: ListNode?) -> ListNode? {
    
    guard let head = head else {
        return nil
    }
    
    guard let next = head.next else {
        return head
    }
    
    let resultHead = reverseList(next)
    next.next = head
    head.next = nil
    
    return resultHead
}

let node = ListNode(1, ListNode(2, ListNode(3)))
print(reverseList2(node)!.toString())
