struct EventsOutput: Decodable {
   
    let id: String
    let title: String
    let price: Double
    let latitude: Double
    let longitude: Double
    let image: String
    let description: String
    let date: Int
    let cupons: [CuponOutput]?
    let people: [PeopleOutput]?
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
