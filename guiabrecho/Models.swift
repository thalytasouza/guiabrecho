import SwiftUI
import Firebase

class ContentViewModel: ObservableObject {
    @Published var showSplash: Bool = true
    @Published var showFavorites: Bool = false
    @Published var brechos: [guiabrecho] = []
    @Published var favorites: [String: Bool] = [:] {
        didSet {
            saveFavorites()
        }
    }
    
    var favoriteItems: [guiabrecho] {
        brechos.filter { isFavorite(id: $0.id ?? "") }
    }

    private var db = Firestore.firestore()

    init() {
        loadFavorites()
        fetchBrechos()
    }
    
    func fetchBrechos() {
        db.collection("brechos").getDocuments { snapshot, error in
            if let error = error {
                print("Erro ao buscar brechós: \(error.localizedDescription)")
                return
            }

            self.brechos = snapshot?.documents.compactMap { doc -> guiabrecho? in
                try? doc.data(as: guiabrecho.self)
            } ?? []
        }
    }

    func toggleFavorite(for id: String?) {
        guard let id = id else { return }
        favorites[id] = !(favorites[id] ?? false)
    }

    func isFavorite(id: String?) -> Bool {
        guard let id = id else { return false }
        return favorites[id] ?? false
    }
    
    private func saveFavorites() {
        let data = try? JSONEncoder().encode(favorites)
        UserDefaults.standard.set(data, forKey: "favorites")
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favorites"),
           let savedFavorites = try? JSONDecoder().decode([String: Bool].self, from: data) {
            favorites = savedFavorites
        }
    }
}

