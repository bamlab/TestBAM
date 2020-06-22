import Foundation

struct RepoModel: Codable {
  let name: String
  let url: String
}

extension RepoModel: Equatable {
  static func ==(_ lhs: RepoModel, _ rhs: RepoModel) -> Bool {
    return lhs.name == rhs.name && lhs.url == rhs.url
  }
}
