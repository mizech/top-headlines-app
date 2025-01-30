import SwiftUI

struct ContentView: View {
    let mainVM = MainViewModel()
    @State private var isTweakSheetShown = false
    @State private var pageSize = 20
    @State private var category = Category.gen
    
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
                Section("Set count of headlines to display") {
                    Picker("How many headlines?", selection: $pageSize) {
                        Text("5").tag(5)
                        Text("10").tag(10)
                        Text("20").tag(20)
                        Text("40").tag(40)
                        Text("80").tag(80)
                    }.pickerStyle(.segmented)
                }
                Section("Set category") {
                    Picker("Category", selection: $category) {
                        ForEach(Category.allCases, id: \.self) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }
                }.padding(.top, 15)
                Spacer()
            }
            .padding()
            .padding(.top, 20)
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        })
        .onChange(of: pageSize, {
            mainVM.pageSize = pageSize
            Task {
                await mainVM.loadHeadlines()
            }
        })
        .onChange(of: category, {
            mainVM.category = category.rawValue
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
