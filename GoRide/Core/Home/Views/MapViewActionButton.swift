//
//  MapViewActionButton.swift
//  GoRide
//
//  Created by Quang Bao on 16/03/2023.
//

import SwiftUI

struct MapViewActionButton: View {
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "line.3.horizontal")
                .font(.title2)
                .foregroundColor(.black)
                .padding(12)
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton()
    }
}
