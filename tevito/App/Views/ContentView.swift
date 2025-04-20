import SwiftUI
// Remove feature module imports

struct ContentView: View {
    enum Tab { case home, news, player, earthquakes, settings }
    @State private var selection: Tab = .home

    var body: some View {
        TabView(selection: $selection) {
            // Ensure these views are correctly imported if needed, though Swift might find them automatically
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
                .tag(Tab.home)

            // Wrap NewsView in NavigationStack if it needs internal navigation
            NavigationStack {
                NewsView()
            }
            .tabItem { Label("News", systemImage: "newspaper") }
            .tag(Tab.news)

            // Wrap PlayerView in NavigationStack to enable NavigationLink
            NavigationStack {
                PlayerView()
            }
            .tabItem { Label("Router", systemImage: "play.tv") }
            .tag(Tab.player)

            // New Earthquakes section
            NavigationStack {
                EarthquakesView()
            }
            .tabItem { Label("Nazca", systemImage: "globe.europe.africa") }
            .tag(Tab.earthquakes)

            // Wrap SettingsView in NavigationStack if it needs internal navigation
            NavigationStack {
                SettingsView()
            }
            .tabItem { Label("Settings", systemImage: "gear") }
            .tag(Tab.settings)
        }
    }
}

#Preview {
    ContentView()
}
