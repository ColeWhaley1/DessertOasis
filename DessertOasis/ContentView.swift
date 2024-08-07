//
//  ContentView.swift
//  DessertOasis
//
//  Created by Cole Whaley on 8/6/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var desserts: [Dessert] = []
    @State private var errorMsg: String?
    @State private var isLoading: Bool = true

    var body: some View {
        NavigationSplitView {
            if isLoading {
                Text("")
            }
            List {
                if let errorMsg = errorMsg {
                    Text("Error: \(errorMsg)")
                } else {
                    ForEach(desserts, id: \.mealId) { dessert in
                        NavigationLink {
                            Text(dessert.mealName)
                        } label: {
                            Text(dessert.mealName)
                        }
                    }
                }
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
            // empty for now
#endif
            }
        } detail: {
            Text("Select an item")
        }
        .task {
            await fetchDesserts()
        }
    }
    
    private func fetchDesserts() async {
        do {
            desserts = try await getDesserts()
            isLoading = false
        } catch {
            errorMsg = "Failed to fetch desserts."
        }
    }
}

#Preview {
    ContentView()
}


