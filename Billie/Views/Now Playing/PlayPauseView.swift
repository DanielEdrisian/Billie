//
//  PlayPauseView.swift
//  Billie
//
//  Created by Samuel Shi on 10/18/20.
//

import SwiftUI

struct PlayPauseView: View {
  
  @ObservedObject var publisher = SpotifyPublisher.shared
  
  var body: some View {
    Button(action: {
      if publisher.isPaused {
        publisher.playerAPI?.resume(.none)
      } else {
        publisher.playerAPI?.pause(.none)
      }
    }) {
      Image(systemName: publisher.isPaused ? "play.fill" : "pause.fill")
    }
  }
}
