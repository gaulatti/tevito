import SwiftUI

struct ContentView: View {
    enum Tab { case home, news, player, settings }
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
            .tabItem { Label("Player", systemImage: "play.tv") }
            .tag(Tab.player)

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
