//
//  ProgressBar.swift
//  HackNC2020
//
//  Created by Samuel Shi on 10/17/20.
//

import SwiftUI

struct ProgressView: View {
    @Binding var current: Int
    let total: Double
    let onChange: (Int) -> Void
    
    var body: some View {
        CustomSlider(value: $current, range: (0, total), knobWidth: 4, onChange: onChange) { modifiers, isDragging in
            ZStack {
                Group {
                    Color(isDragging ? .label : .darkGray)
                        .modifier(modifiers.barLeft)
                        .cornerRadius(5)
                    
                    Color(.darkGray).opacity(0.75)
                        .opacity(0.4)
                        .modifier(modifiers.barRight)
                        .cornerRadius(5)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 8, height: 20)
                        .foregroundColor(isDragging ? .sRed : .secondary)
                        .modifier(modifiers.knob)
                }
            }
        }
        .frame(height: 10)
    }
}
