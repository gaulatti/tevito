import SwiftUI
import SwiftData
import AVKit

struct ContentView: View {
    enum Tab { case home, news, schlager, bbtv, rtl, settings }
    @State var selection: Tab
    
    /**
     1. This is not optimal, but as of 2:55 it works. Ideally we either
     have a menu so the player can be set
     accordingly with a state variable.
     https://github.com/gaulatti/tevito/issues/4
     
     2. Playlist should come from API and not hardcoded.
     https://github.com/gaulatti/tevito/issues/5
     */
    @State var schlagerPlayer = AVPlayer(url:URL(string: "https://sdn-global-live-streaming-packager-cache.3qsdn.com/26658/26658_264_live.m3u8")!)
    
    @State var bbtvPlayer = AVPlayer(url:URL(string: "https://redirector.rudo.video/hls-video/339f69c6122f6d8f4574732c235f09b7683e31a5/bbtv/bbtv.smil/playlist.m3u8")!)
    
    @State var rtlPlayer = AVPlayer(url: URL(string: "https://streamcdnc1-dd782ed59e2a4e86aabf6fc508674b59.msvdn.net/live/S97044836/tbbP8T1ZRPBL/playlist_video.m3u8")!)
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                VStack {
                    Text("home")
                }.tabItem { Text("Home") }.tag(Tab.home)
                VStack {
                    Text("news")
                }.tabItem { Text("News") }.tag(Tab.news)
                VStack {
                    VideoPlayer(player: schlagerPlayer).ignoresSafeArea().onAppear() {
                        schlagerPlayer.play()
                    }.onDisappear() {
                        schlagerPlayer.pause()
                    }
                }.tabItem { Text("Schlager") }.tag(Tab.schlager)
                VStack {
                    VideoPlayer(player: bbtvPlayer).ignoresSafeArea().onAppear() {
                        bbtvPlayer.play()
                    }.onDisappear() {
                        bbtvPlayer.pause()
                    }
                }.tabItem { Text("BBTV") }.tag(Tab.bbtv)
                VStack {
                    VideoPlayer(player: rtlPlayer).ignoresSafeArea().onAppear() {
                        rtlPlayer.play()
                    }.onDisappear() {
                        rtlPlayer.pause()
                    }
                }.tabItem { Text("RTL") }.tag(Tab.rtl)
                VStack {
                    Text("settings")
                }.tabItem { Text("Settings") }.tag(Tab.settings)
            }
        }
    }
}

#Preview {
    ContentView(selection: .home)
}
