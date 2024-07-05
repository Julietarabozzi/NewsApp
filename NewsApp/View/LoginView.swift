import SwiftUI

struct LoginView: View {
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            Button(action: {
                viewModel.login(email: email, password: password)
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            if showAlert, let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: {
                navigation.state = .signUp
            }) {
                Text("Sign Up")
            }
            .padding()
        }
        .padding()
        .navigationTitle("Login")
        .onReceive(viewModel.$user) { newUser in
            if newUser != nil {
                navigation.state = .main
            } else if viewModel.errorMessage != nil {
                showAlert = true
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(NavigationManager())
        .environmentObject(AuthViewModel())
}

