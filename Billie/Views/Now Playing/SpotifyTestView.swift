//
//  SpotifyTestView.swift
//  HackNC2020
//
//  Created by Max Nabokow on 10/17/20.
//

import SwiftUI
import Sliders

struct SpotifyTestView: View {
    
    @ObservedObject var publisher: SpotifyPublisher
    
    var body: some View {
        VStack {
            Image(uiImage: publisher.profileImage ?? UIImage())
            Button("Login To Spotify") {
                publisher.connect()
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(publisher.track?.name ?? "")
                    .font(.title2)
                    .bold()
                Text(publisher.track?.artist.name ?? "")
                    .font(.title3)
                
                ProgressView(current: $publisher.playbackPosition, total: Double(publisher.track?.duration ?? 1)) { position in
                    publisher.playerAPI?.seek(toPosition: position, callback: nil)
                }
                
                HStack {
                    Text(durationFrom(UInt(publisher.playbackPosition / 1000)))
                    Spacer()
                    Text(durationFrom((publisher.track?.duration ?? 0)/1000))
                }
            }
            
            Spacer()
            
            HStack(spacing: 10) {
                Button(action: {
                    publisher.playerAPI?.skip(toPrevious: .none)
                }) {
                    Image(systemName: "backward.fill")
                }
                
                Button(action: {
                    publisher.playerAPI?.seek(toPosition: publisher.playbackPosition - 15000, callback: nil)
                }) {
                    Image(systemName: "gobackward.15")
                }
                
                Button(action: {
                    if publisher.isPaused {
                        publisher.playSong(uri: "")
                    }
                }) {
                    if publisher.isPaused {
                        Image(systemName: "play.fill")
                    } else {
                        Image(systemName: "pause.fill")
                    }
                }
                
                Button(action: {
                    publisher.playerAPI?.seek(toPosition: publisher.playbackPosition + 15000, callback: nil)
                }) {
                    Image(systemName: "goforward.15")
                }
                
                Button(action: {
                    publisher.playerAPI?.skip(toNext: .none)
                }) {
                    Image(systemName: "forward.fill")
                }
            }
            .font(.system(size: 35))
        }
        .padding(.horizontal)
    }
    
    
    func durationFrom(_ ms: UInt) -> String {
        let seconds = ms / 1000
        let min = seconds / 60
        let sec = seconds % 60
        
        return "\(min):" + String(format: "%.2d", sec)
    }
}
