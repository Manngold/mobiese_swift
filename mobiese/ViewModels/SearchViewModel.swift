//
//  SearchViewModel.swift
//  mobiese
//
//  Created by Shaashop on 2022/01/24.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchResult: [Movie] = []
    @Published var searchText: String = ""
    
    private let movieListNetwork: MovieListNetwork
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        self.movieListNetwork = MovieListNetwork()
        $searchText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink(receiveValue: { value in
                self.search(keyword: value)
            }).store(in: &cancellable)
    }
    
    var baseUrl: String {
        if let unParsedBaseUrl = Bundle.main.infoDictionary?["BASE_URL"] as? String {
            return unParsedBaseUrl.replacingOccurrences(of: "#()", with: "//")
        } else {
            return ""
        }
    }
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    
    func search(keyword: String){
        let path = "/search/movie"
        let query = "?api_key=\(apiKey)&query=\(keyword)"
        let resource = baseUrl + path + query
        movieListNetwork.fetchSearchResult(resource: resource)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                guard case .failure = $0 else { return }
                self.searchResult = []
            }, receiveValue: {response in
                self.searchResult += response.results
            }).store(in: &cancellable)
    }
    
}
