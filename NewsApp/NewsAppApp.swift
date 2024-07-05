import SwiftUI
import FirebaseCore
import GoogleMaps

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
        return true
    }
}

@main
struct NewsApp: App {
    @StateObject private var navigation = NavigationManager()
    @StateObject private var authViewModel = AuthViewModel()

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environmentObject(navigation)
            .environmentObject(authViewModel)
        }
    }
}

