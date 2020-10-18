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
        NavigationView {
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
                            publisher.appRemote.playerAPI?.resume { (whatever, error) in
                                print(error ?? "")
                            }
                        } else {
                            publisher.appRemote.playerAPI?.pause { (whatever, error) in
                                print(error ?? "")
                            }
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
    }
    
    func durationFrom(_ seconds: UInt) -> String {
        let min = seconds / UInt(60)
        let sec = seconds % 60
        
        return "\(min):" + String(format: "%.2d", sec)
    }
}


//struct SpotifyTestView: View {
//    @ObservedObject var publisher: SpotifyPublisher
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                NavigationLink(destination: SearchView(publisher: publisher)) {
//                    Text("Search View")
//                }
//
//                Image(uiImage: publisher.profileImage ?? UIImage())
//
//                Text(publisher.track?.name ?? "")
//                Divider()
//                Button("Login To Spotify") {
//                    publisher.connect()
//                }
//                HStack {
//                    Text("0:00")
//                    Text(durationFrom(UInt(publisher.playbackPosition / 1000)))
//                    Text(durationFrom((publisher.track?.duration ?? 0)/1000))
//                }.padding()
//                HStack {
//                    Button("<< 10s") {
//                        publisher.playerAPI?.seek(toPosition: publisher.playbackPosition - 10000, callback: nil)
//                    }
//                    (publisher.isPaused
//                        ? Button("Resume") {
//                            publisher.appRemote.playerAPI?.resume { (whatever, error) in
//                                print(error ?? "")
//                            }
//                        }
//                        : Button("Pause") {
//                            publisher.appRemote.playerAPI?.pause { (whatever, error) in
//                                print(error ?? "")
//                            }
//                        }).padding()
//                    Button("10s >>") {
//                        publisher.playerAPI?.seek(toPosition: publisher.playbackPosition + 10000, callback: nil)
//                    }
//                }
//            }
//        }
//    }
//
//    func durationFrom(_ seconds: UInt) -> String {
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.minute, .second]
//        formatter.unitsStyle = .positional
//
//        let formattedString = formatter.string(from: TimeInterval(seconds))!
//        return formattedString
//    }
//}

//struct SpotifyTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpotifyTestView()
//    }
//}
