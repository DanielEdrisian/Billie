//
//  NoteModel.swift
//  HackNC2020
//
//  Created by Samuel Shi on 10/17/20.
//

import Foundation

struct NoteModel: Identifiable {
    let id = UUID()
    
    var title: String
    var description: String
    
    var timeInSong: Int /// time in song in seconds
    
    var createdAt: Date = Date()
}

extension NoteModel {
    static func example() -> NoteModel {
        NoteModel(title: "OMG Epic Sax", description: "Epic Sax Solo AHHHHHHHHHH Epic Sax Solo AHHHHHHHHHH Epic Sax Solo AHHHHHHHHHH Epic Sax Solo AHHHHHHHHHH Epic Sax Solo AHHHHHHHHHH Epic Sax Solo AHHHHHHHHHH Epic Sax Solo", timeInSong: 37)
    }
}
