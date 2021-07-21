//
//  Int-Extensions.swift
//  Killer Sudoku helper
//
//  Created by Axel Lefaux on 15/07/2021.
//

import Foundation

extension Array where Element == Int {
    func sum() -> Int {
        var result: Int = 0
        
        for term in self {
            result += term
        }
        
        return result
    }
    
    mutating func addAll(_ items: [Int]) {
        for item in items {
            self.append(item)
        }
    }
    
    mutating func removeAll(_ items: [Int]) {
        for item in items {
            if let index = self.firstIndex(of: item) {
                self.remove(at: index)
            }
        }
    }
}

extension Array where Element == [Int] {
    mutating func addAll(_ items: [[Int]]) {
        for item in items {
            self.append(item)
        }
    }
}
