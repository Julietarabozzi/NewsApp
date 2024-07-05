import SwiftUI

struct CustomTopBar: View {
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        isMenuOpen.toggle()
                    }
                }) {
                    Image(systemName: "person.circle")
                        .font(.title)
                }
                Spacer()
                Text("News List")
                    .font(.headline)
                Spacer()
                Image(systemName: "person.circle")
                    .font(.title)
                    .opacity(0)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            
            if isMenuOpen {
                SideMenu(width: UIScreen.main.bounds.width * 0.75, isOpen: isMenuOpen, menuClose: {
                    withAnimation {
                        self.isMenuOpen = false
                    }
                })
                    .transition(.move(edge: .leading))
            }
            
            Spacer()
        }
    }
}

#Preview {
    CustomTopBar(isMenuOpen: .constant(false))
        .environmentObject(NavigationManager())
}

