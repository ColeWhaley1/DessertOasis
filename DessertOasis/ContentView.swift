import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isLoading: Bool = true
    @State private var desserts: [Dessert] = []
    @State private var errorMsg: String?
    @State private var splashScreenAnimationDone: Bool = false
    @State private var contentOpacity: Double = 0.0

    var body: some View {
        ZStack {
            NavigationSplitView {
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
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            } detail: {
                Text("Select an item")
            }
            .task {
                await fetchDesserts()
                await delaySplashScreen()
            }
            .opacity(contentOpacity)
            
            if isLoading || !splashScreenAnimationDone {
                LoadingScreen()
            }
            
        }
    }

    func fetchDesserts() async {
        do {
            desserts = try await getDesserts()
            isLoading = false
        } catch {
            errorMsg = "Failed to fetch desserts."
            isLoading = false
        }
    }
    
    func delaySplashScreen() async {
        try? await Task.sleep(nanoseconds: 3_000_000_000) // 3 seconds delay
        splashScreenAnimationDone = true
        contentOpacity = 1.0
    }
}

#Preview {
    ContentView()
}
