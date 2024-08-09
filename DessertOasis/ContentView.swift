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
                            .foregroundColor(.red)
                            .font(.headline)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                    } else {
                        ForEach(desserts, id: \.mealId) { dessert in
                            NavigationLink(destination: DessertDetailView(dessert: dessert)) {
                                HStack {
                                    if let image = dessertImages[dessert.thumbnail] {
                                        DessertThumbnailView(image: image)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(dessert.mealName)
                                            .font(Font.headline.bold())
                                            .foregroundColor(.white)
                                        Text("Tap to see more")
                                            .font(.subheadline)
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.3)]),
                                                           startPoint: .topLeading,
                                                           endPoint: .bottomLeading))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .animation(.spring(), value: dessertImages)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                    }
                }
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
                .background(Color.clear)
            } detail: {
                Text("Select an item")
                    .foregroundColor(.white)
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
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}
