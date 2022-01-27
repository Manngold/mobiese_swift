import SwiftUI
import Firebase


@main
struct mobieseApp: App {
    
    init(){
        setupFirebase()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

extension mobieseApp {
    private func setupFirebase(){
        FirebaseApp.configure()
    }
}
