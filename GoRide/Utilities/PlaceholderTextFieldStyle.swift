//
//  PlaceholderTextFieldStyle.swift
//  GoRide
//
//  Created by Quang Bao on 16/03/2023.
//

import SwiftUI

struct PlaceholderTextFieldStyle: TextFieldStyle {
    let placeholder: String
    @Binding var text: String

    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
            }
            configuration
        }
        
    }
}
