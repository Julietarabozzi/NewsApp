import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var newsList: [News] = []
    @Published var errorMessage: String?
    @Published var searchText: String = "" {
        didSet {
            filterNews()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let newsService: NewsServiceProtocol
    
    init(newsService: NewsServiceProtocol = NewsService()) {
        self.newsService = newsService
        fetchNews()
    }
    
    func fetchNews() {
        newsService.fetchNews { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newsList):
                    self?.newsList = newsList
                    self?.filterNews()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func filterNews() {
        if searchText.isEmpty {
            filteredNews = newsList
        } else {
            filteredNews = newsList.filter { $0.title.lowercased().contains(searchText.lowercased()) || $0.body.lowercased().contains(searchText.lowercased()) }
        }
    }

    @Published var filteredNews: [News] = []
}

