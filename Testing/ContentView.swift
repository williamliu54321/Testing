import SwiftUI
import CoreData

struct ContentView: View {
    // This flag determines if we show the onboarding. It's saved in UserDefaults.
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    
    // This fetches all 'SurveyResponse' objects from Core Data and keeps the list updated.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SurveyResponse.submissionDate, ascending: false)],
        animation: .default)
    private var responses: FetchedResults<SurveyResponse>

    var body: some View {
        NavigationView {
            // Display the fetched responses in a list
            List {
                ForEach(responses) { response in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(response.name ?? "No Name").font(.headline)
                        Text("Favorite Cuisine: \(response.favoriteCuisine ?? "N/A")")
                        Text("Notifications: \(response.enableNotifications ? "On" : "Off")")
                    }
                }
            }
            .navigationTitle("Survey Results")
        }
        .fullScreenCover(isPresented: $shouldShowOnboarding) {
            // When 'shouldShowOnboarding' is true, this view covers the screen.
            OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
        }
    }
}
