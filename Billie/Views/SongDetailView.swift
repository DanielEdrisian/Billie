//
//  SongDetailView.swift
//  HackNC2020
//
//  Created by Max Nabokow on 10/17/20.
//

import SwiftUI

struct SongDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var publisher: SpotifyPublisher
    
    var song: SongModel
    
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            SongDetailNavBar(publisher: SpotifyPublisher.shared, song: song, isPlaying: $isPlaying, backAction: { presentationMode.wrappedValue.dismiss() })
                .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 12) {
                  NewNoteView()
                    ForEach(song.notes, id: \.id) { note in
                      NoteItemView(note: note) { time in
                        publisher.playSong(uri: "")
                        publisher.playerAPI?.seek(toPosition: time, callback: .none)
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
                #warning("replace with uri")
                publisher.connect(with: "")
              }
                if publisher.isPaused {
                    publisher.appRemote.playerAPI?.resume { (whatever, error) in
                        print(error ?? "")
                    }
                } else {
                    publisher.appRemote.playerAPI?.pause { (whatever, error) in
                        print(error ?? "")
                    }
                }
            }) {
                if publisher.isPaused {
                    Image(systemName: "play.fill")
                } else {
                    IsPlayingView()
                }
            }
            .frame(width: 45, height: 45)
            .background(Circle().fill(Color.accentColor))
            .foregroundColor(.white)
        }
    }
}
