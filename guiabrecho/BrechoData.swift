import SwiftUI
import Foundation
import CoreLocation
import Firebase
import FirebaseFirestore

struct guiabrecho: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var subtitle: String
    var description: String?
    var phoneNumber: String?
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
