import SwiftUI
import Firebase

class ContentViewModel: ObservableObject {
    @Published var showSplash: Bool = true
    @Published var brechos: [guiabrecho] = []
    @Published var favorites: [String: Bool] = [:] {
        didSet {
            saveFavorites()
        }
    }
    @Published var selectedCity: String = "Todos"
    @Published var isLoading: Bool = true

    private var db = Firestore.firestore()

    init() {
        loadFavorites()
        fetchBrechos()
    }

    var favoriteItems: [guiabrecho] {
        brechos.filter { isFavorite(id: $0.id ?? "") }
    }

    var availableCities: [String] {
        let cidades = Set(brechos.map { $0.city })
        return ["Todos"] + cidades.sorted()
    }

    var filteredBrechos: [guiabrecho] {
        if selectedCity == "Todos" {
            return brechos
        } else {
            return brechos.filter { $0.city == selectedCity }
        }
    }

    func fetchBrechos() {
        isLoading = true
        db.collection("brechos").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Erro ao buscar brechós: \(error.localizedDescription)")
                self.isLoading = false
                return
            }

            DispatchQueue.main.async {
                self.brechos = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: guiabrecho.self)
                } ?? []
                self.isLoading = false
            }
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
