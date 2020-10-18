//
//  MediaControlView.swift
//  Billie
//
//  Created by Samuel Shi on 10/18/20.
//

import SwiftUI

struct MediaControlView: View {
  @ObservedObject var publisher = SpotifyPublisher.shared
  
  var body: some View {
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
      
      PlayPauseView()
      
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
}
