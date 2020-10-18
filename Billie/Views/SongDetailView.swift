//
//  SongDetailView.swift
//  HackNC2020
//
//  Created by Max Nabokow on 10/17/20.
//

import SwiftUI

struct SongDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var song: SongModel
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            SongDetailNavBar(song: song, isPlaying: $isPlaying, backAction: { presentationMode.wrappedValue.dismiss() })
                .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(song.notes, id: \.id) { note in
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Button(action: {}) {
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

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailView(song: .example())
            .preferredColorScheme(.dark)
    }
}

struct SongDetailNavBar: View {
    
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
            
            Button(action: { isPlaying.toggle() }) {
                if isPlaying {
                    IsPlayingView()
                } else {
                    Image(systemName: "play.fill")
                        .font(.title2)
                }
            }
            .frame(width: 45, height: 45)
            .background(Circle().fill(Color.accentColor))
            .foregroundColor(.white)
        }
    }
}
