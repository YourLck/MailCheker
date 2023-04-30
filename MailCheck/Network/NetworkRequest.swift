
import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    private init() {}
    
    func requestData(verificationMail: String, completion: @escaping(Result<Data, Error>) -> Void) {
        
        let urlString = "https://api.kickbox.com/v2/verify?email=\(verificationMail)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, responce, erorr in
            DispatchQueue.main.async {
                if let erorr = erorr {
                    completion(.failure(erorr))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
}
