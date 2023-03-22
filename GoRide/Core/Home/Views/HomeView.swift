//
//  HomeView.swift
//  GoRide
//
//  Created by Quang Bao on 15/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isShowLocationSearchView: Bool = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack(alignment: .top) {
            
            GoRideMapViewRepresentable()
                .edgesIgnoringSafeArea(.all)
            
            if isShowLocationSearchView {
                LocationSearchView(isShowLocationSearchView: $isShowLocationSearchView)
            } else {
                LocationSearchActivationView()
                    .onTapGesture {
                        withAnimation {
                            isShowLocationSearchView.toggle()
                        }
                    }
            }
            
            MapViewActionButton(isShowLocationSearchView: $isShowLocationSearchView)
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
