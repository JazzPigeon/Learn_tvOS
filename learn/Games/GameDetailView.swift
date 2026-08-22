//
//  GameDetailView.swift
//  learn
//
//  Created by Cindy Michalowski on 8/22/26.
//

import SwiftUI
import AVKit

struct GameDetailView: View {
    
    let game: GameObject
    
    @State private var player: AVPlayer
    
    init(game: GameObject) {
        self.game = game
        
        let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!
        let item = AVPlayerItem(url: url)
        
        let title = AVMutableMetadataItem()
        title.identifier = .commonIdentifierTitle
        title.value = game.name as NSString
        title.extendedLanguageTag = "und"
        item.externalMetadata = [title]
        
        _player = State(initialValue: AVPlayer(playerItem: item))
    }
    
    var body: some View {
        TVVideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear {
                player.play()
            }
            .onDisappear {
                player.pause()
            }
    }
}

/// Full-screen tvOS player. Menu on the remote dismisses the cover.
private struct TVVideoPlayer: UIViewControllerRepresentable {
    let player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true
        return controller
    }
    
    func updateUIViewController(_ controller: AVPlayerViewController, context: Context) {
        if controller.player !== player {
            controller.player = player
        }
    }
}
