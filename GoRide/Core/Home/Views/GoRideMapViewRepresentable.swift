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
//    let locationManager = LocationManager.shared
    
    @Binding var mapState: MapViewState
    
    @EnvironmentObject var vm: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("DEBUG: Map state is \(mapState)")

        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecentUserLocation()
            break
        case .locationSelected:
            if let coordinate = vm.selectLocationCoordinate {
                print("DEBUG selected coordinates in map view: \(coordinate)")
                context.coordinator.addAndSelectAnnotation(withCoornadite: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        case .searchingForLocation:
            break
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension GoRideMapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: - Properties
        let parent: GoRideMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        // MARK: - Lifecycle
        init(parent: GoRideMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        // Tells the delegate when the map view updates the user's location
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center:
                                                CLLocationCoordinate2D(
                                                    latitude: userLocation.coordinate.latitude,
                                                    longitude: userLocation.coordinate.longitude),
                                            span:
                                                //set the desired zoom level of the map
                                                MKCoordinateSpan(
                                                    latitudeDelta: 0.05,
                                                    longitudeDelta: 0.05))
            print("User location: \(region.center)")
            
            // Get current region to process after clear the map view
            self.currentRegion = region
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 5
            
            return polyline
        }
        
        // MARK: - Helper
        
        func addAndSelectAnnotation(withCoornadite coordinate: CLLocationCoordinate2D) {
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            self.parent.mapView.addAnnotation(anno)
            self.parent.mapView.selectAnnotation(anno, animated: true)
            
            // Auto zoom the map view to fix the screen size
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            getDestinationRoute(from: userLocationCoordinate,
                                to: coordinate) { router in
                self.parent.mapView.addOverlay(router.polyline)
                
                /* Set the visible region with the aspect ratio as the map view's frame
                 */
                let rect = self.parent.mapView.mapRectThatFits(router.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))

                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        /* Get the router representing the direction between the start and end points.
         */
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping (MKRoute) -> Void) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlacemark = MKPlacemark(coordinate: destination)
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destPlacemark)
            
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                if let error = error {
                    print("DEBUG: Failed to get directions with error \(error)")
                    return
                }
                
                guard let router = response?.routes.first else { return }
                completion(router)
            }
        }
        
        func clearMapViewAndRecentUserLocation() {
            
            // Removing all annotations on the map view before adding new annotation
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            // Removes a previous router before drawing a new router on the map view
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
