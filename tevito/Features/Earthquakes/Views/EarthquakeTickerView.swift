import SwiftUI

struct EarthquakeTickerView: View {
    let quakes: [Earthquake]
    @State private var animate = false

    var body: some View {
        GeometryReader { geo in
            if quakes.isEmpty {
                Text("No recent earthquakes to display")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.7))
            } else {
                // Build labels and scroll HStack
                let labels = quakes.enumerated().map { idx, quake -> (id: Int, text: String, color: Color) in
                    let utc = formattedDate(quake.timestamp, utc: true)
                    let local = formattedDate(quake.timestamp, utc: false)
                    let region = quake.additionalData?.flynn_region ?? "Unknown region"
                    let text = "[Local: \(local)] [UTC: \(utc)] | \(region) | M\(String(format: "%.1f", quake.magnitude))"
                    let color: Color = quake.magnitude >= 5 ? .red : .white
                    return (id: idx, text: text, color: color)
                }
                let totalWidth = geo.size.width * 2
                HStack(spacing: 0) {
                    ForEach(Array(labels + labels), id: \.0) { item in
                        Text(item.text)
                            .foregroundColor(item.color)
                            .lineLimit(1)
                            .padding(.horizontal, 20)
                    }
                }
                .offset(x: animate ? -totalWidth : 0)
                .onAppear {
                    withAnimation(.linear(duration: Double(totalWidth) / 50).repeatForever(autoreverses: false)) {
                        animate = true
                    }
                }
            }
        }
        .frame(height: 30)
        .background(Color.black.opacity(0.7))
    }

    private func formattedDate(_ date: Date, utc: Bool) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.timeZone = utc ? TimeZone(abbreviation: "UTC") : .current
        return formatter.string(from: date)
    }
}
