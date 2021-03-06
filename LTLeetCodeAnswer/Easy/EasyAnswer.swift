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

        print(divide(10, 3))
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


extension EasyAnswer {
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }
    // answer1:  24ms  击败了百分百的小伙伴 我就问 还有谁！！！ 好吧 代码太臭太长了
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

    // answer2: 24 or 20 ms 来自剑哥大佬的思路
    func mergeTwoLists2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        guard let l1 = l1 else {
            return l2
        }
        
        guard let l2 = l2 else {
            return l1
        }
        
        // find first node
        let firstNode: ListNode = l1.val < l2.val ? l1 : l2
        var targetNode: ListNode? = l1.val < l2.val ? l2 : l1
        
        var baseNode = firstNode
        
        while targetNode != nil {
            
            // find insert node
            while baseNode.next != nil, baseNode.next!.val < targetNode!.val {
                baseNode = baseNode.next!
            }
            
            // insert target node
            let nextDealNode = targetNode?.next
            targetNode?.next = baseNode.next
            baseNode.next = targetNode
            baseNode = targetNode!
            
            // deal next target node
            targetNode = nextDealNode
        }
        
        return firstNode
    }
}


// MARK: 26. Remove Duplicates from Sorted Array
extension EasyAnswer {
    
    // 44 ms  beat 64%
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        
        guard nums.count > 1 else {
            return nums.count
        }
        
        var i = 1
        
        for index in 1 ... nums.count - 1 {
            let currentNum = nums[index]
            if currentNum != nums[index - 1] {
                nums[i] = currentNum
                i = i + 1
            }
        }
        return i
    }
    
}

// MARK: 27. Remove Element
extension EasyAnswer {
    // 12ms beat 95%
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var i = 0
        for index in 0 ..< nums.count {
            let curNum = nums[index]
            if curNum != val {
                nums[i] = curNum
                i += 1
            }
        }
        return i
    }
}

// MARK: 28. Implement strStr()
extension EasyAnswer {
    
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        if let range = haystack.range(of: needle) {
            return range.lowerBound.encodedOffset
        } else {
            return -1
        }
    }
    
}

// MARK: 29. Divide Two Integers
extension EasyAnswer {
    
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        
        if divisor == 0 || (dividend == Int32.min && divisor == -1) {
            return Int(Int32.max)
        }
        
        let p = dividend * divisor < 0 ? -1 : 1
        
        var num = 0
        var dvd = labs(dividend)
        let dvs = labs(divisor)
        
        while dvd >= dvs {
            var temp = dvs
            var count = 1
            while dvd > (temp << 1) {
                count = count << 1
                temp = temp << 1
            }
            dvd -= temp
            num += count
        }
        
        return num * p
    }
    
}

// MARK: 35. Search Insert Position
extension EasyAnswer {
    
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        
        for index in 0 ..< nums.count {
            
            if target <= nums[index] {
                return index
            }
            
        }
        
        return nums.count
    }
    
}

// MARK: 53. Maximum Subarray
extension EasyAnswer {
    
    func maxSubArray(_ nums: [Int]) -> Int {
        
        guard nums.count > 0 else {
            return 0
        }
        
        var max = nums[0]
        var sum = nums[0]
        
        for index in 1 ..< nums.count {
            
            if sum < 0 {
                sum = nums[index]
            } else {
                sum += nums[index]
            }
            max = max > sum ? max : sum
        }
        return max
    }
    
}

// MARK: 69. Sqrt(x)
extension EasyAnswer {
    // answer1 188ms beats 12.73%
    func mySqrt(_ x: Int) -> Int {
        
        guard x > 1 else {
            if x == 0 {
                return 0
            }
            return 1
        }
        
        var num = 1
        
        while num * num <= x {
            num += 1
        }
        
        return num - 1
    }
    // answer2 24ms
    func mySqrt1(_ x: Int) -> Int {
    
        guard x > 1 else {
            return x
        }
        
        var left = 0
        var right = x
        
        while left < right - 1 {
            
            let middle = (left + right) / 2
            let middle_d = middle * middle
            if middle_d == x {
                return middle
            } else if middle_d < x {
                left = middle
            } else {
                right = middle
            }
            
        }
        return left
    }
}

// MARK: 70. Climbing Stairs
extension EasyAnswer {
    
    func climbStairs(_ n: Int) -> Int {
        
        guard n != 1 else {
            return 1
        }
        
        guard n != 2 else {
            return 2
        }
        
        var oneStepBefore = 2
        var twoStepBefore = 1
        var allWays = 0
        
        for _ in 2 ..< n {
            
            allWays = oneStepBefore + twoStepBefore
            twoStepBefore = oneStepBefore
            oneStepBefore = allWays
            
        }
        return allWays
        
    }
    
}

// MARK: 88. Merge Sorted Array
extension EasyAnswer {
    // 这个题目 的输入有点问题 [1,0] 1  [2] 1  差评!!!
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        if n == 0 {
            return
        }
        
        if m == 0 {
            nums1 = nums2
            return
        }
        

        var m = m - 1
        
        for index in (0 ... n - 1).reversed() {
            
            while nums1[m] > nums2[index] && m != 0 {
                m -= 1
            }
            nums1.insert(nums2[index], at: m == 0 ? 0 : m + 1)
            
        }
        
    }
    
}

// MARK: 101. Symmetric Tree
extension EasyAnswer {
    
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        
        func isMirror(_ t1: TreeNode?, _ t2: TreeNode?) -> Bool {
            
            if t1 == nil, t2 == nil {
                return true
            } else if t1 == nil || t2 == nil {
                return false
            }
            
            return t1?.val == t2?.val && isMirror(t1?.left, t2?.right) && isMirror(t1?.right, t2?.left)
            
        }
        
        return isMirror(root, root)
    }
    
    // MARK: 104. Maximum Depth of Binary Tree
    // 24 ms beat 100%
    func maxDepth(_ root: TreeNode?) -> Int {
        
        func maxDepth(_ root: TreeNode?, _ depth: Int) -> Int {
            
            if root == nil {
                return depth
            }
            let depth = depth + 1
            
            return max(maxDepth(root?.left, depth), maxDepth(root?.right, depth))
        }
        
        return maxDepth(root, 0)
        
    }
    
    // MARK: 108. Convert Sorted Array to Binary Search Tree
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        
        guard nums.count != 0 else {
            return nil
        }
        
        func helper(_ nums: [Int], _ left: Int, _ right: Int) -> TreeNode? {
            
            guard left <= right else {
                return nil
            }
            
            let mid = (left + right) / 2
            let midNode = TreeNode(nums[mid])
            
            midNode.left = helper(nums, left, mid - 1)
            midNode.right = helper(nums, mid + 1, right)
            
            return midNode
        }
        
        return helper(nums, 0, nums.count - 1)
        
    }
    
}

// MARK: 128. Plus One
extension EasyAnswer {
    
    func plusOne(_ digits: [Int]) -> [Int] {
        
        guard  digits.count > 0 else {
            return digits
        }
        var digits = digits
        var needPlus = true
        var index = digits.count - 1
        
        while needPlus == true {
            digits[index] += 1
            if digits[index] == 10 {
                digits[index] = 0
                needPlus = true
                
                if index == 0 {
                    needPlus = false
                    digits.insert(1, at: 0)
                }
                
                index -= 1
            } else {
                needPlus = false
            }
        }

        return digits
    }
    
}

// MARK: 136. Single Number
extension EasyAnswer {
    // 位运算 可以完美解决 通过异或操作
    class Solution {
        func singleNumber(_ nums: [Int]) -> Int {
            
            var single = 0
            
            for i in 0 ..< nums.count {
                single ^= nums[i]
            }
            
            return single
        }
    }
    
}

extension EasyAnswer {
    
    public class SingleTreeNode: NSObject{
        public var val: Int
        public var next: SingleTreeNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }
    // MARK:     141 Linked List Cycle
    func hasCircle(_ node: SingleTreeNode?) -> Bool {
        
        var curNode: SingleTreeNode? = node
        
        while curNode != nil {
            curNode = curNode?.next
            if curNode == node {
                return true
            }
        }
        return false
    }
    
    // MAKR: 160. Intersection of Two Linked Lists
    // a+c + b+c = b+c + a+c  保证了终点相同
    func getIntersectionNode(_ node1: SingleTreeNode?, _ node2: SingleTreeNode?) -> SingleTreeNode? {
        
        guard node1 != nil && node2 != nil else {
            return nil
        }
        
        var l1 = node1
        var l2 = node2
        while l1 != l2 {
            l1 = l1 == nil ? node2 : l1?.next
            l2 = l2 == nil ? node1 : l2?.next
        }
        return l1
    }
    
}

// MARK: 155. Min Stack 这里建议用链表实现  用数组在自动扩容时 效率很低
extension EasyAnswer {

    public class MinStack: NSObject {
        
        public var stackArray: [Int]
        
        public override init() {
            stackArray = [Int]()
        }
        
        func push(_ value: Int) {
            stackArray.append(value)
        }
        
        func pop() -> Int? {
            return stackArray.popLast()
        }
        
        func top() -> Int? {
            return stackArray.last
        }
        
        func getMin() -> Int? {
            guard stackArray.count > 0 else {
                return nil
            }
            
            var min = stackArray[0]
            
            for i in 1 ..< stackArray.count {
                let cur = stackArray[i]
                if cur < min {
                    min = cur
                }
            }
            return min
        }
        
    }
    
}

// MARK: 169. Majority Element
extension EasyAnswer {
    
    func majorityElement(_ nums: [Int]) -> Int {
        
        var count = 0
        var num = 0
        
        for i in 0 ..< nums.count {
            if count == 0 {
                num = nums[i]
                count += 1
            } else if nums[i] != num {
                count -= 1
            } else {
                count += 1
            }
            
        }
        return num
    }
    
}

// MARK: 171. Excel Sheet Column Number
extension EasyAnswer {
    // answer1 32ms
    func titleToNumber(_ s: String) -> Int {
        
        var result = 0
        
        for (i, c) in s.enumerated().reversed() {
            let num: UInt32 = UnicodeScalar(c.description)!.value - UnicodeScalar("A")!.value + 1
            result = result + Int(pow(26.0, Double(s.count - 1 - i)) * Double(num))
        }
        
        return result
    }
    
    // answer2
    func titleToNumber2(_ s: String) -> Int {
        
        var sum = 0
        for c in s.unicodeScalars {
            sum *= 26
            sum += (Int(c.value) - 65 + 1)
        }
        return sum
    }
    
}
