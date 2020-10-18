//
//  FakeSongModel.swift
//  HackNC2020
//
//  Created by Samuel Shi on 10/17/20.
//

import Foundation

// FAKE FOR RIGHT NOW
struct SongModel: Identifiable {
    let id: String
    
    let name: String
    let artist: String
    
    let duration: Int /// song duration in number of seconds?
    
    var notes: [NoteModel]
}

extension SongModel {
    static func example() -> SongModel {
        SongModel(id: "1", name: "A Day In The Life", artist: "The Beatles", duration: 300, notes: .init(repeating: .example(), count: 5))
    }
}
