//
//  ContentView.swift
//  HackNC2020
//
//  Created by Max Nabokow on 10/17/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false
    
    var body: some View {
        ZStack {
            Color.sBackground//.edgesIgnoringSafeArea(.all)
            TabView {
                ZStack(alignment: .bottom) {
                    HomeView()
                    if SpotifyPublisher.shared.track != nil {
                        NowPlayingSliverView(show: $show)
                    }
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                Text("Settings")
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            
            SpotifyTestView(publisher: SpotifyPublisher.shared)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(BlurView(style: .systemThickMaterial))
                .tRoundCorners(40, corners: [.topLeft, .topRight])
                .offset(y: show ? 0 : UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.bottom)
                .transition(.slide)
                .onTapGesture(count: 2) {
                    withAnimation(.easeInOut) {
                        show.toggle()
                    }
                }
                .padding(.top, 40)
            
        }
        .onAppear {
            SpotifyPublisher.shared.connect()
        }
        .accentColor(.sRed)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
