import SwiftUI

struct MainView: View {
    @State private var isMenuOpen = false
    
    var body: some View {
        ZStack {
            NewsListView()
                .environmentObject(AuthViewModel())
                .disabled(isMenuOpen) // Deshabilitar interacciones cuando el menú está abierto
            
            CustomTopBar(isMenuOpen: $isMenuOpen)
            
            SideMenu(width: UIScreen.main.bounds.width * 0.75, isOpen: isMenuOpen, menuClose: {
                withAnimation {
                    self.isMenuOpen = false
                }
            })
            .transition(.move(edge: .leading))
        }
    }
}

#Preview {
    MainView()
        .environmentObject(NavigationManager())
}

