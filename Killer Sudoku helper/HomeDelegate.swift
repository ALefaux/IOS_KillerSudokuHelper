//
//  HomeProtocol.swift
//  Killer Sudoku helper
//
//  Created by Axel Lefaux on 20/07/2021.
//

import Foundation

protocol HomeDelegate {
    func setNotUsedTerms(notUsedTerms: [Int])
    func setNeededTerms(neededTerms: [Int])
}
