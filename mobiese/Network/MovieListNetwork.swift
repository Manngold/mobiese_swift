import Foundation
import Combine

class MovieListNetwork {
    
    func fetchMovieList(resource: String?) -> AnyPublisher<MovieListResponse, MovieListError> {
        guard let validateUrl = resource else {
            let error = MovieListError.error("URL이 존재하지 않습니다.")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        guard let targetUrl = URL(string: validateUrl) else {
            let error = MovieListError.error("유효하지 않은 URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: targetUrl)
            .mapError { _ in
                MovieListError.error("TMDB API Error")
            }
            .flatMap { data in
                return Just(data.data)
                    .decode(type: MovieListResponse.self, decoder: JSONDecoder())
                    .mapError { _ in
                        .error("JSON Parsing Error")
                    }
            }
            .eraseToAnyPublisher()
      }
    
    func fetchSearchResult(resource: String?) -> AnyPublisher<MovieListResponse, MovieListError> {
        guard let validateUrl = resource else {
            let error = MovieListError.error("URL이 존재하지 않습니다.")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        guard let targetUrl = URL(string: validateUrl) else {
            let error = MovieListError.error("유효하지 않은 URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: targetUrl)
            .mapError { _ in
                MovieListError.error("TMDB API Error")
            }
            .flatMap { data in
                return Just(data.data)
                    .decode(type: MovieListResponse.self, decoder: JSONDecoder())
                    .mapError { _ in
                        .error("JSON Parsing Error")
                    }
            }
            .eraseToAnyPublisher()
      }
    
}
