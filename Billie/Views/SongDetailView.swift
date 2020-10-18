//
//  SongDetailView.swift
//  HackNC2020
//
//  Created by Max Nabokow on 10/17/20.
//

import SwiftUI

struct SongDetailView: View {
  @Binding var show: Bool
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var publisher: SpotifyPublisher
    
    var song: SongModel
    
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
          SongDetailNavBar(show: $show, publisher: SpotifyPublisher.shared, song: song, isPlaying: $isPlaying, backAction: { presentationMode.wrappedValue.dismiss() })
                .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(song.notes, id: \.id) { note in
                      NoteItemView(note: note) { time in
                        publisher.playSong(uri: song.id)
                        publisher.playerAPI?.seek(toPosition: time, callback: nil)
                        print(time)
                      }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
    }
    
}

struct SongDetailNavBar: View {
    
  @Binding var show: Bool
    @ObservedObject var publisher: SpotifyPublisher
    
    var song: SongModel
    @Binding var isPlaying: Bool
    var backAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: backAction) {
                Image(systemName: "chevron.left")
                    .font(.title)
            }
          
            Spacer()
            
            VStack {
                Text(song.name)
                    .font(.title2)
                
                Text(song.artist)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            Button(action: {
              if publisher.accessToken == ""  {
                publisher.connect(with: song.id)
                return
              }
              if publisher.track?.uri != song.id {
                publisher.playSong(uri: song.id)
              }
              show.toggle()
            }) {
              if publisher.track?.uri == song.id {
                  IsPlayingView()
                } else {
                  Image(systemName: "play.fill")
                }
            }
            .frame(width: 45, height: 45)
            .background(Circle().fill(Color.accentColor))
            .foregroundColor(.white)
        }
    }
}
