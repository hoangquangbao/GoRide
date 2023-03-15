//
//  HomeView.swift
//  GoRide
//
//  Created by Quang Bao on 15/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State var whereTo: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            GoRideMapViewRepresentable()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 15) {
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 25, weight: .bold))
                        .padding(12)
                        .foregroundColor(.black)
                        .background(.white)
                        .clipShape(Circle())
                }
                
                HStack(spacing: 15) {
                    Image(systemName: "square.fill")
                        .font(.system(size: 12))
                    
                    TextField("Where to?", text: $whereTo)
                }
                .foregroundColor(.black)
                .padding(10)
                .background(.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                .padding(.horizontal)
            }
            .padding(.horizontal)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
