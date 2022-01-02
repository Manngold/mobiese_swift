import Foundation

struct Movie: Hashable, Codable{
    let id: Int
    var adult: Bool
    var backdropPath: String?
    var genres: [Int]
    var homepage: String?
    var originalLanguage: String
    var originalTitle: String
    var overview: String?
    var popularity: Double
    var posterPath: String?
    var releaseDate: String
    var runTime: Int?
    var title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backdropPath = "backdrop_path"
        case genres = "genre_ids"
        case homepage
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runTime
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

