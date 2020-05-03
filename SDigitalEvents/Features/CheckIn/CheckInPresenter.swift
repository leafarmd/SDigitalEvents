import Foundation

final class CheckInPresenter {
 
    private let model: EventDetailModel
    weak var view: CheckInView?
    private var service: CheckInService?
    
    init(model: EventDetailModel) {
        self.model = model
    }
    
    func attachView(_ view: CheckInView) {
        self.view = view
        
        setupView()
    }
    
    private func setupView() {
        let price = model.price
        let coupon = (model.cupons?.first ?? 0) ?? 0
        let discount = Double(coupon)/100
        view?.setPrice(price.ptBRCurrency)
        view?.setDiscount((price * discount).ptBRCurrency)
        view?.setTotal((price - (price * discount)).ptBRCurrency)
        view?.setTitle(model.title)
    }
    
    func checkInUser(name: String?, email: String?) {
        
        guard let name = name, let email = email  else {
            view?.presentMessage(title: "Error", message: "Name or Email Empty")
            return
        }
        
        if name.isEmpty || email.isEmpty {
            view?.presentMessage(title: "Error", message: "Name or Email Empty")
            return
        }
        
        if !email.isValidEmail() {
            view?.presentMessage(title: "Error", message: "Invalid Email")
            return
        }
        
        let input = CheckInInput(eventId: model.id, name: name, email: email)
        service = CheckInService(service: APICore())
        service?.output = self
        service?.checkIn(input: input)
        view?.showLoadingFeedback()
        
    }
}

// MARK: - CheckInServiceOutput

extension CheckInPresenter: CheckInServiceOutput {
    func checkInSucceeded() {
        view?.hideLoadingFeedback()
        view?.presentMessage(title: "Success", message: "Check In Succeeded")
    }
    
    func checkInFailed(error message: String) {
        view?.hideLoadingFeedback()
        view?.presentMessage(title: "Error", message: message)
    }
}
