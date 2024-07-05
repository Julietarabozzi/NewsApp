
import SwiftUI

struct UserListView: View {
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.users) { user in
                Button(action: {
                    navigation.selectedUser = user
                    navigation.state = .userMap
                }) {
                    Text(user.email)
                }
            }
            .navigationBarTitle("User List", displayMode: .inline)
            .navigationBarItems(leading: Button("Back") {
                navigation.state = .main
            })
        }
    }
}

#Preview {
    UserListView()
        .environmentObject(NavigationManager())
        .environmentObject(AuthViewModel())
}
