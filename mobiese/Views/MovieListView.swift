//
//  MainList.swift
//  mobiese
//
//  Created by Shaashop on 2022/01/02.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel = MovieListViewModel()
    
    var pageTitle: String
    
    
    var imageBaseUrl: String {
        if let unParsedBaseUrl = Bundle.main.infoDictionary?["IMAGE_BASE_URL"] as? String {
            return unParsedBaseUrl.replacingOccurrences(of: "#()", with: "//")
        } else {
            return ""
        }
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.nowPlaying, id:\.self){movie in
                    HStack{
                        CardView(title: movie.title, posterPath: "\(imageBaseUrl)\(movie.posterPath ?? "")", releaseDate: movie.releaseDate, voteAverage: movie.voteAverage, voteCount: movie.voteCount)
                    }.onAppear{
                        viewModel.loadMoreContentIfNeeded(currentItem: movie)
                    }
                    .padding(3)
                }
            }
            .navigationTitle(pageTitle)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(pageTitle: "pageTitle")
    }
}
