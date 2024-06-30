import SwiftUI

@main
struct BrechoApp: App {
    let minhaCor = Color(red: 0.7098, green: 0.3647, blue: 0.0196)
    let minhaCorAmarela = Color(red: 0.90, green: 0.66, blue: 0.00)
    
    @StateObject private var contentViewModel = ContentViewModel()
    @State private var showFavorites = false
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(contentViewModel)
                .background(minhaCorAmarela)
                .navigationBarHidden(true)
        }
    }
}
