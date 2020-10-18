//
//  NoteItemView.swift
//  Billie
//
//  Created by Samuel Shi on 10/18/20.
//

import SwiftUI

struct NoteItemView: View {
  
  @ObservedObject var publisher = SpotifyPublisher.shared
  var note: NoteModel
  let onTapAction: (Int) -> Void
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        HStack {
          Button(action: {
            onTapAction(note.timeInSong)
          }) {
            Image(systemName: "play.fill")
              .padding(4)
          }
          Text(note.title)
            .bold()
            .padding(.horizontal)
          Spacer()
            Text("\((note.timeInSong / 1000).intToTime)")
            .fontWeight(.light)
          
        }
        .padding(.horizontal)
        
        Divider()
        
        Text(note.description)
          .font(.callout)
          .padding(.bottom)
          .padding(.horizontal)
      }
    }
    .padding(.top)
    .background(Color(.secondarySystemBackground))
    .cornerRadius(12)
    .clipped()
    .contextMenu(ContextMenu(menuItems: {
      Button(action: {}) {
        Label("Share", systemImage: "square.and.arrow.up")
      }
      Button(action: {}) {
        Label("Delete", systemImage: "trash")
      }
    }))
    .onTapGesture {
      onTapAction(note.timeInSong)
    }
  }
}
