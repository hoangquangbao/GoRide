//
//  LocationSearchResultCell.swift
//  GoRide
//
//  Created by Quang Bao on 16/03/2023.
//

import SwiftUI
import MapKit

struct LocationSearchResultCell: View {
    
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .resizable()
                .foregroundStyle(.green, .gray)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.body)
                
                Text(subtitle)
                    .font(.callout)
                    .foregroundColor(.secondary)
                
                Divider()
            }
            .padding(.leading, 6)
        }
        .frame(height: 70)
        .padding(.horizontal)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    
    static let result: MKLocalSearchCompletion = {
        let completion = MKLocalSearchCompletion()
        return completion
    }()
    
    static var previews: some View {
        LocationSearchResultCell(title: "123 Street",
                                 subtitle: "Viet Nam, VN")
    }
}
