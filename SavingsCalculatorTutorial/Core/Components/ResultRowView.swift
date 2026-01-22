//
//  ResultRowView.swift
//  SavingsCalculator
//
//  Created by Stephan Dowless on 10/17/25.
//

import SwiftUI

struct ResultRowView: View {
    let title: String
    let value: Double
    let color: Color
    
    init(title: String, value: Double, color: Color) {
        self.title = title
        self.value = value
        self.color = color
    }
    
    var body: some View {
        HStack {
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                
                Text(title)
                    .font(.subheadline)
            }
            Spacer()
            
            Text(value.formattedAsCurrency())
        }
        .font(.subheadline)
    }
}
