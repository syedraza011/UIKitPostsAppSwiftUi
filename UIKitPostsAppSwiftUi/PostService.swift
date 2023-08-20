//
//  PostService.swift
//  UIKitPostsAppSwiftUi
//
//  Created by Syed Raza on 8/20/23.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case emptyData
    case serviceUnavailable
    case decodingError
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "invalid url"
        case .invalidResponse:
            return "invalid response"
        case .emptyData:
            return "empty data"
        case .serviceUnavailable:
            return "service unavailable"
        case .decodingError:
            return "decoding error"
        }
    }
}
class PostsService {
    
    struct Constants {
        static let baseURL = "https://jsonplaceholder.typicode.com/posts"
    }
    
    var cancellables = Set<AnyCancellable>()
    func fetchPosts() -> Future<[Post], Error> {
        return Future {[weak self] promise in
            guard let self = self, let url = URL(string: Constants.baseURL) else {
                promise(.failure(APIError.invalidUrl))
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: [Post].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .failure(let err):
                        promise(.failure(err))
                    case .finished:
                        break
                    }
                } receiveValue: { posts in
                    promise(.success(posts))
                }
                .store(in: &self.cancellables)
        }
    }
}
