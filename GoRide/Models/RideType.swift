//
//  RideType.swift
//  GoRide
//
//  Created by Quang Bao on 29/03/2023.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case buggati
    case ferrari
    case rangerover
    case rollroyce
    
    var id: Int {
        return rawValue
    }
    
    var description: String {
        switch self {
        case .buggati:
            return "Bugatti Chiron"
        case .ferrari:
            return "La-Ferrari Aperta"
        case .rangerover:
            return "Rangerover SV"
        case .rollroyce:
            return "Rolls-Royce Phantom"
        }
    }
    
    var imageName: String {
        switch self {
        case .buggati:
            return "img_bugatti_chiron"
        case .ferrari:
            return "img_la-ferrari"
        case .rangerover:
            return "img_rangerover_sv"
        case .rollroyce:
            return "img_rollsroyce_phantom"
        }
    }
    
    var price: String {
        switch self {
        case .buggati:
            return "$150"
        case .ferrari:
            return "$120"
        case .rangerover:
            return "$40"
        case .rollroyce:
            return "$80"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .buggati:
            return 20
        case .ferrari:
            return 16
        case .rangerover:
            return 8
        case .rollroyce:
            return 14
        }
    }
    
    func computePrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1000
        
        switch self {
        case .buggati:
            return distanceInMiles * 2.0 + baseFare
        case .ferrari:
            return distanceInMiles * 1.5 + baseFare
        case .rangerover:
            return distanceInMiles * 0.5 + baseFare
        case .rollroyce:
            return distanceInMiles * 1.0 + baseFare
        }
    }
}
