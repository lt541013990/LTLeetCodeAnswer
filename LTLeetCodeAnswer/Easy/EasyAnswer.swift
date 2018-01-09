//
//  EasyAnswer.swift
//  LTLeetCodeAnswer
//
//  Created by BIGDIAO on 2018/1/6.
//  Copyright © 2018年 BIGDIAO. All rights reserved.
//

import Foundation

class EasyAnswer: NSObject {
    
    // MARK: - 1.Two Sum
    func execTowSumSolution() {
        let result = isPalindrome(-1)
        print(result)
    }
    
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
    
    // MARK: -9.Palindrome Number
   
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
    
}