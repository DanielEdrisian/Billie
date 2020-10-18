//
//  NoteModel.swift
//  HackNC2020
//
//  Created by Samuel Shi on 10/17/20.
//

import SwiftUI
import Firebase

class UserModel: ObservableObject {
  static var shared = UserModel()
  
  @Published private(set) var songs = [SongModel]()
  
  init() {
//    addSong(song: SongModel(id: "1", name: "A Day In The Life", artist: "The Beatles", duration: 300, notes: .init(repeating: .example(), count: 5)))
  }
  
  init(withSnapshot: DataSnapshot) {
    fillSongs(withSnapshot: withSnapshot)
  }
  
  func fillSongs(withSnapshot: DataSnapshot) {
    guard let dict = withSnapshot.value as? NSDictionary,
          let songsData = dict["songs"] as? [[String: Any]] else { print("NO SONGS TO READ FROM FIREBASE"); return }
    
    songs = songsData.map({ (songData) -> SongModel in
      let notesData = songData["notes"] as! [[String: Any]]
      let notes = notesData.map { NoteModel(songId: $0["songId"] as! String,
                                            title: $0["title"] as! String,
                                            description: $0["description"] as! String,
                                            timeInSong: $0["timeInSong"] as! Int,
                                            createdAt: Date(timeIntervalSince1970: TimeInterval($0["createdAt"] as! Int)))
      }
      let song = SongModel(id: songData["id"] as! String,
                           name: songData["name"] as! String,
                           artist: songData["artist"] as! String,
                           duration: songData["duration"] as! Int,
                           notes: notes)
      return song
    })
  }
  
  func readFromRemote(completion: @escaping ((Error?) -> ())) {
    ref.child(UIDevice.current.identifierForVendor!.uuidString).observe(.value) { (snap) in
      guard let _ = snap.value else { completion(NSError()); fatalError() }
            
      UserModel.shared.fillSongs(withSnapshot: snap)
      
      completion(nil)
    }
  }
  
  func addSong(song: SongModel) {
    songs.append(song)
    setSongs()
  }
  
  func setSongs() {
    let songsDic = self.songs.map { NSDictionary(dictionary: $0.toDict()) }
    
    ref.child(UIDevice.current.identifierForVendor!.uuidString).child("songs").setValue(NSArray(array: songsDic))
  }
}
