//
//  NoteModel.swift
//  HackNC2020
//
//  Created by Samuel Shi on 10/17/20.
//

import Foundation

struct NoteModel: Identifiable {
  var songId: String?
  let id = UUID().uuidString
    
    var title: String
    var description: String
    
    var timeInSong: Int /// time in song in seconds
    
    var createdAt: Date = Date()
  
  func toDict() -> [String: Any] {
    ["songId": self.songId ?? "",
     "id": self.id,
     "title": self.title,
     "description": self.description,
     "timeInSong": self.timeInSong,
     "createdAt": Int(self.createdAt.timeIntervalSince1970)]
  }
}

extension NoteModel {
    static func example() -> NoteModel {
        NoteModel(title: "OMG Epic Sax", description: "Epic Sax Solo AHHHHHHHHHH Epic Sax Solo AHHHHHHHHHH Epic Sax Solo AHHHHHHHHHH Epic Sax Solo AHHHHHHHHHH Epic Sax Solo AHHHHHHHHHH Epic Sax Solo AHHHHHHHHHH Epic Sax Solo", timeInSong: 37)
    }
}
