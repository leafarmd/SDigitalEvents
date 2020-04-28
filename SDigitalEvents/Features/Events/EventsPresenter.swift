//
//  EventsPresenter.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 27/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import Foundation

final class EventsPresenter {
    
    var models: [EventModel] = []
    weak var view: EventsView?
    private let service: EventsServiceInput
    private let router: EventsRoutering
    
    init(service: EventsServiceInput, router: EventsRoutering) {
        self.service = service
        self.router = router
    }
    
    func attachView(_ view: EventsView) {
        self.view = view
        
        view.showLoadingFeedback()
        service.fetchEvents()
    }
    
    func eventSelected(_ index: Int) {
        router.navigateToEventDetail(with: models[index].id)
    }
}

extension EventsPresenter: EventsServiceOutput {
    
    func fetchEventsSucceeded(output: [EventsOutput]) {
        view?.hideLoadingFeedback()
        
        
        output.forEach { models.append(EventModel(output: $0)) }
        view?.reloadData(with: models)
    }
    
    func fetchEventsFailed(error message: String) {
        view?.hideLoadingFeedback()
        view?.showMessage(title: "Error", message: message)
    }
}
