import Foundation

struct NewsItem: Identifiable, Hashable {
    let id = UUID()
    let timestamp: Date
    let headline: String
    let summary: String? // Optional summary
    let source: String? // Optional source
    // Add other relevant properties like image URL, author, etc. later
}
