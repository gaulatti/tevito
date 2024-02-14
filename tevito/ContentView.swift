//
//  ContentView.swift
//  tevito
//
//  Created by Javier Godoy Núñez on 1/29/24.
//

import SwiftUI
import SwiftData
import AVKit

struct ContentView: View {
    @Query private var items: [Item]
    /**
     * By now, just do Schlager Deluxe.
     */
    @State var player = AVPlayer(url:URL(string: "https://sdn-global-live-streaming-packager-cache.3qsdn.com/26658/26658_264_live.m3u8")!)
        

    var body: some View {
        VStack {
            VideoPlayer(player: player).ignoresSafeArea().onAppear() {
                player.play()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
