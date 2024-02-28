import SwiftUI
import SwiftData
import AVKit


struct FullScreenImageView: View {
    let imageUrl: URL
    
    var body: some View {
        AsyncImage(url: imageUrl) { image in
            image.resizable()
                .scaledToFill()
                .blur(radius: 5)
        } placeholder: {
            Color.red.opacity(0.1)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct StreamingPlayerView: View {
    var body: some View {
        VStack {
            Text("lala")
        }
    }
}

struct StreamingBackgroundView: View {
    let url: String
    var body: some View {
        ZStack {
            FullScreenImageView(imageUrl: URL(string: url)!)
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.pink.opacity(0.8),
                    Color.purple.opacity(0.6)
                ]),
                startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        }
    }
}

struct MenuView: View {
    enum Tab { case home, news, player, bbtv, rtl, quad, settings }
    @State var selection: Tab = .home
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                NavigationStack {
                    HomeView()
                }
                .tabItem { Text("Home") }
                .tag(Tab.home)

                NavigationStack {
                    NewsView()
                }
                .tabItem { Text("News") }
                .tag(Tab.news)
                
                NavigationStack {
                    PlayerView()
                }
                .tabItem { Text("Player") }
                .tag(Tab.player)
                
                
                NavigationStack {
                    SettingsView()
                }
                .tabItem { Text("Settings") }
                .tag(Tab.settings)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.background(StreamingBackgroundView(url: "https://www.thinkgeoenergy.com/wp-content/uploads/2011/05/Antofagasta_Chile.jpg"))
            .ignoresSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}


#Preview {
    MenuView()
}
