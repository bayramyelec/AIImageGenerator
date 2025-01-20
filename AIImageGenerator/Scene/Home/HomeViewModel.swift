import UIKit

class HomeViewModel {
    
    func createLogo(prompt: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        NetworkManager.shared.createLogo(prompt: prompt, completion: completion)
    }
    
}
