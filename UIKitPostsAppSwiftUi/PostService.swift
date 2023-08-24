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
    func fetchPosts() -> AnyPublisher<[Post], Error> {
      
            guard  let url = URL(string: Constants.baseURL) else {
                            return Fail(error: APIError.invalidUrl)
                                .eraseToAnyPublisher()
                        } // guard end
   

        return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: [Post].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
             
                 }
             
    }
 
