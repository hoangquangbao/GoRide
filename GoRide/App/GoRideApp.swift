//
//  GoRideApp.swift
//  GoRide
//
//  Created by Quang Bao on 15/03/2023.
//

import SwiftUI

@main
struct GoRideApp: App {
    
    @StateObject var vm = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
