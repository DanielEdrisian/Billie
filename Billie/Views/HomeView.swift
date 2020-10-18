//
//  HomeView.swift
//  HackNC2020
//
//  Created by Samuel Shi on 10/17/20.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var user = UserModel.shared
  @Binding var show: Bool
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        VStack(alignment: .leading, spacing: 8) {
          if !user.songs.isEmpty {
            ForEach(user.songs, id: \.id) { song in
              NavigationLink(destination: SongDetailView(show: $show, publisher: SpotifyPublisher.shared, song: song)) {
                SongItemView(song: song)
              }
            }
          } else {
            Text("No Notes")
              .font(.title3)
              .fontWeight(.semibold)
            Text("You haven't created any song notes yet. Go play songs and make some!")
          }
          
          Spacer()
        }
        .padding()
      }
      .navigationBarTitle("Your Notes")
    }
  }
}

struct SongItemView: View {
  let song: SongModel
  @ObservedObject var publisher = SpotifyPublisher.shared
  
  var body: some View {
    HStack {
      Image(systemName: "music.note")
        .foregroundColor(Color.accentColor)
        .font(.title)
      
      VStack(alignment: .leading) {
        Text(song.name)
          .fontWeight(.semibold)
        
        Text(song.artist)
          .font(.callout)
      }
      
      Spacer()
      
      VStack {
        Text("\(song.notes.count)")
        Text(song.notes.count > 1 ? "Notes" : "Note")
          .font(.caption)
      }
      .foregroundColor(.secondary)
    }
    .padding()
    .background(Color(.secondarySystemBackground))
    .cornerRadius(8)
  }
}
