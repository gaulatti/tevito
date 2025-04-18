import Foundation

struct Video: Identifiable {
    let id = UUID() // Unique identifier for SwiftUI Lists
    let name: String
    let url: URL
}
