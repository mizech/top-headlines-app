import SwiftUI

@main
struct TopHeadlinesApp: App {
    let mainVM = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(mainVM)
        }
    }
}
