//
//  MainList.swift
//  mobiese
//
//  Created by Shaashop on 2022/01/02.
//

import SwiftUI

struct MovieListView: View {
    var movieList: [Movie] = []
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
                ForEach(movieList, id:\.self){movie in
                    HStack{
                        CardView(title: movie.title, posterPath: "\(imageBaseUrl)\(movie.posterPath ?? "")", releaseDate: movie.releaseDate, voteAverage: movie.voteAverage, voteCount: movie.voteCount)
                    }.padding(3)
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
