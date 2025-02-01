import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingDone: Bool
    
    var body: some View {
        Text("Top-Headlines App")
            .font(.largeTitle)
        Text("How to use!")
            .font(.title)
        TabView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Use the gear-button on the top to open "
                        + "the settings-screen.")
                Text("Use the controls to tweak the data, "
                        + "which become displayed.")
                Spacer()
            }
            VStack(spacing: 20) {
                Text("Navigation to the details-view of a news-article:"
                        + "Tab on a single headline, within the list.")
                Button {
                    isOnboardingDone.toggle()
                } label: {
                    Text("Okay, I got it. Let's go!")
                        .padding()
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Spacer()
            }
        }
        .padding()
        .tabViewStyle(.page)
    }
}

#Preview {
    OnboardingView(isOnboardingDone: .constant(false))
}
