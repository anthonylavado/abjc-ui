//
//  PlayerView.swift
//  
//
//  Created by Noah Kamara on 10.11.20.
//

import SwiftUI
import AVKit

import abjc_core
import abjc_api


/// PlayerView
public struct PlayerView: View {
    
    /// SessionStore EnvironmentObject
    @EnvironmentObject var session: SessionStore
    
    /// DesignConfiguration Environment
    @Environment(\.designConfig) var designConfig
    
    /// PlayerStore EnvironmentObject
    @EnvironmentObject var playerStore: PlayerStore
    
    
    @State var playItem: PlayerStore.PlayItem!
    @State var player: AVPlayer!
    @State var playerReady: Bool = false
    @State var reportCounter = 0
    
    
    /// Empty Initializer because Swift
    public init() {}
    
    /// ViewBuilder body
    public var body: some View {
        ZStack {
            Blur().edgesIgnoringSafeArea(.all)
            if playerReady {
                VideoPlayer(player: self.player)
            }
        }
        .edgesIgnoringSafeArea(.all)
        
        .onAppear(perform: initPlayback)
        .onDisappear(perform: deinitPlayback)
    }
    
    
    /// VideoPlayer Overlay
    private var overlayView: some View {
        EmptyView()
//        Group() {
//            if /*session.preferences.beta_playerOverlay*/ false {
//                PlayerOverlay($player)
//            } else {
//                EmptyView()
//            }
//        }
    }
    
    
    /// Initializes the Player
    func initPlayback() {
        let asset = session.api.getPlayerItem(for: playerStore.playItem!.id, playerStore.playItem!.sourceId)
        self.player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
        
        self.playItem = playerStore.playItem
        
        _ = self.player.observe(\.currentItem?.status) { (player, value) in
            if value.newValue == .failed {
                DispatchQueue.main.async {
                    session.alert = AlertError("alerts.playbackerror", "alerts.playbackerror.descr")
                }
            }
        }
        
        // Report Playback Progress back to Jellyfin Server
        let timeScale = 10000000
        let interval = CMTime(seconds: 1, preferredTimescale: 10000000)
        self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            let playbackPosition = Int( time.seconds * Double(timeScale) )
            print("POSITION", time.seconds, playbackPosition)
            self.playerStore.reportPlayback(player, playbackPosition)
        }
        
        player.play()
        self.playerStore.startedPlayback(player)
        self.playerReady = true
        
        print("USERDATA", playItem.userData.playbackPosition, playItem.userData.playbackPositionTicks, playItem.userData.playbackPositionTicks/playItem.userData.playbackPosition)
        player.seek(to: CMTime(seconds: Double(playItem.userData.playbackPosition), preferredTimescale: 1))
    }
    
    func deinitPlayback() {
        self.playerStore.stoppedPlayback(playItem, player)
        self.player.pause()
    }
}

//struct PlayerViewController: UIViewControllerRepresentable {
//    @EnvironmentObject var session: SessionStore
//    @EnvironmentObject var playerStore: PlayerStore
//    @Binding var player: AVPlayer
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<PlayerViewController>) -> AVPlayerViewController {
//        let controller = AVPlayerViewController()
//        return controller
//    }
//
//    func updateUIViewController(_ vc: AVPlayerViewController, context: UIViewControllerRepresentableContext<PlayerViewController>) {
//        if vc.player == nil {
//            vc.player = self.player
//            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [.allowAirPlay])
//            try? AVAudioSession.sharedInstance().setActive(true, options: [.notifyOthersOnDeactivation])
//            vc.player?.play()
//            vc.showsPlaybackControls = true
//            self.playerStore.startedPlayback(vc.player)
//        }
//    }
//}
