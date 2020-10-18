//
//  NowPlayingSliverView.swift
//  Billie
//
//  Created by Max Nabokow on 10/18/20.
//

import SwiftUI

struct NowPlayingSliverView: View {
    
    @Binding var show: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 6).fill(Color.secondary).frame(width: 50, height: 50)
            
            Text(SpotifyPublisher.shared.track?.name ?? "")
                .font(.subheadline)
                .padding(.leading)
            
            Spacer()
            
            Image(systemName: "play.fill")
                .font(.title)
        }
        .padding()
        .background(BlurView(style: .systemThinMaterial))
        .tRoundCorners(16, corners: [.topLeft, .topRight])
        .shadow(radius: 4, x: 0, y: -4)
        .onTapGesture {
            withAnimation(.spring()) {
                show.toggle()
            }
        }
    }
}
