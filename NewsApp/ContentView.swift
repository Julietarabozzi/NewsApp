import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            switch navigation.state {
            case .login:
                AnyView(LoginView())
            case .signUp:
                AnyView(SignUpView())
            case .main:
                AnyView(MainView())
            case .detail(let news):
                AnyView(NewsDetailView(news: news))
            case .userList:
                AnyView(UserListView())
            case .userMap:
                if let user = navigation.selectedUser {
                    AnyView(
                        UserMapView(latitude: 0.0, longitude: 0.0, userName: "")
                            .navigationBarItems(leading: Button("Back") {
                                navigation.state = .userList
                            })
                    )
                } else {
                    AnyView(
                        Text("No user selected")
                            .navigationBarItems(leading: Button("Back") {
                                navigation.state = .userList
                            })
                    )
                }
            }
        }
        .onAppear {
            if authViewModel.user == nil {
                navigation.state = .login
            } else {
                navigation.state = .main
            }
        }
        .environmentObject(locationManager)
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationManager())
        .environmentObject(AuthViewModel())
}

