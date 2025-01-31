import SwiftUI

struct ArticleDetailsView: View {
    var article: Article
    @State var publDate = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                Text(article.title ?? "")
                    .font(.title2)
                Text(article.description ?? "")
                Text("Written by: \(article.author ?? "")")
                    .font(.subheadline)
                Text("Published at: \(publDate.formatted(date: .abbreviated, time: .shortened))")
                    .font(.subheadline)
                Text(article.content ?? "")
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image.resizable()
                         .scaledToFit()
                         .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .padding()
        .navigationTitle("Headline-details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            if let publDate = try? Date(
                article.publishedAt ?? "",
                strategy: .iso8601
            ) {
                self.publDate = publDate
            }
        }
    }
}

#Preview {
    ArticleDetailsView(article: Article())
}
