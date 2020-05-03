import Foundation

final class EventDetailPresenter {
    
    weak var view: EventDetailView?
    private let service: EventDetailServiceInput
    private let router: EventDetailRoutering
    
    
    init(service: EventDetailServiceInput, router: EventDetailRoutering) {
        self.service = service
        self.router = router
    }
    
    func attachView(_ view: EventDetailView) {
        self.view = view
        
        view.showLoadingFeedback()
        service.fetchEventDetail()
    }
}

// MARK: - EventDetailServiceOutput

extension EventDetailPresenter: EventDetailServiceOutput {
    
    func fetchEventDetailSucceeded(output: EventsOutput) {
        view?.hideLoadingFeedback()
        view?.reloadData(with: EventDetailModel(output: output))
    }
    
    func fetchEventDetailFailed(error message: String) {
        view?.hideLoadingFeedback()
        view?.presentMessage(title: "Error", message: message)
    }
    
    func presentCheckIn(with model: EventDetailModel) {
        router.navigateToCheckIn(model: model)
    }
}

