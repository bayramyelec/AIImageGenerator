import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API Key not found")
        }
        return key
    }
}
