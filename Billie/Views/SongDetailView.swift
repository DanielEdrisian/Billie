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
    
    #warning("change to correct song model")
    var song: SongModel
    
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            SongDetailNavBar(publisher: SpotifyPublisher.shared, song: song, isPlaying: $isPlaying, backAction: { presentationMode.wrappedValue.dismiss() })
                .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(song.notes, id: \.id) { note in
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Button(action: {
                                        #warning("change to song uri and timestamp")
                                        publisher.playSong(uri: "")
                                        publisher.playerAPI?.seek(toPosition: note.timeInSong, callback: .none)
                                    }) {
                                        Image(systemName: "play.fill")
                                            .padding(4)
                                    }
                                    Text(note.title)
                                        .bold()
                                        .padding(.horizontal)
                                    Spacer()
                                    Text("\(note.timeInSong.intToTime)")
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
