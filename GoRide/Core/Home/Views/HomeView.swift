//
//  HomeView.swift
//  GoRide
//
//  Created by Quang Bao on 15/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState: MapViewState = .noInput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                
                GoRideMapViewRepresentable(mapState: $mapState)
                    .edgesIgnoringSafeArea(.all)
                
                if mapState == .searchingForLocation {
                    LocationSearchView(mapState: $mapState)
                } else if mapState == .noInput {
                    LocationSearchActivationView()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mapState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState)
            }
            
            if mapState == .locationSelected {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
//        .preferredColorScheme(.dark)
        .foregroundColor(colorScheme == .light ? .black : .white)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                locationViewModel.userLocation = location
                print("DEBUG: User location in home view is \(location)")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
