import SwiftUI
import MapKit

struct DetailedView: View {
    let quakes: [Earthquake]
    @State private var selectedQuakeIndex = 0

    var body: some View {
        if quakes.isEmpty {
            Text("No significant earthquakes (M ≥ 5) in the last hour.")
                .foregroundColor(.gray)
                .font(.headline)
        } else {
            TabView(selection: $selectedQuakeIndex) {
                ForEach(quakes.indices, id: \ .self) { idx in
                    let quake = quakes[idx]
                    VStack(alignment: .leading, spacing: 16) {
                        Map(coordinateRegion: .constant(
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: quake.latitude, longitude: quake.longitude),
                                span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
                            )
                        ), annotationItems: [quake]) { item in
                            MapMarker(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude), tint: .red)
                        }
                        .frame(height: 200)
                        Text("Magnitude: \(quake.magnitude, specifier: "%.1f")")
                            .font(.title)
                        Text("Location: \(quake.additionalData?.flynn_region)")
                        Text("Depth: \(quake.depth, specifier: "%.1f") km")
                        Text("Coordinates: [\(quake.latitude), \(quake.longitude)]")
                        Text("Time (UTC): \(formattedDate(quake.timestamp, utc: true))")
                        Text("Time (Local): \(formattedDate(quake.timestamp, utc: false))")
                    }
                    .padding()
                    .tag(idx)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
    }

    private func formattedDate(_ date: Date, utc: Bool) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.timeZone = utc ? TimeZone(abbreviation: "UTC") : .current
        return formatter.string(from: date)
    }
}
