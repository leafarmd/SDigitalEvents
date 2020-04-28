//
//  EventsViewController.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 28/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit

final class EventsViewController: TableViewController {
    
    private let presenter: EventsPresenter
    
    init(presenter: EventsPresenter, dataSource: TableViewDataSoruce) {
        self.presenter = presenter
        
        super.init(dataSoruce: dataSource, nibName: "EventsViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        presenter.attachView(self)
    }
}

extension EventsViewController: EventsView {
    
    func showLoadingFeedback() {
        Loading.start()
    }
    
    func hideLoadingFeedback() {
        Loading.stop()
    }
    
    func reloadData(with model: [EventModel]) {
        model.forEach { dataSoruce.model.items.append(EventsCellConfig(item: $0)) }
        tableView.reloadData()
    }
    
    func showMessage(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}

extension EventsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.eventSelected(indexPath.row)
    }
}
