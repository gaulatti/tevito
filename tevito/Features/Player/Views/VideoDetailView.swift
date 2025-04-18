import SwiftUI
import AVKit

struct VideoDetailView: View {
    var video: Video
    // Change player to be a @State variable, initialized once
    @State private var player: AVPlayer

    // Initialize the player in the view's initializer
    init(video: Video) {
        self.video = video
        _player = State(initialValue: AVPlayer(url: video.url))
    }

    var body: some View {
        VideoPlayer(player: player)
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
            .onAppear {
                player.play() // Play when the view appears
            }
            .onDisappear {
                player.pause() // Pause when the view disappears
            }
            .toolbar(.hidden, for: .navigationBar) // Hide the navigation bar for this view
    }
}

// Add a preview if needed, requires a sample Video instance
#Preview {
    // Need to provide a valid URL for preview
    let sampleVideo = Video(name: "Sample", url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8")!) // Example Apple HLS stream
    return VideoDetailView(video: sampleVideo)
}
