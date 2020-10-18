//
//  SpotifyPublisher.swift
//  HackNC2020
//
//  Created by Max Nabokow on 10/17/20.
//

import Foundation

class SpotifyPublisher: NSObject, ObservableObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate, SpotifyManagerDelegate {
    
    static var shared: SpotifyPublisher = SpotifyPublisher()
    var manager: SpotifyManager = SpotifyManager.shared
    var accessToken = ""
    var playURI = ""
    
    let configuration = SPTConfiguration(
        clientID: "2979af5bbf724a15914404ef37143116",
        redirectURL: URL(string: "hacknc2020://SpotifyAuthentication")!
    )
    
    var appRemote: SPTAppRemote
    var playerState: SPTAppRemotePlayerState?
    var playerAPI: SPTAppRemotePlayerAPI?
    
    @Published var track: SPTAppRemoteTrack?
    @Published var playbackPosition: Int = 0
    @Published var isPaused: Bool = true
    @Published var profileImage: UIImage?
    @Published var searchResults = [SpotifyTrack]()
    
    func search(forString: String) {
        if forString.isEmpty {
            searchResults = []
        }
        
        manager.find(SpotifyTrack.self, forString) { (items) in
            self.searchResults = items
        }
    }
    
    func playSong(uri: String) {
        self.playerAPI?.play(uri, asRadio: false, callback: { (res, error) in
            if let e = error {
              print(e)
            }
          }
        )
    }
    
    override init() {
        appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
        super.init()
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        manager.delegate = self
    }
    
    func connect() {
        if appRemote.authorizeAndPlayURI("") {
            
        } else {
            fatalError()
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [self] (t) in
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (t) in
                getPlayerState()
            }
        }
    }
    
    func getPlayerState() {
        playerAPI = appRemote.playerAPI
        playerAPI?.getPlayerState { [self] (result, error) in
            guard let state = result as? SPTAppRemotePlayerState else { return }
            playerState = state
            track = state.track
            playbackPosition = state.playbackPosition
            isPaused = state.isPaused
        }
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        // Connection was successful, you can begin issuing commands
        SpotifyPublisher.shared.appRemote.playerAPI?.delegate = self
        manager.authorize()
        
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            } else {
                self.playerState = result as? SPTAppRemotePlayerState
            }
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed with error: \(error?.localizedDescription ?? "")")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected with error: \(error?.localizedDescription ?? "")")
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        debugPrint("Track name: %@", playerState.track.name)
    }
    
    func didSetToken() {
        manager.myProfile { (user) in
            if let imageURL = URL(string: user.artUri) {
                let data = try? Data(contentsOf: imageURL)
                self.profileImage = UIImage(data: data!)
            }
        }
    }
}
