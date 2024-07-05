import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""

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
                viewModel.signUp(email: email, password: password)
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: {
                navigation.state = .login
            }) {
                Text("Back to Login")
            }
            .padding()
        }
        .padding()
        .navigationTitle("Sign Up")
        .onReceive(viewModel.$user) { newUser in
            if newUser != nil {
                navigation.state = .main
            }
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(NavigationManager())
        .environmentObject(AuthViewModel())
}

