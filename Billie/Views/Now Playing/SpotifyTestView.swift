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
            if let profileImage = publisher.profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
                    .tRoundCorners(16)
                    .padding(.top)
                    .padding(24)
            }
            
//            Spacer()
            
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
            
//            Spacer()
            
            HStack {
                Button(action: {
                    publisher.playerAPI?.skip(toPrevious: .none)
                }) {
                    Image(systemName: "backward.fill")
                }
                
                Spacer(minLength: 10)
                
                Button(action: {
                    publisher.playerAPI?.seek(toPosition: publisher.playbackPosition - 15000, callback: nil)
                }) {
                    Image(systemName: "gobackward.15")
                }
                
                Spacer(minLength: 10)
                
                Button(action: {
                    if publisher.isPaused {
                        publisher.appRemote.playerAPI?.resume { (whatever, error) in print(error ?? "") }
                    } else {
                        publisher.appRemote.playerAPI?.pause { (whatever, error) in print(error ?? "") }
                    }
                }) {
                    Image(systemName: publisher.isPaused ? "play.fill" : "pause.fill")
                }
                
                Spacer(minLength: 10)
                
                Button(action: {
                    publisher.playerAPI?.seek(toPosition: publisher.playbackPosition + 15000, callback: nil)
                }) {
                    Image(systemName: "goforward.15")
                }
                
                Spacer(minLength: 10)
                
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
    
    func durationFrom(_ seconds: UInt) -> String {
        let min = seconds / UInt(60)
        let sec = seconds % 60
        
        return "\(min):" + String(format: "%.2d", sec)
    }
}
