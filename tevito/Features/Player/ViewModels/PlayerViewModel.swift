import Foundation
import Combine

private struct ChannelResponse: Codable {
    let channels: [String: Channel]
}

private struct Channel: Codable {
    let name: String
    let stream: String
    let url: String
}

@MainActor
class PlayerViewModel: ObservableObject {
    @Published var videos: [Video] = []

    private let sampleVideos: [Video] = [
        Video(name: "BBCL", url: URL(string: "https://redirector.rudo.video/hls-video/339f69c6122f6d8f4574732c235f09b7683e31a5/bbtv/bbtv.smil/playlist.m3u8")!),
        Video(name: "Schlager Deluxe", url: URL(string: "https://sdn-global-live-streaming-packager-cache.3qsdn.com/26658/26658_264_live.m3u8")!),
        Video(name: "RTL 102.5", url: URL(string: "https://streamcdnc1-dd782ed59e2a4e86aabf6fc508674b59.msvdn.net/live/S97044836/tbbP8T1ZRPBL/playlist_video.m3u8")!),
        Video(name: "Antofagasta TV", url: URL(string: "https://unlimited1-us.dps.live/atv/atv.smil/playlist.m3u8")!),
        Video(name: "RadioItalia", url: URL(string: "https://radioitaliatv.akamaized.net/hls/live/2093117/RadioitaliaTV/master.m3u8")!)
    ]

    init() {
        Task { await loadVideos() }
    }

    private func loadVideos() async {
        guard let url = URL(string: "https://ums5rup13e.execute-api.eu-west-1.amazonaws.com/prod/api/preview/channels/preview_client") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(ChannelResponse.self, from: data)
            let remote = response.channels.values.map { Video(name: $0.name, url: URL(string: $0.url)!) }
            self.videos = sampleVideos + remote
        } catch {
            print("Failed to fetch videos:", error)
        }
    }

    // Add functions for fetching/updating video list if needed
}
