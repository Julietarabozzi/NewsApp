import Foundation

struct News: Identifiable, Codable {
    let id: Int
    let title: String
    let body: String
}
