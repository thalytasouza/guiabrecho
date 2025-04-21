import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var showSplash: Bool = true
    @Published var showFavorites: Bool = false
    @Published var favorites: [Int: Bool] = [:] {
        didSet {
            saveFavorites()
        }
    }
    
    init() {
        loadFavorites()
    }
    
    func toggleFavorite(for id: Int) {
        favorites[id] = !(favorites[id] ?? false)
    }
    
    func isFavorite(id: Int) -> Bool {
        return favorites[id] ?? false
    }
    
    var favoriteItems: [guiabrecho] {
        BrechoData.all.filter { isFavorite(id: $0.id) }
    }
    
    private func saveFavorites() {
        let data = try? JSONEncoder().encode(favorites)
        UserDefaults.standard.set(data, forKey: "favorites")
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favorites"),
           let savedFavorites = try? JSONDecoder().decode([Int: Bool].self, from: data) {
            favorites = savedFavorites
        }
    }
}
