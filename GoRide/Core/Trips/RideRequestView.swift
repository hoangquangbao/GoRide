//
//  RideRequestView.swift
//  GoRide
//
//  Created by Quang Bao on 27/03/2023.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 50, height: 6)
            
            /* Trip info view */
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
                
                VStack(alignment: .leading, spacing: 25) {
                    HStack {
                        Text("Current location")
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("02:55 PM")
                    }
                    .font(.system(.subheadline))
                    .foregroundColor(.gray)
                    
                    HStack {
                        Text("Coffee Loves")
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("03:26 PM")
                    }
                    .font(.system(.subheadline))
                }
                .padding(.leading)
            }
            .padding()
            
            Divider()
            
            /* Ride type selection view */
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(Color.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 15) {
                    ForEach(1...5, id: \.self) { index in
                        VStack(alignment: .center) {
                            Image("img_bugatti")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                            
                            Group {
                                Text("Bugatti Chiron")
                                    .padding(.vertical, 10)
                                
                                Text("$150")
                                    .font(.system(size: 25))
                            }
                            .font(.system(.subheadline, weight: .bold))
                        }
                        .frame(width: 140, height: 220)
                        .background(content: {
                            Capsule()
                                .fill(.gray.opacity(0.2))
                        })
                    }
                }
                .padding(.horizontal)
            }
            
            Divider()
                .padding(.vertical,8)
            
            VStack(spacing: 20) {
                /* Payment option view */
                HStack(spacing: 12) {
                    Text("Visa")
                        .font(.system(.subheadline, weight: .bold))
                        .foregroundColor(.white)
                        .padding(6)
                        .background(.green)
                        .cornerRadius(10)
                    
                    Text("***** 1234")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .imageScale(.medium)
                }
                .padding(.horizontal,8)
                .frame(height: 50)
                .background(Color(.systemGroupedBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                
                /* Request ride button */
                Button {
                    
                } label: {
                    Text("CONFIRM RIDE")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
