//
//  NowPlayingView.swift
//  HackNC2020
//
//  Created by Samuel Shi on 10/17/20.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var publisher: SpotifyPublisher
    
    @State private var queryString = ""
    
    var body: some View {
      let binding = Binding(
                  get: { self.queryString },
                  set: {
                    self.queryString = $0
                    publisher.search(forString: queryString)
                  }
              )
        VStack {
            List {
                Section(header: Text("Search")) {
                    TextField("Search Spotify", text: binding)
                }
                
                Section(header: Text("Results")) {
                    ForEach(publisher.searchResults, id: \.id) { result in
                        Button(action: {
                            publisher.playSong(uri: result.uri)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                URLImage(url: result.album?.artUri)
                                    .frame(width: 35, height: 35)
                                
                                VStack(alignment: .leading) {
                                    Text(result.name)
                                        .bold()
                                        .font(.callout)
                                    
                                    Text(result.artist.name)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.vertical, 5)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}
//
//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
