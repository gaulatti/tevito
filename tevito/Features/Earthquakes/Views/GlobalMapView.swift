import SwiftUI
import MapKit

struct GlobalMapView: View {
    let earthquakes: [Earthquake]
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 360)
    )

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: earthquakes) { quake in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: quake.latitude, longitude: quake.longitude)) {
                Circle()
                    .fill(color(for: quake).opacity(0.6))
                    .frame(width: size(for: quake), height: size(for: quake))
                    .overlay(
                        Circle().stroke(color(for: quake), lineWidth: 2)
                    )
            }
        }
    }

    private func ageFraction(for quake: Earthquake) -> Double {
        let elapsed = Date().timeIntervalSince(quake.timestamp)
        return min(1, elapsed / 3600) // 0 to 1 over an hour
    }

    private func color(for quake: Earthquake) -> Color {
        let frac = ageFraction(for: quake)
        return Color(red: 1 - frac, green: frac, blue: 0)
    }

    private func size(for quake: Earthquake) -> CGFloat {
        CGFloat(quake.magnitude * 5)
    }
}
