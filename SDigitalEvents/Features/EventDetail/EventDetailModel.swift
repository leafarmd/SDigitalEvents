import Foundation

struct EventDetailModel {
    let id: String
    let title: String
    let description: String
    let date: Date
    let price: Double
    let image: String
    let geoLocation: (latitude: Double, longitude: Double)
    let cupons: [Int?]?
    let people: [PeopleModel]?
    
    init(output: EventsOutput) {
        self.id = output.id
        self.title = output.title
        self.description = output.description
        self.date = Date(timeIntervalSince1970: TimeInterval(output.date / 1000))
        self.price = output.price
        self.image = output.image
        self.geoLocation = (output.latitude, output.longitude)
        self.cupons = output.cupons?.map { $0.discount }
        self.people = output.people?.map{ PeopleModel(output: $0) }
        
    }
}

struct PeopleModel {
    let id: String?
    let name: String?
    let picture: String?
    
    init(output: PeopleOutput) {
        self.id = output.id
        self.name = output.name
        self.picture = output.picture
    }
}
