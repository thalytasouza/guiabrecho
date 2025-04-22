import Firebase
import FirebaseFirestore
import CoreLocation

class BrechoViewModel: ObservableObject {
    @Published var brechos: [guiabrecho] = []
    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("brechos").getDocuments { snapshot, error in
            if let error = error {
                print("Erro ao buscar dados: \(error)")
                return
            }

            self.brechos = snapshot?.documents.compactMap { doc -> guiabrecho? in
                let data = doc.data()

                guard let id = data["id"] as? String,
                      let title = data["title"] as? String,
                      let subtitle = data["subtitle"] as? String,
                      let latitude = data["latitude"] as? Double,
                      let longitude = data["longitude"] as? Double,
                      let city = data["city"] as? String else {
                    return nil
                }

                return guiabrecho(
                    id: id,
                    title: title,
                    subtitle: subtitle,
                    description: data["description"] as? String,
                    phoneNumber: data["phoneNumber"] as? String,
                    latitude: latitude,
                    longitude: longitude,
                    city: city
                )
            } ?? []
        }
    }
}
