import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isLoading: Bool = true
    @State private var desserts: [Dessert] = []
    @State private var errorMsg: String?
    @State private var splashScreenAnimationDone: Bool = false
    @State private var contentOpacity: Double = 0.0
    @State private var dessertImages: [String: UIImage] = [:]

    var body: some View {
        ZStack {
            NavigationSplitView {
                List {
                    if let errorMsg = errorMsg {
                        Text("Error: \(errorMsg)")
                    } else {
                        ForEach(desserts, id: \.mealId) { dessert in
                            NavigationLink(destination: DessertDetailView(dessert: dessert)) {
                                HStack{
                                    if let image = dessertImages[dessert.thumbnail] {
                                        DessertThumbnailView(image: image)
                                    }
                                    Text(dessert.mealName)
                                }
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
                await preInitDessertImages()
            }
            .opacity(contentOpacity)
            
            if isLoading || !splashScreenAnimationDone {
                LoadingScreen()
            }
            
        }
    }
    
    func preInitDessertImages() async {
        for dessert in desserts {
            guard let url = URL(string: dessert.thumbnail) else { continue }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    dessertImages[dessert.thumbnail] = image
                }
            } catch {
                errorMsg = "Failed to load image from: \(dessert.thumbnail)"
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

struct DessertThumbnailView: View {
    let image: UIImage
    
    var body: some View {
        Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
