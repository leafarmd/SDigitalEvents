import UIKit

protocol CheckInView: class {
    func setTitle(_ text: String)
    func setPrice(_ value: String)
    func setDiscount(_ value: String)
    func setTotal(_ value: String)
    func showLoadingFeedback()
    func hideLoadingFeedback()
    func presentMessage(title: String, message: String)
}

protocol CheckInRoutering: class {
    func makeViewController() -> UIViewController
}

protocol CheckInServiceInput: class {
    var output: CheckInServiceOutput? { get }
    func checkIn(input: CheckInInput)
}

protocol CheckInServiceOutput: class {
    func checkInSucceeded()
    func checkInFailed(error message: String)
}
