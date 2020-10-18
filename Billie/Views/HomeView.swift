//
//  HomeView.swift
//  HackNC2020
//
//  Created by Samuel Shi on 10/17/20.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var user = UserModel.shared
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        VStack(alignment: .leading, spacing: 8) {
          Text("Recents")
            .font(.title2)
            .bold()
          
          ForEach(user.songs, id: \.id) { song in
            NavigationLink(destination: SongDetailView(publisher: SpotifyPublisher.shared, song: song)) {
              SongItemView(song: song)
            }
            .buttonStyle(PlainButtonStyle())
          }
          
          Spacer()
        }
        .padding()
      }
      .navigationBarTitle("Home")
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}

struct SongItemView: View {
  let song: SongModel
  
  var body: some View {
    HStack {
      Rectangle()
        .fill(Color.black)
        .frame(width: 45, height: 45)
      
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
