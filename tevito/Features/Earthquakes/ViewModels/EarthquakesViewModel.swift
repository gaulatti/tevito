import Foundation
import Combine

@MainActor
class EarthquakesViewModel: ObservableObject {
    @Published var earthquakes: [Earthquake] = []
    @Published var loading: Bool = false
    @Published var error: String?

    private var cancellables = Set<AnyCancellable>()
    private let url = URL(string: "https://api.nazca.gaulatti.com")!

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
        decoder.dateDecodingStrategy = .iso8601
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Earthquake].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.loading = false
                switch completion {
                case .failure(let err): self.error = err.localizedDescription
                case .finished: break
                }
            } receiveValue: { [weak self] quakes in
                self?.earthquakes = quakes
            }
            .store(in: &cancellables)
    }
}