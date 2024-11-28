//
//  Crypto_TrackerApp.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 25/11/24.
//

import SwiftUI

@main
struct Crypto_TrackerApp: App {
    @StateObject var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
