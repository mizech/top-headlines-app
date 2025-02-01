import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboardingDone") var isOnboardingDone = false
    
    var body: some View {
        if isOnboardingDone == true {
            MainView()
        } else {
            OnboardingView(isOnboardingDone: $isOnboardingDone)
        }
    }
}

#Preview {
    ContentView()
}
