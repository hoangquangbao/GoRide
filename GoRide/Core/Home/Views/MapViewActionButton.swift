//
//  MapViewActionButton.swift
//  GoRide
//
//  Created by Quang Bao on 16/03/2023.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var mapState: MapViewState
    @Binding var offset: CGFloat
    @EnvironmentObject var vm: LocationSearchViewModel
    
    var body: some View {
        
        HStack {
            Button {
                actionForState(mapState)
                offset = 0
            } label: {
                Image(systemName: imageNameForState(mapState))
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(width: 45, height: 45)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(color: .black, radius: 6)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            print("DEBUG: No input")
        case .locationSelected, .polylineAdded:
            print("DEBUG: Location selected - Clear map view")
            mapState = .noInput
            /* Fixed bug: duplicate selected of location */
            vm.selectedGorideLocation = nil
        case .searchingForLocation:
            mapState = .noInput
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal.decrease"
        case .locationSelected, .searchingForLocation, .polylineAdded:
            return "arrow.backward"
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            MapViewActionButton(mapState: .constant(.noInput),
                                offset: .constant(0))
            MapViewActionButton(mapState: .constant(.searchingForLocation),
                                offset: .constant(0))
        }
    }
}
