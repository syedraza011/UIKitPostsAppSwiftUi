//
//  PostsViewModel.swift
//  UIKitPostsAppSwiftUi
//
//  Created by Syed Raza on 8/20/23.
//

import Foundation
import Combine


class PostsViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    
    @Published var allPosts: [Post] = []
    @Published var state: AsyncState = .initial
    
    let service = PostsService()
    
    func getPosts() {
        state = .loading

        cancellable = service.fetchPosts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Fetch Failed: \(error.localizedDescription)")
//                        self?.state = .error("FOund Error \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.allPosts = response
                self?.state = .loaded
            })
    }
}

//final class PostsViewModel: ObservableObject {
//    var cancellable: Set<AnyCancellable> = []
//    @Published var allPosts: [Post]=[]
//    @Published var state: AsyncState = .initial
//   let service = PostsService()
//
//    func getPosts(){
//        service.fetchPosts()
//
//
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let err):
//                    print("Fetch Failed: \(err.localizedDescription)")
//
//                }
//            }, receiveValue: { [weak self] response in
//                state = .loading(response)
//                self?.allPosts = response
//            })
//            .store(in: &cancellable)
//    }
//}
