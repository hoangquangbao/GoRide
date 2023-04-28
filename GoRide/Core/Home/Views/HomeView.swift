//
//  HomeView.swift
//  GoRide
//
//  Created by Quang Bao on 15/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState: MapViewState = .noInput
    @EnvironmentObject var vm: LocationSearchViewModel
    @State var isShowSheet: Bool = false
    
    // Gesture Properties
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    //    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
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
                
                MapViewActionButton(mapState: $mapState,
                                    offset: $offset)
            }
            
            if mapState == .locationSelected || mapState == .polylineAdded {
                GeometryReader { proxy in
                    ZStack(alignment: .bottom) {
                        VStack {
                            Spacer()
                            RideRequestView()
                        }
                    }
                    .offset(y: offset)
                    .gesture(
                        DragGesture()
                            .updating($gestureOffset, body: { value, out, _ in
                                out = value.translation.height
                                DispatchQueue.main.async {
                                    self.offset = gestureOffset + lastOffset
                                }
                            })
                            .onEnded({ value in
                                withAnimation {
                                    /// Logic conditions for moving states..
                                    /// Drag UP
                                    if offset < 0 {
                                        offset = 0
                                    }
                                    /// Drag DOWN
                                    else if offset > 0 && proxy.size.height - offset < 400 {
                                        offset = 400
                                    }
                                }
                                /// Storing last offset...
                                /// So that the gesture can continue from the last position
                                lastOffset = offset
                            })
                    )
                }
                .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        //        .foregroundColor(colorScheme == .light ? .black : .white)
        .background(Color.theme.backgroundColor)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                vm.userLocation = location
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
