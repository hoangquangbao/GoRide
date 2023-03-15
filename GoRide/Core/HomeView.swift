//
//  HomeView.swift
//  GoRide
//
//  Created by Quang Bao on 15/03/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GoRideMapViewRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
