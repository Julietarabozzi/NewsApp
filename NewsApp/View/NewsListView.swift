import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsViewModel()
    @EnvironmentObject var navigation: NavigationManager

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                List(viewModel.filteredNews) { news in
                    VStack(alignment: .leading) {
                        Text(news.title)
                            .font(.headline)
                        Text(news.body)
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                    .onTapGesture {
                        navigation.state = .detail(news: news)
                    }
                }
                .onAppear {
                    viewModel.fetchNews()
                }
                .alert(item: $viewModel.errorMessage) { errorMessage in
                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding(.top, 70) // Ajuste de padding superior
        }
    }
}

#Preview {
    NewsListView()
        .environmentObject(NavigationManager())
}

