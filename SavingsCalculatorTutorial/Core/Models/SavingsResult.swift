//
//  SavingsResult.swift
//  SavingsCalculator
//
//  Created by Stephan Dowless on 10/17/25.
//

import Foundation

struct SavingsResult: Hashable {
    let initialDeposit: Double
    let totalContributions: Double
    let interestEarned: Double
    let totalSaved: Double
    let numberOfYears: Int
}
