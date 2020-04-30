//
//  EventsRouter.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 28/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit

final class EventsRouter: EventsRoutering {
    
    weak var router: EventDetailRoutering?
    private let navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func makeViewController() -> UIViewController {
        let service = EventsService()
        let presenter = EventsPresenter(service: service, router: self)
        service.output = presenter
        let dataSource = TableViewDataSoruce()
        let viewController = EventsViewController(presenter: presenter, dataSource: dataSource)
        return viewController
    }
    
    func navigateToEventDetail(with id: String) {
        let router = EventDetailRouter(navigator: navigator, id: id)
        navigator.pushViewController(router.makeViewController(), animated: true)
        
        self.router = router
    }
}
