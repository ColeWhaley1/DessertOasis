//
//  DessertOasisApp.swift
//  DessertOasis
//
//  Created by Cole Whaley on 8/6/24.
//

import SwiftUI
import SwiftData

@main
struct DessertOasisApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State var isSplashActive: Bool = true

    var body: some Scene {
        WindowGroup {
            if isSplashActive {
                LoadingScreen(isActive: $isSplashActive)
            }
            
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
