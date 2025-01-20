import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private func request(prompt: String, _ endPoint: EndPoint, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: endPoint.request(prompt: prompt)) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error!))
                print("Hata: \(error?.localizedDescription ?? "Bilinmeyen hata")")
                return
            }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } else {
                print("Resim işlenemedi")
            }
        }
        task.resume()
    }
    
    func createLogo(prompt: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let endPoint = EndPoint.getModelInfo
        request(prompt: prompt, endPoint, completion: completion)
    }
    
}
