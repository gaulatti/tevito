import SwiftUI

struct EarthquakeTickerView: View {
    let quakes: [Earthquake]
    @State private var animate = false

    var body: some View {
        GeometryReader { geo in
            let labels = quakes.map { quake -> String in
                let utc = formattedDate(quake.timestamp, utc: true)
                let local = formattedDate(quake.timestamp, utc: false)
                return "[Local: \(local)] [UTC: \(utc)] | \(quake.additionalData.flynn_region) | M\(String(format: "%.1f", quake.magnitude))"
            }
            let totalWidth = CGFloat(labels.count) * (geo.size.width / max(1, CGFloat(labels.count))) * 2

            HStack(spacing: 0) {
                ForEach(labels, id: \.self) { label in
                    Text(label)
                        .foregroundColor(colorForLabel(label: label, quake: quakes[labels.firstIndex(of: label)!]))
                        .padding(.horizontal, 20)
                }
                ForEach(labels, id: \.self) { label in
                    Text(label)
                        .foregroundColor(colorForLabel(label: label, quake: quakes[labels.firstIndex(of: label)!]))
                        .padding(.horizontal, 20)
                }
            }
            .offset(x: animate ? -totalWidth/2 : 0)
            .onAppear {
                withAnimation(.linear(duration: Double(totalWidth) / 50).repeatForever(autoreverses: false)) {
                    animate = true
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

    private func colorForLabel(label: String, quake: Earthquake) -> Color {
        return quake.magnitude >= 5 ? .red : .white
    }
}
