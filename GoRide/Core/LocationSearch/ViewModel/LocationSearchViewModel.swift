//
//  LocationSearchViewModel.swift
//  GoRide
//
//  Created by Quang Bao on 21/03/2023.
//

import SwiftUI
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    @Published var result = [MKLocalSearchCompletion]()
    @Published var selectLocationCoordinate: CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            NSLog("DEBUG Query Fragment: \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        searchCompleter.delegate = self
//                searchCompleter.queryFragment = queryFragment
    }
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print(("DEBUG: Location seach faild with error: \(error)"))
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            
            self.selectLocationCoordinate = coordinate
            NSLog("DEBUG select location coordinates: \(coordinate)")
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler) {
        let seachRequest = MKLocalSearch.Request()
        seachRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: seachRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(forType type: RideType) -> Double  {
        guard let destCoordinate = selectLocationCoordinate else { return 0.0 }
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude,
                                      longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude,
                                     longitude: destCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
