//
//  LocationSearchActivationView.swift
//  GoRide
//
//  Created by Quang Bao on 16/03/2023.
//

import SwiftUI

struct LocationSearchActivationView: View {
    
    @State var whereTo: String = ""

    var body: some View {
        HStack {
            Image(systemName: "arrow.triangle.branch")
                .font(.title3)
                .padding(.horizontal,5)
                .foregroundColor(.black)
            
            TextField("", text: $whereTo)
                .textFieldStyle(PlaceholderTextFieldStyle("Where to?", text: $whereTo))
        }
        .padding(12)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
        .shadow(color: .black, radius: 5)
        .padding(.horizontal)
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
