//
//  Double.swift
//  SavingsCalculator
//
//  Created by Stephan Dowless on 10/17/25.
//


import Foundation

extension Double {    
    func formattedAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
