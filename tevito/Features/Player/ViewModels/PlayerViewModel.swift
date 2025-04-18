import Foundation
import Combine

@MainActor
class PlayerViewModel: ObservableObject {
    @Published var videos: [Video] = []

    init() {
        loadSampleVideos()
    }

    func loadSampleVideos() {
        // In a real app, fetch this from a service or API
        self.videos = [
            Video(name: "BBCL", url: URL(string: "https://redirector.rudo.video/hls-video/339f69c6122f6d8f4574732c235f09b7683e31a5/bbtv/bbtv.smil/playlist.m3u8")!),
            Video(name: "Schlager Deluxe", url: URL(string: "https://sdn-global-live-streaming-packager-cache.3qsdn.com/26658/26658_264_live.m3u8")!),
            Video(name: "RTL 102.5", url: URL(string: "https://streamcdnc1-dd782ed59e2a4e86aabf6fc508674b59.msvdn.net/live/S97044836/tbbP8T1ZRPBL/playlist_video.m3u8")!),
            Video(name: "Antofagasta TV", url: URL(string: "https://unlimited1-us.dps.live/atv/atv.smil/playlist.m3u8")!),
            Video(name: "RadioItalia", url: URL(string: "https://radioitaliatv.akamaized.net/hls/live/2093117/RadioitaliaTV/master.m3u8")!)
        ]
    }

    // Add functions for fetching/updating video list if needed
}
