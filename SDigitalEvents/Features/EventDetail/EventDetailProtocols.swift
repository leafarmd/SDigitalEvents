//
//  EventsDetailProtocols.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 28/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit

protocol EventDetailView: class {
    func showLoadingFeedback()
    func hideLoadingFeedback()
    func reloadData(with model: EventDetailModel)
    func presentMessage(title: String, message: String)
}

protocol EventDetailRoutering: class {
    func makeViewController() -> UIViewController
    func navigateToCheckIn(model: EventDetailModel)
}

protocol EventDetailServiceInput: class {
    var output: EventDetailServiceOutput? { get }
    func fetchEventDetail()
}

protocol EventDetailServiceOutput: class {
    func fetchEventDetailSucceeded(output: EventsOutput)
    func fetchEventDetailFailed(error message: String)
}
