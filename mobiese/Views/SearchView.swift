//
//  SearchView.swift
//  mobiese
//
//  Created by Shaashop on 2022/01/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    init(){
        self.viewModel = SearchViewModel()
    }
    
    var imageBaseUrl: String {
        if let unParsedBaseUrl = Bundle.main.infoDictionary?["IMAGE_BASE_URL"] as? String {
            return unParsedBaseUrl.replacingOccurrences(of: "#()", with: "//")
        } else {
            return ""
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(text: $viewModel.searchText)
                Spacer()
                List{
                    ForEach(viewModel.searchResult, id:\.self){movie in
                        HStack{
                            CardView(title: movie.title, posterPath: "\(imageBaseUrl)\(movie.posterPath ?? "")", releaseDate: movie.releaseDate, voteAverage: movie.voteAverage, voteCount: movie.voteCount)
                        }
                        .padding(3)
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
