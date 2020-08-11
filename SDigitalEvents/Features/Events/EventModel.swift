import Foundation

struct EventModel {
    let id: String
    let title: String
    let description: String
    let date: String
    let price: Double
    let image: String
    
    init(output: EventsOutput) {
        self.id = output.id
        self.title = output.title
        self.description = output.description
        self.date = Date.fromMilli(output.date)
        self.price = output.price
        self.image = output.image
    }
}
