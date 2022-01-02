import SwiftUI

struct MainView: View {
    @StateObject var movieList = MovieList()
    var body: some View {
        TabView{
            MovieListView(movieList: movieList.nowPlaying, pageTitle: "Now Playing").tabItem{
                Image(systemName: "play.tv")
                Text("Now Playing")
            }
            MovieListView(movieList: movieList.upComing, pageTitle: "Upcoming").tabItem{
                Image(systemName: "film")
                Text("Upcoming")
            }
            MovieListView(movieList: movieList.topRated, pageTitle: "Top Rated").tabItem{
                Image(systemName: "heart.fill")
                Text("Top Rated")
            }
        }.onAppear{
            movieList.fetchMainList()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
.previewInterfaceOrientation(.portrait)
    }
}
