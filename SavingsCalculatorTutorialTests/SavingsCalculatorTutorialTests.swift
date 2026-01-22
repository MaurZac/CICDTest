//
//  SavingsCalculatorTutorialTests.swift
//  SavingsCalculatorTutorialTests
//
//  Created by MaurZac on 14/01/26.
//
import Foundation
import Testing
@testable import SavingsCalculatorTutorial


struct SavingsCalculatorTutorialTests {

    @Test
    func zeroInterestZeroContributions()  throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let initialDeposit = SavingsCalxModel.defaultConfiguration.initialDeposit
        let model  = SavingsCalxModel(
            initialDeposit: 10_000,
            monthlyContribution: 0,
            annualInterestRate: 0,
            timePeriodInMonths: 24
        )
        let result  = model.calculateSavings()
        
        #expect(result.initialDeposit == 10_000)
        #expect(result.totalContributions == 0)
        #expect(result.interestEarned == 0)
        #expect(result.totalSaved == initialDeposit)
        #expect(result.numberOfYears == 2)
    }
    
    @Test
    func zeroInterestWithContributions()  throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let initialDeposit = SavingsCalxModel.defaultConfiguration.initialDeposit
        let monthlyContributions = SavingsCalxModel.defaultConfiguration.monthlyContribution
        let numMonths = SavingsCalxModel.defaultConfiguration.timePeriodInMonths
        let expectedTotalContriutions = monthlyContributions * Double(numMonths)
        
        let model  = SavingsCalxModel(
            initialDeposit: 10_000,
            monthlyContribution: monthlyContributions,
            annualInterestRate: 0,
            timePeriodInMonths: numMonths
        )
        let result  = model.calculateSavings()
        
        #expect(result.initialDeposit == 10_000)
        #expect(result.totalContributions == expectedTotalContriutions)
        #expect(result.interestEarned == 0)
        #expect(result.totalSaved == initialDeposit + expectedTotalContriutions)
        #expect(result.numberOfYears == numMonths / 12)
    }
    
    
    @Test("Only initial deposit, no interest, no contributions")
    func monthlyCompounding() throws {
        let initialDeposit = SavingsCalxModel.defaultConfiguration.initialDeposit
        let numMonths = SavingsCalxModel.defaultConfiguration.timePeriodInMonths
        let interestRate = SavingsCalxModel.defaultConfiguration.annualInterestRate / 100.0
        let model  = SavingsCalxModel(
            initialDeposit: 10_000,
            monthlyContribution: 0,
            annualInterestRate: interestRate,
            timePeriodInMonths: numMonths
        )
        
        let result  = model.calculateSavings()
        
        let monthlyRate = interestRate / 12.0
        let exepected = initialDeposit * pow(1 + monthlyRate, Double(numMonths))
        
        
        #expect(result.totalContributions == 0)
        #expect(result.totalSaved.isApproximatelyEqual(to: exepected))
        #expect(result.interestEarned.isApproximatelyEqual(to: exepected - initialDeposit))
        
    }
    
    @Test
    func depositContributionsWithInterest() throws {
        let model  = SavingsCalxModel.defaultConfiguration
        let result  = model.calculateSavings()
        let monthlyRate = (model.annualInterestRate / 12.0)
        
        var total = model.initialDeposit
        
        for _ in 0..<model.timePeriodInMonths {
            total += model.monthlyContribution
            total += total * monthlyRate
        }
        
        let contributions = model.monthlyContribution * Double(model.timePeriodInMonths)
        let interest = total - contributions - model.initialDeposit
        
        #expect(result.totalSaved.isApproximatelyEqual(to: total))
        #expect(result.totalContributions == contributions)
        #expect(result.interestEarned.isApproximatelyEqual(to: interest))
        #expect(result.numberOfYears == model.timePeriodInMonths / 12)
        
    }
    
    @Test
    func HashableAndEquatable() {
        let a = SavingsResult(
            initialDeposit: 100,
            totalContributions: 200,
            interestEarned: 50,
            totalSaved: 350,
            numberOfYears: 1
        )
        
        let b = SavingsResult(
            initialDeposit: 100,
            totalContributions: 200,
            interestEarned: 50,
            totalSaved: 350,
            numberOfYears: 1
        )
        
        let c = SavingsResult(
            initialDeposit: 100,
            totalContributions: 150,
            interestEarned: 60,
            totalSaved: 310,
            numberOfYears: 1
        )
        
        #expect(a == b)
        #expect(a.hashValue == b.hashValue)
        #expect(a != c)
        #expect(a.hashValue != c.hashValue)
    }

}
extension Double{
    func isApproximatelyEqual(to other: Double, tolerance: Double = 1e-6) -> Bool {
        if self == other { return true }
        return abs(self - other) <= tolerance * max(1.0, max(abs(self), abs(other)))
        
    }
}
