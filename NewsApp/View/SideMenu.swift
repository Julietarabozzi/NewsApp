import SwiftUI

struct SideMenu: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var navigation: NavigationManager

    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void

    var body: some View {
        ZStack {
            // Background dimming and tap to close
            if self.isOpen {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.menuClose()
                    }
            }
            
            // Side menu content
            HStack {
                VStack(alignment: .leading) {
                    Button(action: {
                        navigation.state = .userList
                        menuClose()
                    }) {
                        Text("User List")
                            .padding(.top, 100)
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.signOut(navigation: navigation)
                        menuClose()
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 30)
                }
                .padding()
                .frame(width: width, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .offset(x: self.isOpen ? 0 : -width)
                .animation(.default)
                
                Spacer()
            }
        }
    }
}

