//
//  NewNoteView.swift
//  Billie
//
//  Created by Samuel Shi on 10/18/20.
//

import SwiftUI

struct NewNoteView: View {
  
  let songId: String?
  let currentPositionMillisecs: Int?
  let add: (NoteModel) -> Void
  
  @State private var currentTitle: String = ""
  @State private var currentDescription: String = ""
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        HStack {
          Button(action: {
            if !currentTitle.isEmpty && !currentDescription.isEmpty,
               let songId = songId, let milli = currentPositionMillisecs {
              let note = NoteModel(songId: songId, title: currentTitle, description: currentDescription, timeInSong: milli)
              add(note)
            }
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
          
          Text("\((currentPositionMillisecs ?? 0 / 1000).intToTime)")
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
