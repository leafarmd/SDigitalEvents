import UIKit

final class EventDetailViewController: TableViewController {
    
    private let presenter: EventDetailPresenter
    
    init(presenter: EventDetailPresenter, dataSource: TableViewDataSoruce) {
        self.presenter = presenter
        
        super.init(dataSoruce: dataSource, nibName: "EventDetailViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attachView(self)
    }
}

extension EventDetailViewController: EventDetailView {
    
    func showLoadingFeedback() {
        Loading.start()
    }
    
    func hideLoadingFeedback() {
        Loading.stop()
    }
    
    func reloadData(with model: EventDetailModel) {
        dataSoruce.model.items.append(EventDetailCellConfig(item: model))
        dataSoruce.model.items.append(CheckInCellConfig(item: (model, self)))
        dataSoruce.model.items.append((DetailMapCellConfig(item: (model.geoLocation.latitude,
                                                                  model.geoLocation.longitude))))
        
        tableView.reloadData()
    }
    
    func presentMessage(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}

extension EventDetailViewController: CheckInDelegate {
    func checkEvent(with model: EventDetailModel) {
        presenter.presentCheckIn(with: model)
    }
}
