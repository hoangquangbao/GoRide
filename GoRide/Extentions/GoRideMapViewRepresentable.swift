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
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
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
    }
}
