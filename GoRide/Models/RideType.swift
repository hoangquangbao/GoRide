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
}
