//
//  NowPlayingSliverView.swift
//  Billie
//
//  Created by Max Nabokow on 10/18/20.
//

import SwiftUI

struct NowPlayingSliverView: View {
    
    @ObservedObject var publisher = SpotifyPublisher.shared
    @Binding var show: Bool
    
    var body: some View {
        HStack(spacing: 4) {
          Image(uiImage: publisher.profileImage ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
          
            Text(SpotifyPublisher.shared.track?.name ?? "")
                .font(.subheadline)
                .padding(.leading)
            
            Spacer()
            
            PlayPauseView()
                .font(.title)
        }
        .padding()
        .background(BlurView(style: .systemThinMaterial))
        .tRoundCorners(16, corners: [.topLeft, .topRight])
        .shadow(radius: 4, x: 0, y: -4)
        .onTapGesture {
          show.toggle()
        }
    }
}
