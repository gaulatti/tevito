import SwiftUI

struct NewsView: View {
    // Inject the ViewModel
    @StateObject private var viewModel = NewsViewModel()

    var body: some View {
        // Use a List to display news items
        List {
            ForEach(viewModel.newsItems) { item in
                NewsItemRow(item: item)
            }
        }
        .navigationTitle("News Feed") // Add a title (will show if embedded in NavigationView)
        // Add .onAppear { viewModel.fetchNews() } // To fetch data when view appears
    }
}

// A simple view for displaying a single news item row
struct NewsItemRow: View {
    let item: NewsItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.headline)
                .font(.headline)
            Text(item.timestamp, style: .relative)
                .font(.caption)
                .foregroundColor(.secondary)
            if let summary = item.summary {
                Text(summary)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2) // Limit summary lines
            }
        }
        .padding(.vertical, 4) // Add some vertical padding
    }
}

#Preview {
    // Wrap in NavigationView for preview context if needed
    NavigationView {
        NewsView()
    }
}
