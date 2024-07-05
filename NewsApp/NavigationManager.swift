import SwiftUI

enum AppState {
    case login
    case signUp
    case main
    case detail(news: News)
    case userList
    case userMap
}

final class NavigationManager: ObservableObject {
    @Published var state: AppState = .login
    @Published var selectedUser: User? = nil
}

