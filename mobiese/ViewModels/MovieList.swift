import Foundation

class MovieList: ObservableObject{
    @Published var nowPlaying: [Movie] = []
    @Published var topRated: [Movie] = []
    @Published var upComing: [Movie] = []
    
    var baseUrl: String {
        if let unParsedBaseUrl = Bundle.main.infoDictionary?["BASE_URL"] as? String {
            return unParsedBaseUrl.replacingOccurrences(of: "#()", with: "//")
        } else {
            return ""
        }
    }
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    
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
