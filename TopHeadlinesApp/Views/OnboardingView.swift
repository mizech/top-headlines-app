import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingDone: Bool
    @State var currTab = 1
    
    var body: some View {
        Text("Top-Headlines App")
            .font(.largeTitle)
        Text("How to use!")
            .font(.title)
        TabView(selection: $currTab) {
            VStack(alignment: .leading, spacing: 22) {
                Text("Use the gear-button on the top to open "
                        + "the settings-screen.")
                Text("Use the controls to tweak the data, "
                        + "which become displayed.")
                Button {
                    currTab = 2
                } label: {
                    Text("Next")
                        .padding()
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Spacer()
            }.tag(1)
            VStack(spacing: 22) {
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
                Button {
                    currTab = 1
                } label: {
                    Text("Previous")
                        .padding()
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Spacer()
            }.tag(2)
        }
        .padding()
        .tabViewStyle(.page)
    }
}

#Preview {
    OnboardingView(isOnboardingDone: .constant(false))
}
