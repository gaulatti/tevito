import SwiftUI
import MapKit

struct EarthquakesView: View {
    @StateObject private var viewModel = EarthquakesViewModel()
    @State private var currentIndex = 0
    private let switchTimer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Group {
                switch currentIndex {
                case 0:
                    GlobalMapView(earthquakes: viewModel.earthquakes)
                case 1:
                    RegionalMapView(earthquakes: viewModel.earthquakes)
                default:
                    DetailedView(quakes: viewModel.earthquakes.filter { $0.magnitude >= 5 })
                }
            }
            .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                EarthquakeTickerView(quakes: viewModel.earthquakes)
            }
        }
        .onReceive(switchTimer) { _ in
            currentIndex = (currentIndex + 1) % 3
        }
        .overlay {
            if viewModel.loading {
                ProgressView("Loading earthquakes...")
            }
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}