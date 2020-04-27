enum APIEndpoint {
    case events
    case eventDetail(_ id: String)
    case checkIn
}

extension APIEndpoint {
    
    var baseUrl: String { "https://5b840ba5db24a100142dcd8c.mockapi.io/api/" }
    
    var url: String {
        switch self {
        case .events:  return "\(baseUrl)events"
        case .eventDetail(let id): return "\(baseUrl)events/\(id)"
        case .checkIn: return "\(baseUrl)checkin"
        }
    }
    
    var method: HttpMethod {
        switch  self {
        case .events, .eventDetail(_): return .GET
        case .checkIn: return .POST
        }
    }
}
