//
//  ContentView.swift
//  PostsDemo
//
//  Created by Syed Raza on 6/22/23.
//


import SwiftUI
struct ContentView: View {
    @ObservedObject var viewModel = PostsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.allPosts, id: \.self) { post in
                    Text("\(post.title)")
                }
                .listStyle(InsetGroupedListStyle()) // Added listStyle for better visual separation
            }
            .navigationBarTitle("Posts")
            .onAppear {
                viewModel.getPosts() // Change the function name to getPosts
            }
        }
    }
}

                  


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


