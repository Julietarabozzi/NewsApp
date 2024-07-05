import XCTest
@testable import NewsApp

class NewsViewModelTests: XCTestCase {

    var viewModel: NewsViewModel!
    var mockNewsService: MockNewsService!

    override func setUp() {
        super.setUp()
        mockNewsService = MockNewsService()
        viewModel = NewsViewModel(newsService: mockNewsService)
    }

    override func tearDown() {
        viewModel = nil
        mockNewsService = nil
        super.tearDown()
    }

    func testFetchNewsSuccess() {
        // Given
        let mockNews = [
            News(id: 1, title: "Test Title 1", body: "Test Body 1"),
            News(id: 2, title: "Test Title 2", body: "Test Body 2")
        ]
        mockNewsService.mockResult = .success(mockNews)
        
        // When
        viewModel.fetchNews()
        
        // Then
        XCTAssertEqual(viewModel.newsList.count, 2)
        XCTAssertEqual(viewModel.newsList.first?.title, "Test Title 1")
    }

    func testFetchNewsFailure() {
        // Given
        mockNewsService.mockResult = .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error"]))
        
        // When
        viewModel.fetchNews()
        
        // Then
        XCTAssertEqual(viewModel.newsList.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Error")
    }

    func testFilterNews() {
        // Given
        let mockNews = [
            News(id: 1, title: "Apple", body: "Tech company"),
            News(id: 2, title: "Banana", body: "Fruit")
        ]
        viewModel.newsList = mockNews
        
        // When
        viewModel.searchText = "apple"
        
        // Then
        XCTAssertEqual(viewModel.filteredNews.count, 1)
        XCTAssertEqual(viewModel.filteredNews.first?.title, "Apple")
    }
}

class MockNewsService: NewsServiceProtocol {
    var mockResult: Result<[News], Error>!
    
    func fetchNews(completion: @escaping (Result<[News], Error>) -> Void) {
        completion(mockResult)
    }
}

