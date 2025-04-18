import Foundation
import Combine

@MainActor
class EarthquakesViewModel: ObservableObject {
    @Published var earthquakes: [Earthquake] = []
    @Published var loading: Bool = false
    @Published var error: String?

    private var cancellables = Set<AnyCancellable>()
    private let url = URL(string: "https://api.nazca.gaulatti.com/")!

    init() {
        fetchData()
        Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.fetchData() }
            .store(in: &cancellables)

        Timer.publish(every: 3600, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.earthquakes = []
                self?.fetchData()
            }
            .store(in: &cancellables)
    }

    func fetchData() {
        loading = true
        error = nil
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        // Support fractional seconds in ISO8601 timestamps
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            if let date = isoFormatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Invalid date: \(dateString)"
                )
            )
        }
        print("[EarthquakesViewModel] Fetching earthquakes from URL: \(url)")
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                // Print response status
                if let http = response as? HTTPURLResponse {
                    print("[EarthquakesViewModel] HTTP status code: \(http.statusCode)")
                } else {
                    print("[EarthquakesViewModel] Non-HTTP response: \(response)")
                }
                // Print raw JSON string
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("[EarthquakesViewModel] Raw JSON data: \(jsonString)")
                } else {
                    print("[EarthquakesViewModel] Could not convert data to string")
                }
                // Debug parse via JSONSerialization
                do {
                    let obj = try JSONSerialization.jsonObject(with: data, options: [])
                    print("[EarthquakesViewModel] JSON object parsed: \(obj)")
                } catch {
                    print("[EarthquakesViewModel] JSONSerialization error: \(error)")
                }
                guard let http = response as? HTTPURLResponse,
                      (200..<300).contains(http.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Earthquake].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.loading = false
                switch completion {
                case .failure(let err):
                    print("[EarthquakesViewModel] Decode/network error: \(err)")
                    self.error = err.localizedDescription
                case .finished:
                    print("[EarthquakesViewModel] Finished successfully")
                }
            } receiveValue: { [weak self] quakes in
                print("[EarthquakesViewModel] Received \(quakes.count) earthquakes")
                self?.earthquakes = quakes
            }
            .store(in: &cancellables)
    }
}
