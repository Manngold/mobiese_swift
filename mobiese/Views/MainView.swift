import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            MovieListView(pageTitle: "Now Playing").tabItem{
                Image(systemName: "play.tv")
                Text("Now Playing")
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.portrait)
    }
}
