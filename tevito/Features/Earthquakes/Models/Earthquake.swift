import Foundation

struct Earthquake: Identifiable, Decodable {
    let id: Int
    let sourceId: String
    let timestamp: Date
    let latitude: Double
    let longitude: Double
    let magnitude: Double
    let depth: Double
    let additionalData: AdditionalData?

    struct AdditionalData: Decodable {
        let flynn_region: String?
    }

    enum CodingKeys: String, CodingKey {
        case id, sourceId, timestamp, latitude, longitude, magnitude, depth, additionalData
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        sourceId = try container.decode(String.self, forKey: .sourceId)
        timestamp = try container.decode(Date.self, forKey: .timestamp)
        // Decode latitude that may be a number or string
        if let lat = try? container.decode(Double.self, forKey: .latitude) {
            latitude = lat
        } else {
            let latString = try container.decode(String.self, forKey: .latitude)
            latitude = Double(latString) ?? 0
        }
        // Decode longitude that may be a number or string
        if let lon = try? container.decode(Double.self, forKey: .longitude) {
            longitude = lon
        } else {
            let lonString = try container.decode(String.self, forKey: .longitude)
            longitude = Double(lonString) ?? 0
        }
        // Decode magnitude that may be a number or string
        if let mag = try? container.decode(Double.self, forKey: .magnitude) {
            magnitude = mag
        } else {
            let magString = try container.decode(String.self, forKey: .magnitude)
            magnitude = Double(magString) ?? 0
        }
        // Decode depth that may be a number or string
        if let d = try? container.decode(Double.self, forKey: .depth) {
            depth = d
        } else {
            let depthString = try container.decode(String.self, forKey: .depth)
            depth = Double(depthString) ?? 0
        }
        additionalData = try container.decodeIfPresent(AdditionalData.self, forKey: .additionalData)
    }
}