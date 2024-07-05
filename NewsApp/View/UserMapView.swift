import SwiftUI
import GoogleMaps

struct UserMapView: UIViewRepresentable {
    var latitude: Double
    var longitude: Double
    var userName: String
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = userName
        marker.map = mapView
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
        mapView.camera = camera
        
        if let marker = mapView.selectedMarker {
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.title = userName
        } else {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.title = userName
            marker.map = mapView
        }
    }
}

#Preview {
    UserMapView(latitude: 37.7749, longitude: -122.4194, userName: "User 1")
}

