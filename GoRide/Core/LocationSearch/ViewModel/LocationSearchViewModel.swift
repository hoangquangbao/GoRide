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
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            NSLog("DEBUG Query Fragment: \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
//        searchCompleter.queryFragment = queryFragment
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
