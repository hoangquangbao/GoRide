//
//  MapViewActionButton.swift
//  GoRide
//
//  Created by Quang Bao on 16/03/2023.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var isShowLocationSearchView: Bool
    
    var body: some View {
        
        HStack {
            Button {
                if isShowLocationSearchView {
                    withAnimation {
                        isShowLocationSearchView.toggle()
                    }
                }
            } label: {
                Image(systemName: isShowLocationSearchView ? "arrow.backward" : "line.3.horizontal.decrease")
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
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            MapViewActionButton(isShowLocationSearchView: .constant(true))
            MapViewActionButton(isShowLocationSearchView: .constant(false))
        }
    }
}
