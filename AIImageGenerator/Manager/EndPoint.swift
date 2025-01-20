import Foundation

protocol EndpointProtocol {
    var baseUrl: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    func fullUrl() -> String
    func request(prompt: String?) -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum EndPoint {
    case getModelInfo
}

extension EndPoint: EndpointProtocol {
    
    var baseUrl: String {
        return "https://api-inference.huggingface.co/models/"
    }
    
    var path: String {
        switch self {
        case .getModelInfo:
            return "strangerzonehf/Flux-Midjourney-Mix2-LoRA"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getModelInfo:
            return .post
        }
    }
    
    func fullUrl() -> String {
        return "\(baseUrl)\(path)"
    }
    
    func request(prompt: String?) -> URLRequest {
        guard let url = URL(string: fullUrl()) else { fatalError("Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("Bearer \(APIManager.shared.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let prompt = prompt {
            let body: [String: Any] = ["inputs": prompt]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return request
    }
    
    
}
