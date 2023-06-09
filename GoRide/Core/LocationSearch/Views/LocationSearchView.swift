//
//  LocationSearchView.swift
//  GoRide
//
//  Created by Quang Bao on 16/03/2023.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText: String = ""
    @Binding var mapState: MapViewState
    
    @EnvironmentObject var vm: LocationSearchViewModel
    
    var body: some View {
        VStack {
            //header view
            HStack {
                VStack {
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 25)
                    
                    Rectangle()
                        .frame(width: 6, height: 6)
                        .padding(3)
                        .overlay {
                            Rectangle()
                                .stroke(.green)
                        }
                }
                
                VStack {
                    TextField("Current Location", text: $startLocationText)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    TextField("Where to", text: $vm.queryFragment)
                        .padding(8)
                        .background(Color(.systemGray3))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
            .padding(.top, 64)
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical)
            
            //list view
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(vm.result, id: \.self) { result in
                        LocationSearchResultCell(title: result.title,
                                                 subtitle: result.subtitle)
                        .onTapGesture {
                            
                            withAnimation(.spring(response: 0.7,
                                                  dampingFraction: 0.9,
                                                  blendDuration: 0.5)) {
                                vm.selectLocation(result)
                                mapState = .locationSelected
                            }
                        }
                    }
                }
            }
        }
        .background()
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.searchingForLocation))
    }
}
