//
//  RideRequestView.swift
//  GoRide
//
//  Created by Quang Bao on 27/03/2023.
//

import SwiftUI

struct RideRequestView: View {
    
    @State private var selectedRideType: RideType = .allCases[0]
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
        
    var body: some View {
            VStack {
                Capsule()
                    .foregroundColor(Color(.systemGray3))
                    .frame(width: 50, height: 6)
                    .padding(.top,5)
                
                /* Trip info view */
                //header view
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Rectangle()
                                .frame(width: 6, height: 6)
                                .frame(width: 30)
                            
                            Text("Current location")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(locationViewModel.pickupTime ?? "")
                        }
                        .font(.system(.subheadline))
                        .foregroundColor(.gray)
                        
                        Rectangle()
                            .fill(Color(.systemGray2))
                            .frame(width: 1, height: 10)
                            .frame(width: 30)
                        
                        HStack {
                            Rectangle()
                                .frame(width: 6, height: 6)
                                .padding(3)
                                .overlay {
                                    Rectangle()
                                        .stroke(.green)
                                }
                                .frame(width: 30)
                            
                            if let selectedGorideLocation = locationViewModel.selectedGorideLocation?.title {
                                Text(selectedGorideLocation)
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer()
                            
                            Text(locationViewModel.dropOffTime ?? "")
                        }
                        .font(.system(.subheadline))
                        
                        Rectangle()
                            .fill(Color(.systemGray2))
                            .frame(width: 1, height: 10)
                            .frame(width: 30)
                        
                        HStack {
                            Image("img_distance")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                                .frame(width: 30)
                            
                            Text("Distantion")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text((locationViewModel.tripDistanceInKilometers ?? 0.00).toDistanceInKilometers())
                        }
                        .font(.system(.subheadline))
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                /* Ride type selection view */
                Text("SUGGESTED RIDES")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .foregroundColor(Color.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 10) {
                        ForEach(RideType.allCases, id: \.self) { type in
                            VStack(alignment: .center) {
                                Image(type.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                
                                Group {
                                    Text(type.description)
                                        .font(.system(size: 10))
                                        .padding(.vertical, 5)
                                    
                                    Text(locationViewModel.computeRidePrice(forType: type).toCurrency())
                                }
                                .font(.system(.subheadline, weight: .bold))
                                .foregroundColor(.black)
                            }
                            .scaleEffect(selectedRideType == type ? 1.2 : 0.9)
                            .frame(width: 140, height: 210)
                            .background(content: {
                                Capsule()
                                    .fill(
                                        (selectedRideType == type ? .yellow.opacity(0.9) : .white.opacity(0.8))
                                    )
                                    .overlay {
                                        Capsule()
                                            .stroke(selectedRideType == type ? .yellow : .gray.opacity(0.2), lineWidth: 1)
                                    }
                            })
                            .animation(.linear(duration: 0.25), value: selectedRideType)
                            .onTapGesture {
                                selectedRideType = type
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                    .padding(.vertical,5)
                
                /* Payment option view */
                Button {
                    
                } label: {
                    HStack(spacing: 12) {
                        Text("Visa")
                            .font(.system(.subheadline, weight: .bold))
                            .foregroundColor(.yellow)
                            .padding(6)
                            .background(.black)
                            .cornerRadius(5)
                        
                        Text("***** 1234")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .imageScale(.medium)
                    }
                    .padding(.horizontal,8)
                    .frame(height: 50)
                    .background(Color.secondary)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                
                /* Request ride button */
                Button {
                    
                } label: {
                    Text("CONFIRM RIDE")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .cornerRadius(20)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom, 20)
            .background(
                Color.theme.secondaryBackgroundColor
            )
            .clipShape(customCorner(corner: [.topRight, .topLeft], radius: 25))
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
