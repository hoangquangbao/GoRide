//
//  LocationSearchResultCell.swift
//  GoRide
//
//  Created by Quang Bao on 16/03/2023.
//

import SwiftUI

struct LocationSearchResultCell: View {
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundStyle(.white, .green)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("TMA Innovation Park")
                    .font(.body)
                
                Text("P, 12 Đại lộ Khoa học, Thung lũng Sáng tạo, Ghềnh Ráng, Bình Định 55121, Vietnam")
                    .font(.callout)
                    .foregroundColor(.secondary)
                
                Divider()
            }
            .padding(.leading, 6)
        }
        .padding(.horizontal)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell()
    }
}
