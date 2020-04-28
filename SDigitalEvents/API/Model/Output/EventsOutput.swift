struct EventsOutput: Decodable {
   
    let id: String
    let title: String
    let price: Double
    let latitude: LocationOutput?
    let longitude: LocationOutput?
    let image: String
    let description: String
    let date: Int
    let cupons: [CuponOutput]?
    let people: [PeopleOutput]?
}

enum  LocationOutput: Decodable {
   
    case double(Double)
    case string(String)
    
    var value: Double? {
        switch self {
        case .double(let value):
            return value
        case .string(let value):
            if let value = Double(value) {
                return value
            }
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(Double.self) {
            self = .double(value)
            return
        }
        if let value = try? container.decode(String.self) {
            self = .string(value)
            return
        }
        throw DecodingError.typeMismatch(LocationOutput.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LocationOutput"))
    }
}

struct CuponOutput: Decodable {
    
    let id: String?
    let eventID: String?
    let discount: Int?
}

struct PeopleOutput: Decodable {
    
    let id: String?
    let eventID: String?
    let name: String?
    let picture: String?
}
