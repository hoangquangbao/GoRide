//
//  FormatNumber.swift
//  GoRide
//
//  Created by Quang Bao on 26/04/2023.
//

import Foundation

extension Double {
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        /*
         IOS Locale Identifiers
         https://woosignal.com/docs/app/ios-locale-identifiers-list
         */
//        formatter.locale = Locale(identifier: "vi_VN")
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrency() -> String {
        return currencyFormatter.string(from: self as NSNumber) ?? ""
    }
}
