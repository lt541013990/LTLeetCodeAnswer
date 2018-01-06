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
        let result = twoSum1([3, 3], 6)
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
    
}
