import SwiftUI
import AVKit

struct Video: Identifiable {
    let id = UUID() // Unique identifier for SwiftUI Lists
    let name: String
    let url: URL
}

struct PlayerView: View {
    let videos = [
        Video(name: "BBCL", url: URL(string: "https://redirector.rudo.video/hls-video/339f69c6122f6d8f4574732c235f09b7683e31a5/bbtv/bbtv.smil/playlist.m3u8")!),
        Video(name: "Schlager Deluxe", url: URL(string: "https://sdn-global-live-streaming-packager-cache.3qsdn.com/26658/26658_264_live.m3u8")!),
        Video(name: "RTL 102.5", url: URL(string: "https://streamcdnc1-dd782ed59e2a4e86aabf6fc508674b59.msvdn.net/live/S97044836/tbbP8T1ZRPBL/playlist_video.m3u8")!),
        Video(name: "Antofagasta TV", url: URL(string: "https://unlimited1-us.dps.live/atv/atv.smil/playlist.m3u8")!),
        Video(name: "RadioItalia", url: URL(string: "https://radioitaliatv.akamaized.net/hls/live/2093117/RadioitaliaTV/master.m3u8")!)
    ]
    
    var body: some View {
        NavigationView {
            List(videos) { video in
                NavigationLink(video.name, destination: VideoDetailView(video: video))
            }
        }
    }
}

struct VideoDetailView: View {
    var video: Video
    private var player: AVPlayer {
        AVPlayer(url: video.url)
    }

    var body: some View {
        VideoPlayer(player: player)
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
            .onAppear {
                player.play()
            }
            .onDisappear {
                player.pause()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
 
