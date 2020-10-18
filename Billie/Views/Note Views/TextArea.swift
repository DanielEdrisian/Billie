//
//  CustomTextEditor.swift
//  Billie
//
//  Created by Samuel Shi on 10/18/20.
//

import SwiftUI

struct TextArea: View {
  private let placeholder: String
  @Binding var text: String
  
  init(_ placeholder: String, text: Binding<String>) {
    self.placeholder = placeholder
    self._text = text
    
    UITextView.appearance().backgroundColor = .clear
  }
  
  var body: some View {
    ZStack(alignment: .top) {
      TextEditor(text: $text)
      
      HStack(alignment: .top) {
        text.isEmpty ? Text(placeholder) : Text("")
        Spacer()
      }
      .foregroundColor(Color.primary.opacity(0.25))
      .padding(EdgeInsets(top: 8, leading: 4, bottom: 7, trailing: 0))
    }
  }
}
