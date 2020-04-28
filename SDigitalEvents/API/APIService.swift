import Foundation
import UIKit

final class APIService: APICore {
    
    static func requestObject<T>(from endpoint: APIEndpoint,
                                 data: Data? = nil,
                                 type: T.Type,
                                 completion: @escaping CompletionCallback<T>) where T : Decodable {
        
        request(from: endpoint.url,
                type: type,
                method: endpoint.method,
                data: data,
                completion: completion)
        
    }
    
    private static func request<T: Decodable>(from endpoint: String,
                                              type: T.Type,
                                              method: HttpMethod,
                                              data: Data?,
                                              completion: @escaping CompletionCallback<T>) {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let baseURL = URLComponents(string: endpoint)
        
        guard let url = baseURL?.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        var request : URLRequest = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let data = data {
            request.httpBody = data
        }
        
        
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    completion(.failure(.requestFailed))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let dataType = try decoder.decode(type.self, from: data)
                    completion(.success(dataType))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            }
        }.resume()
    }
    
    static func loadImage(from url: String, completion: @escaping RequestImageResult) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidData))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            guard let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(.invalidData))
            }
        }
    }
}
