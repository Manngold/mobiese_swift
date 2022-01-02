import Foundation

class MovieList: ObservableObject{
    @Published var nowPlaying: [Movie] = []
    @Published var topRated: [Movie] = []
    @Published var upComing: [Movie] = []
    
    let baseUrl = "https://api.themoviedb.org/3"
    let apiKey = "c8d7c73d573d01c32347691c8f0c99bc"
    
    func fetchMainList(){
        fetchNowPlaying()
        fetchTopRated()
        fetchUpComing()
    }
    
    func fetchNowPlaying(){
        let path = "/movie/now_playing"
        let query = "?api_key=\(apiKey)"
        let resource = baseUrl + path + query
        func completionHandler(data: Data?, response:URLResponse?, error: Error?) -> Void {
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let response = try JSONDecoder().decode(MovieListResponse.self, from: data)
                DispatchQueue.main.async {
                    self.nowPlaying = response.results
                    return
                }
            }
            catch {
                print(error)
                return
            }
        }
        
        ApiManager.fetch(resource: resource, completionHandler: completionHandler)
    }
    
    func fetchTopRated(){
        let path = "/movie/top_rated"
        let query = "?api_key=\(apiKey)"
        let resource = baseUrl + path + query
        
        func completionHandler(data: Data?, response:URLResponse?, error: Error?) -> Void {
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieListResponse.self, from: data)
                DispatchQueue.main.async {
                    self.topRated = response.results
                    return
                }
            }
            catch {
                return
            }
        }
        
        ApiManager.fetch(resource: resource, completionHandler: completionHandler)
    }
    
    func fetchUpComing(){
        let path = "/movie/upcoming"
        let query = "?api_key=\(apiKey)"
        let resource = baseUrl + path + query
        
        func completionHandler(data: Data?, response:URLResponse?, error: Error?) -> Void {
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieListResponse.self, from: data)
                DispatchQueue.main.async {
                    self.upComing = response.results
                    return
                }
            }
            catch {
                return
            }
        }
        
        ApiManager.fetch(resource: resource, completionHandler: completionHandler)
    }
}
