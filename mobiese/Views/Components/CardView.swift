import SwiftUI

struct CardView: View {
    var title: String
    var posterPath: String?
    var releaseDate: String
    var voteAverage: Double
    var voteCount: Int
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: posterPath!)){ phase in
                if let image = phase.image {
                    image.resizable().aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Color.gray // Indicates an error.
                } else {
                    Color.gray // Acts as a placeholder.
                }
            }
            
            VStack(alignment: .leading){
                Text(title)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                HStack{
                    Text(releaseDate).font(.subheadline).foregroundColor(.secondary)
                    Text("🍿\(voteAverage)").font(.subheadline)
                    Image(systemName: "person.fill")
                    Text("\(voteCount)").font(.subheadline)
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "title", posterPath: "", releaseDate: "releaseDate", voteAverage: 0, voteCount: 0)
    }
}
