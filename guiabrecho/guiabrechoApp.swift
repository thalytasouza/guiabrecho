import MapKit

class Brecho: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var brechoDescription: String?
    var phoneNumber: String?

    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, description: String?, phoneNumber: String?) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.brechoDescription = description
        self.phoneNumber = phoneNumber
    }
}

