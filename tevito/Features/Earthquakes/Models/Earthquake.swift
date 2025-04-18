import Foundation

struct Earthquake: Identifiable, Decodable {
    let id: Int
    let sourceId: String
    let timestamp: Date
    let latitude: Double
    let longitude: Double
    let magnitude: Double
    let depth: Double
    let additionalData: AdditionalData

    struct AdditionalData: Decodable {
        let flynn_region: String
    }

    enum CodingKeys: String, CodingKey {
        case id, sourceId, timestamp, latitude, longitude, magnitude, depth, additionalData
    }
}