//
//  EventsProtocols.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 27/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit

protocol EventsView: class {
    func showLoadingFeedback()
    func hideLoadingFeedback()
    func reloadData(with model: [EventModel])
    func showMessage(title: String, message: String)
}

protocol EventsRoutering {
    func makeViewController() -> UIViewController
    func navigateToEventDetail(with id: String)
}

protocol EventsServiceInput: class {
    var output: EventsServiceOutput? { get }
    func fetchEvents()
}

protocol EventsServiceOutput: class {
    func fetchEventsSucceeded(output: [EventsOutput])
    func fetchEventsFailed(error message: String)
}
