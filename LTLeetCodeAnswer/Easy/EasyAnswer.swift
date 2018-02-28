//
//  EasyAnswer.swift
//  LTLeetCodeAnswer
//
//  Created by BIGDIAO on 2018/1/6.
//  Copyright © 2018年 BIGDIAO. All rights reserved.
//

import Foundation

class EasyAnswer: NSObject {
    
    
    func execSolution() {
        let node1 = ListNode.init(1)
        node1.next = ListNode.init(2)
        node1.next?.next = ListNode.init(5)
        
        let node2 = ListNode.init(3)
        node2.next = ListNode.init(4)
        node2.next?.next = ListNode.init(6)
        
        let resultNode = mergeTwoLists(node1, node2)
        
    }
    
    // MARK: - 1.Two Sum
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        for x in 0 ... nums.count - 2 {
            let m = target - nums[x]
            for y in x+1 ... nums.count - 1 {
                if nums[y] == m {
                    return [x, y]
                }
            }
        }
        return [0, 0]
    }
    
    func twoSum1(_ nums: [Int], _ target: Int) -> [Int] {
        var arr = Array<Int>()
        for x in 0 ... nums.count - 1 {
            let m = target - nums[x]
            
            if arr.contains(m) {
                return [x, nums.index(of: m)!]
            }
            arr.append(nums[x])
        }
        return [0, 0]
    }
    
    // MARK: - 9.Palindrome Number
   
    func isPalindrome(_ x: Int) -> Bool {
        
        guard x >= 10 else {
            if x >= 0 {
                return true
            }
            return false
        }
        
        var numArray :Array = Array<Int>()
        
        var y = x
        while y != 0 {
            numArray.append(y % 10)
            
            y = y / 10
        }
        
        // answer1 253 ms
//        for m in 0 ... numArray.count / 2 - 1 {
//            if numArray[m] != numArray[numArray.count - m - 1] {
//                return false
//            }
//        }
        
        // answer2 284 ms
        var resultInt = 0
        for m in numArray {
            resultInt = resultInt * 10 + m
        }
        
        if resultInt == x {
            return true
        } else {
            return false
        }
        
    }
    // answer3 200 ms
    func isPalindrome2(_ x: Int) -> Bool {
        
        if x<0 {
            return false
        } else if x == 0 {
            return true
        } else {
            var temp = x
            var y = 0
            while temp > 0 {
                y = (y*10) + (temp%10)
                temp /= 10
            }
            return x == y
        }
        
    }
    
    // MARK: - Valid Parentheses
    
    // answer1: 我滴龟龟 效率是最慢滴 只击败了百分之1的小伙伴
    func isValid(_ s: String) -> Bool {
        var length = Int(s.count)
        guard length % 2 == 0 else {
            return false
        }
        
        var value = s.replacingOccurrences(of: "()", with: "").replacingOccurrences(of: "[]", with: "").replacingOccurrences(of: "{}", with: "")
        
        while length != Int(value.count) {
            length = Int(value.count)
            value = value.replacingOccurrences(of: "()", with: "").replacingOccurrences(of: "[]", with: "").replacingOccurrences(of: "{}", with: "")
        }
        
        return Int(value.count) == 0
    }
    
    // answer2
    func isValid2(_ s: String) -> Bool {
        var stack = [Character]()
        let dic: [Character: Character] = ["}": "{", "]": "[", ")": "("]
        
        let chars = dic.values
        for c in s {
            if chars.contains(c) {
                stack.append(c)
            } else if dic[c] != stack.popLast(){
                return false
            }
        }
        
        return stack.isEmpty
    }
    
}


// MARK: 21. Merge Two Sorted Lists

// answer1:  24ms  击败了百分百的小伙伴 我就问 还有谁！！！ 好吧 代码太臭太长了
extension EasyAnswer {
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }
    
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var l1 = l1
        var l2 = l2
        
        var resultNode: ListNode?
        
        
        if l1 == nil, l2 != nil {
            resultNode = ListNode.init(l2!.val)
            l2 = l2?.next
        } else if l2 == nil, l1 != nil {
            resultNode = ListNode.init(l1!.val)
            l1 = l1?.next
        } else if l1 != nil && l2 != nil {
            
            if l1!.val < l2!.val {
                resultNode = ListNode.init(l1!.val)
                l1 = l1?.next
            } else {
                resultNode = ListNode.init(l2!.val)
                l2 = l2?.next
            }
            
        }
        
        var node = resultNode
        
        while l1 != nil || l2 != nil {
            
            if l1 == nil, l2 != nil {
                
                node?.next = l2
                
                break
                
            } else if l2 == nil, l1 != nil {
                
                node?.next = l1
                
                break
                
            } else if l1 != nil && l2 != nil {
                
                if l1!.val < l2!.val {
                    
                    node?.next = ListNode.init(l1!.val)
                    l1 = l1?.next
                    
                } else {
                    
                    node?.next = ListNode.init(l2!.val)
                    l2 = l2?.next
                    
                }
                
            }
            node = node?.next
        }
        
        return resultNode
    }
}
