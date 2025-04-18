import SwiftUI
import AVKit

// Video struct is in Features/Player/Models/Video.swift
// VideoDetailView struct is in Features/Player/Views/VideoDetailView.swift
// PlayerViewModel is in Features/Player/ViewModels/PlayerViewModel.swift

struct PlayerView: View {
    // Inject the ViewModel
    @StateObject private var viewModel = PlayerViewModel()

    // Removed hardcoded videos array

    var body: some View {
        // Use viewModel.videos in the List
        List(viewModel.videos) { video in
            NavigationLink(video.name, destination: VideoDetailView(video: video))
        }
        .navigationTitle("Live Streams") // Add a title
    }
}

// Renamed preview struct
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        // Wrap in NavigationView for preview context
        NavigationView {
            PlayerView()
        }
    }
}
