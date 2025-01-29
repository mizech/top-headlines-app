import SwiftUI

struct ContentView: View {
    let mainVM = MainViewModel()
    @State private var isTweakSheetShown = false
    @State private var pageSize = 20
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(mainVM.articles) { article in
                    VStack(alignment: .leading) {
                        Text(article.title ?? "").lineLimit(3)
                    }
                }
            }.listStyle(.plain)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isTweakSheetShown.toggle()
                        } label: {
                            Label("Tweak articles shown", systemImage: "gear")
                        }
                    }
                })
                .navigationTitle("Top-Headlines")
        }
        .sheet(isPresented: $isTweakSheetShown, content: {
            VStack {
                Section("Count of headline to display") {
                    Picker("How many headlines?", selection: $pageSize) {
                        Text("10").tag(10)
                        Text("20").tag(20)
                        Text("40").tag(40)
                        Text("80").tag(80)
                    }.pickerStyle(.segmented)
                }
                Spacer()
            }
            .padding()
            .padding(.top, 15)
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        })
        .onChange(of: pageSize, {
            mainVM.pageSize = pageSize
            Task {
                await mainVM.loadHeadlines()
            }
        })
        .padding()
        .task() {
            print(await mainVM.loadHeadlines())
        }
    }
}

#Preview {
    ContentView()
}
