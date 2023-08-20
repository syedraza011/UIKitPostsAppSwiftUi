//
//  PostsViewModel.swift
//  UIKitPostsAppSwiftUi
//
//  Created by Syed Raza on 8/20/23.
//

import Foundation
import Combine
final class PostsViewModel: ObservableObject {
    @Published var posts: [Post][]
   let service = PostsService()
    
    func getPosts(){
        service.fetchPosts()
            .sink(recieveCompletion :{ completion in
                switch completion {
                case .fininshed: break
                case .failure(let error): print(err.LocalizedError)
                }
            }, receiveValue: { [weak self]
                }
            } )

   
}
