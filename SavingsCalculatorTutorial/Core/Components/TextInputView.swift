//
//  TextInputView.swift
//  SavingsCalculator
//
//  Created by Stephan Dowless on 10/17/25.
//

import SwiftUI

enum InputType {
    case currency
    case decimal
    case number
}

struct TextInputView: View {
    @Binding private var text: String
    
    private let title: String?
    private let inputType: InputType
    private var disabled = false
        
    init(
        _ title: String? = nil,
        inputType: InputType = .currency,
        text: Binding<String>
    ) {
        _text = text
        
        self.title = title
        self.inputType = inputType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title ?? "")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            
            HStack {
                TextField(placeholder, text: $text)
                    .frame(height: 36)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .keyboardType(keyboardType)
                    .padding(.leading, inputType == .decimal ? 4 : 0)
                    .disabled(disabled)
                
                Spacer()
                
                if inputType == .decimal && !disabled {
                    Text("%")
                        .padding(.horizontal, 8)
                        .padding(.trailing, 4)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.placeholder, lineWidth: 1.0)
            }
        }
        .onChange(of: text) { oldValue, newValue in
            formatInput(newValue)
        }
    }
}

private extension TextInputView {
    func formatInput(_ newValue: String) {
        guard inputType == .currency else { return }
        let value = newValue.asDouble()
        let formattedValue = value.formattedAsCurrency()
        
        if formattedValue != text {
            text = formattedValue
        }
    }
    
    var placeholder: String {
        switch inputType {
        case .currency:
            "$0"
        case .decimal, .number:
            "0"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch inputType {
        case .currency, .number:
            .numberPad
        case .decimal:
            .decimalPad
        }
    }
}

#Preview {
    TextInputView("Test", inputType: .currency, text: .constant("Test"))
        .padding()
}
