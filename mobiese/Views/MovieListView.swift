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
    
    var body: some View {
        NavigationView{
            List{
                ForEach(movieList, id:\.self){movie in
                    HStack{
                        Text(movie.title)
                        Text(movie.overview ?? "")
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
