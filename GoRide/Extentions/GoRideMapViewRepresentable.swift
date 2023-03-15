//
//  MapViewRepresentable.swift
//  GoRide
//
//  Created by Quang Bao on 15/03/2023.
//

import SwiftUI
import MapKit

struct GoRideMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                mapView.userTrackingMode = .follow
            }
        }
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension GoRideMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: GoRideMapViewRepresentable
        
        init(parent: GoRideMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // Tells the delegate when the map view updates the user's location
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center:
                                                CLLocationCoordinate2D(
                                                    latitude: userLocation.coordinate.latitude,
                                                    longitude: userLocation.coordinate.longitude),
                                            span:
                                                MKCoordinateSpan(
                                                    latitudeDelta: 0.05,
                                                    longitudeDelta: 0.05))
            print("User location: \(region.center)")

            parent.mapView.setRegion(region, animated: true)
        }
    }
}
