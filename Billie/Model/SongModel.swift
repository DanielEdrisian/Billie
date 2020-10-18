//
//  FakeSongModel.swift
//  HackNC2020
//
//  Created by Samuel Shi on 10/17/20.
//

import SwiftUI

// FAKE FOR RIGHT NOW
class SongModel: ObservableObject, Identifiable {
    var id: String
    
    var name: String
    var artist: String
    
    var duration: Int /// song duration in number of seconds?
    
    @Published var notes = [NoteModel]()
    
    init(id: String, name: String, artist: String, duration: Int, notes: [NoteModel]) {
        self.id = id
        self.name = name
        self.artist = artist
        self.duration = duration
        self.notes = notes
    }
    
    func toDict() -> [String: Any] {
        ["id": self.id,
         "name": self.name,
         "artist": self.artist,
         "duration": self.duration,
         "notes": self.notes.map { $0.toDict() }]
    }
    
    func addNote(note: NoteModel) {
        var n = note
        n.songId = self.id
        notes.append(n)
        UserModel.shared.setSongs()
    }
}

//extension SongModel {
//    static func example() -> SongModel {
//        SongModel(id: "1", name: "A Day In The Life", artist: "The Beatles", duration: 300, notes: .init(repeating: .example(), count: 5))
//    }
//}
