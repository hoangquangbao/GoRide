//
//  HomeView.swift
//  GoRide
//
//  Created by Quang Bao on 15/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState: MapViewState = .noInput
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack(alignment: .top) {
            
            GoRideMapViewRepresentable()
                .edgesIgnoringSafeArea(.all)
            
            if mapState == .searchingForLocation {
                LocationSearchView(mapState: $mapState)
            } else if mapState == .noInput {
                LocationSearchActivationView()
                    .onTapGesture {
                        withAnimation {
                            mapState = .searchingForLocation
                        }
                    }
            }
            
            MapViewActionButton(mapState: $mapState)
        }
//        .preferredColorScheme(.dark)
        .foregroundColor(colorScheme == .light ? .black : .white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
