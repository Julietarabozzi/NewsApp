import Foundation

protocol NewsServiceProtocol {
    func fetchNews(completion: @escaping (Result<[News], Error>) -> Void)
}

class NewsService: NewsServiceProtocol {
    func fetchNews(completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let newsList = try JSONDecoder().decode([News].self, from: data)
                completion(.success(newsList))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
