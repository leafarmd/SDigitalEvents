//
//  EventsService.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 27/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import Foundation

final class EventsService: EventsServiceInput {
    
    private let service: APIProtocols
    weak var output: EventsServiceOutput?
    
    init(service: APIProtocols) {
        self.service = service
    }
    
    func fetchEvents() {
        
        service.requestObject(from: .events, data: nil, type: [EventsOutput].self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.output?.fetchEventsSucceeded(output: response)
            case .failure(let failure):
                self?.output?.fetchEventsFailed(error: failure.message)
            }
        }
    }
}
