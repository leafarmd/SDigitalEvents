import Foundation
import UIKit
@testable import SDigitalEvents

class APIStub: APIProtocols {
    let status: CompletionStatus<Decodable>
    var url: String?
    var method: HttpMethod?
    
    init(status: CompletionStatus<Decodable>) {
        self.status = status
    }
    
    func requestObject<T>(from endpoint: APIEndpoint, data: Data?, type: T.Type, completion: @escaping CompletionCallback<T>) where T : Decodable {
        url = endpoint.url
        method = endpoint.method
        
        switch status {
        case .success(let result):
            completion(.success(result as! T))
        case .failure(let failure):
            completion(.failure(failure))
        }
    }
}

