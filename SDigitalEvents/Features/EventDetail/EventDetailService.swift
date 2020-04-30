//
//  EventDetailService.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 28/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import Foundation

final class EventDetailService: EventDetailServiceInput {
    
    weak var output: EventDetailServiceOutput?
    private let id: String
    
    init(id: String) {
        self.id = id
    }
    func fetchEventDetail() {
        
         APIService.requestObject(from: .eventDetail(id), type: EventsOutput.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.output?.fetchEventDetailSucceeded(output: response)
            case .failure(let failure):
                self?.output?.fetchEventDetailFailed(error: failure.message)
            }
        }
    }
}

