//
//  SavingsResultsView.swift
//  SavingsCalculator
//
//  Created by Stephan Dowless on 10/17/25.
//

import SwiftUI

struct SavingsResultsView: View {
    let result: SavingsResult
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Here's how your savings break down over time:")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 4)

                VStack(spacing: 12) {
                    ResultRowView(
                        title: "Initial Deposit",
                        value: result.initialDeposit,
                        color: .blue
                    )
                    
                    ResultRowView(
                        title: "Contributions",
                        value: result.totalContributions,
                        color: .pink
                    )
                    
                    ResultRowView(
                        title: "Interest Earned",
                        value: result.interestEarned,
                        color: .green
                    )
                }
                .padding(.top, 4)
                
                Divider()
                
                VStack(alignment: .trailing, spacing: 8) {
                    Text("Savings after \(result.numberOfYears) years:")
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    Text(result.totalSaved.formattedAsCurrency())
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

            }
            .padding()
        }
        .navigationTitle("Results")
    }
}

#Preview {
    NavigationStack {
        SavingsResultsView(
            result: .init(
                initialDeposit: 5000,
                totalContributions: 12000,
                interestEarned: 3000,
                totalSaved: 20000,
                numberOfYears: 10
            )
        )
    }
}
