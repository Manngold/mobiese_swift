import Foundation
import Combine

class MovieListViewModel: ObservableObject{
    @Published var nowPlaying: [Movie] = []
    @Published var isLoading = false
    private var page = 1
    private var canLoadMorePages = true
    
    let movieListNetwork: MovieListNetwork
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        self.movieListNetwork = MovieListNetwork()
        fetchNowPlaying()
    }
    
    var baseUrl: String {
        if let unParsedBaseUrl = Bundle.main.infoDictionary?["BASE_URL"] as? String {
            return unParsedBaseUrl.replacingOccurrences(of: "#()", with: "//")
        } else {
            return ""
        }
    }
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    
    func loadMoreContentIfNeeded(currentItem item: Movie?) {
        guard let item = item else {
            fetchNowPlaying()
          return
        }

        let thresholdIndex = nowPlaying.index(nowPlaying.endIndex, offsetBy: -5)
        if nowPlaying.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            fetchNowPlaying()
        }
      }
    
    func fetchNowPlaying(){
        let path = "/movie/now_playing"
        let query = "?api_key=\(apiKey)&page=\(page)"
        let resource = baseUrl + path + query
        
        guard !isLoading && canLoadMorePages else {
            return
        }

        isLoading = true
        
        movieListNetwork.fetchMovieList(resource: resource)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { response in
                let totalPages = response.totalPages
                if self.page < totalPages {
                    self.canLoadMorePages = true
                    self.page += 1
                } else {
                    self.canLoadMorePages = false
                }
                self.isLoading = false
            }).sink(
                receiveCompletion: {
                    guard case .failure(_) = $0 else { return }
                    self.nowPlaying = []
                },
                receiveValue:  { response in
                    self.nowPlaying += response.results
                }
            )
            .store(in: &cancellables)
            
        
    }

}
