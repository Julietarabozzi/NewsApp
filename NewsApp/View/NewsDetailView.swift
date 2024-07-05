import SwiftUI

struct NewsDetailView: View {
    let news: News
    @EnvironmentObject var navigation: NavigationManager

    var body: some View {
        VStack(alignment: .leading) {
            Text(news.title)
                .font(.largeTitle)
                .padding(.bottom)
            Text(news.body)
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text(news.title), displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            navigation.state = .main
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.blue)
                .imageScale(.large)
        })
    }
}

