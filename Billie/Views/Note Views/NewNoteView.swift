//
//  NewNoteView.swift
//  Billie
//
//  Created by Samuel Shi on 10/18/20.
//

import SwiftUI

struct NewNoteView: View {
  
  @State var currentTitle: String = ""
  @State var currentDescription: String = ""
  let currentPosition: Int = 183
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        HStack {
          Button(action: {
            // add note
          }) {
            Image(systemName: "plus.circle")
              .foregroundColor(currentTitle.isEmpty || currentDescription.isEmpty ?
                                Color.gray
                                : Color.accentColor
              )
          }
          
          TextField("Note Title", text: $currentTitle)
            .textFieldStyle(PlainTextFieldStyle())
            .font(.system(size: 20, weight: .bold, design: .default))
          
          Spacer()
          
          Text("\((currentPosition / 1000).intToTime)")
            .fontWeight(.light)
          
        }
        
        Divider()
        
        TextArea("Note Body", text: $currentDescription)
          .font(.headline)
      }
      .padding(.horizontal)
    }
    .padding(.top)
    .background(Color(.secondarySystemBackground))
    .cornerRadius(12)
    .clipped()
  }
}
