//
//  ContentView.swift
//  HackNC2020
//
//  Created by Max Nabokow on 10/17/20.
//

import SwiftUI
import MediaPlayer

struct ContentView: View {
    
    @State var show = false
    @ObservedObject var publisher = SpotifyPublisher.shared
    
    var body: some View {
        ZStack {
            Color.sBackground//.edgesIgnoringSafeArea(.all)
            TabView {
                ZStack(alignment: .bottom) {
                  HomeView(show: $show)
                    if publisher.track != nil {
                        NowPlayingSliverView(show: $show)
                    }
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                SearchView(publisher: publisher)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
                Text("Settings")
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
        }
        .accentColor(.sRed)
        .sheet(isPresented: $show) {
          NowPlayingView()
              .background(BlurView(style: .systemThickMaterial))
              .accentColor(.sRed)
              .onTapGesture(count: 2) {
                  withAnimation(.easeInOut) {
                      show.toggle()
                  }
              }
//              .padding(.top, 40)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
