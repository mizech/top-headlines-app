import Foundation

@Observable
class MainViewModel {
    var category = "technology"
    var pageSize = 20
    var articles = [Article]()
    var strURL: String {
        if let dict = Bundle.main.infoDictionary {
            if let api_key = dict["API_KEY"] as! String? {
                return "https://newsapi.org/v2/top-headlines?" +
                    "country=us&pageSize=\(pageSize)" +
                    "&category=\(category)&apiKey=\(api_key)"
            }
        }
        return ""
    }
    
    func loadHeadlines() async {
        guard let oURL = URL(string: strURL) else {
            self.articles = []
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: oURL)
            do {
                let jsonDecoder = JSONDecoder()
                let articlesCollection = try jsonDecoder.decode(ArticlesCollection.self, from: data)
                self.articles = articlesCollection.articles
            } catch {
                print(" -- Parsing data failed -- ")
                print(error)
                self.articles = []
            }
        } catch {
            print(" -- Fetching data failed -- ")
            print(error)
            self.articles = []
        }
    }
}
