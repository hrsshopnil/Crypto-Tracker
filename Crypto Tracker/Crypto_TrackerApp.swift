//
//  Crypto_TrackerApp.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 25/11/24.
//

import SwiftUI
import SwiftData

@main
struct Crypto_TrackerApp: App {
    
    let container: ModelContainer
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView2()
//                .environmentObject(vm)
//                .modelContainer(container)
        }
    }
    
    init() {
        let schema = Schema([PortfolioItem.self])
        let config = ModelConfiguration("MyCoins", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }

        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
