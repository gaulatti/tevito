import Foundation
import Combine // Import Combine for ObservableObject

@MainActor // Ensure UI updates happen on the main thread
class NewsViewModel: ObservableObject {
    @Published var newsItems: [NewsItem] = []

    init() {
        // Load initial sample data
        loadSampleData()
    }

    func loadSampleData() {
        // Replace with actual data fetching logic later
        self.newsItems = [
            NewsItem(timestamp: Date().addingTimeInterval(-3600), headline: "Major Tech Announcement Expected Today", summary: "Sources say a groundbreaking product will be unveiled.", source: "Tech News Today"),
            NewsItem(timestamp: Date().addingTimeInterval(-7200), headline: "Global Markets React to Economic Data", summary: nil, source: "Financial Times"),
            NewsItem(timestamp: Date().addingTimeInterval(-10800), headline: "New Environmental Regulations Proposed", summary: "Details emerge on the proposed changes.", source: "Gov Watch"),
            NewsItem(timestamp: Date().addingTimeInterval(-14400), headline: "Sports Championship Results", summary: "Team A clinches victory in a thrilling final match.", source: "Sports Report")
        ]
    }

    // Add functions for fetching real-time data, refreshing, etc. later
    // func fetchNews() { ... }
}
