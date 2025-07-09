import SwiftUI

struct ContentView: View {
    @State private var currentView : String = "MainView"
    @StateObject private var sharedData = SharedData()
    
    var body: some View {
        TabView(selection: $currentView) {
            MainView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Tab 1")
                }
                .tag("MainView")
            
            PreviousWalksView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Walks")
                }
                .tag("PreviousWalks")
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag("SettingsView")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WeatherApiInteraction())
}
