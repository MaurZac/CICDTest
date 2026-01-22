//
//  SavingsCalxView.swift
//  SavingsCalculator
//
//  Created by Stephan Dowless on 10/17/25.
//

import SwiftUI

struct SavingsCalxView: View {
    @FocusState private var focusedField: FocusField?
    
    @State private var initialDeposit = ""
    @State private var monthlyContribution = ""
    @State private var interestRate = ""
    @State private var timePeriodInYears = ""
    @State private var result: SavingsResult?
    @State private var viewDidLoad = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    TextInputView("Initial Deposit", text: $initialDeposit)
                        .focused($focusedField, equals: .initialDeposit)
                    
                    TextInputView("Monthly Contribution",text: $monthlyContribution)
                        .focused($focusedField, equals: .monthlyContribution)
                    
                    TextInputView(
                        "Time Period (years)",
                        inputType: .number,
                        text: $timePeriodInYears
                    )
                    .focused($focusedField, equals: .timePeriodInYears)
                    
                    TextInputView(
                        "Annual Yield",
                        inputType: .decimal,
                        text: $interestRate
                    )
                    .focused($focusedField, equals: .interestRate)
                }
                .onChange(of: focusedField) { oldValue, newValue in
                    onFocusChange(newValue)
                }
            }
            .navigationTitle("Savings Calculator")
            .padding()
            .navigationTitle("Savings Inputs")
            .onAppear { configureDefaultValues() }
            .navigationDestination(item: $result) { result in
                SavingsResultsView(result: result)
            }
            .safeAreaInset(edge: .bottom) {
                Button {  calculate() } label: {
                    Text("Calculate")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 360, height: 48)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 10))
                }
            }

        }
    }
}

private extension SavingsCalxView {
    func configureDefaultValues() {
        guard !viewDidLoad else { return }
        let defaultConfig = SavingsCalxModel.defaultConfiguration
        
        initialDeposit = defaultConfig.initialDeposit.formattedAsCurrency()
        monthlyContribution = defaultConfig.monthlyContribution.formattedAsCurrency()
        timePeriodInYears = String(defaultConfig.timePeriodInMonths / 12)
        interestRate = String(defaultConfig.annualInterestRate)
        
        viewDidLoad = true
    }
    
    func calculate() {
        focusedField = nil
        
        let deposit = initialDeposit.asDouble()
        let contribution = monthlyContribution.asDouble()
        let interest = interestRate.asDouble() / 100
        let timePeriod = (Int(timePeriodInYears) ?? 1) * 12
        
        let model = SavingsCalxModel(
            initialDeposit: deposit,
            monthlyContribution: contribution,
            annualInterestRate: interest,
            timePeriodInMonths: timePeriod
        )
        
        self.result = model.calculateSavings()
    }
}

private extension SavingsCalxView {
    enum FocusField: Hashable {
        case initialDeposit
        case monthlyContribution
        case interestRate
        case timePeriodInYears
    }
    
    func onFocusChange(_ newValue: FocusField?) {
        switch newValue {
        case .initialDeposit:
            initialDeposit = ""
        case .monthlyContribution:
            monthlyContribution = ""
        case .interestRate:
            interestRate = ""
        case .timePeriodInYears:
            timePeriodInYears = ""
        case .none:
            break
        }
    }
}

#Preview {
    NavigationStack {
        SavingsCalxView()
    }
}
