//
//  SpotifyTestView.swift
//  HackNC2020
//
//  Created by Max Nabokow on 10/17/20.
//

import SwiftUI
import Sliders

struct NowPlayingView: View {
    
  @ObservedObject var publisher = SpotifyPublisher.shared
  @ObservedObject var user = UserModel.shared
  
    var body: some View {
      ScrollView {
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
                      Text(durationFrom(UInt(publisher.playbackPosition)))
                      Spacer()
                      Text(durationFrom((publisher.track?.duration ?? 0)))
                  }
              }.padding(.vertical, 75)
              
  //            Spacer()
              
              MediaControlView()
                .padding(.bottom, 50)
          
          Text("Add a New Note")
            .font(.callout)
            .foregroundColor(.secondary)
          
          NewNoteView(songId: publisher.track?.uri, currentPositionMillisecs: publisher.playbackPosition) { note in
            user.addNote(note: note, song: .init(track: publisher.track!))
          }
        }
        .padding(.horizontal)
      }
    }
    
    
    func durationFrom(_ ms: UInt) -> String {
        let seconds = ms / 1000
        let min = seconds / 60
        let sec = seconds % 60
        
        return "\(min):" + String(format: "%.2d", sec)
    }
}
