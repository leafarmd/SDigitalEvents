import Foundation

final class EventDetailService: EventDetailServiceInput {
    
    private let service: APIProtocols
    private let id: String
    
    weak var output: EventDetailServiceOutput?
    
    
    init(id: String, service:APIProtocols ) {
        self.id = id
        self.service = service
    }
    func fetchEventDetail() {
        
        service.requestObject(from: .eventDetail(id), data: nil, type: EventsOutput.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.output?.fetchEventDetailSucceeded(output: response)
            case .failure(let failure):
                self?.output?.fetchEventDetailFailed(error: failure.message)
            }
        }
    }
}

