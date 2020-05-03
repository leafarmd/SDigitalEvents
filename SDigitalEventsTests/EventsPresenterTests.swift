import XCTest
@testable import SDigitalEvents

class EventsPresenterTests: XCTestCase {
    
    fileprivate var view: EventsViewSpy?
    fileprivate var service: EventsServiceSpy?
    fileprivate var router: EventsRouterSpy?
    private var presenter: EventsPresenter?
    
    override func setUp() {
        view = EventsViewSpy()
        service = EventsServiceSpy()
        router = EventsRouterSpy()
        presenter = EventsPresenter(service: service!, router: router!)
        service?.output = presenter!
        presenter?.attachView(view!)
    }
    
    func testPresenterFetchEventsWithSuccess() {
        //when presenter is attached
        
        //then it will show loading feedback and will fetchData from service
        XCTAssertTrue(view?.showLoadingFeedbackCalled == true)
        XCTAssertTrue(service?.fethEventCalled == true)
        
        //when service return success
        presenter?.fetchEventsSucceeded(output: EventsOutput.dummy)
        
        //then it will hide loading feedback and reload data
        XCTAssertTrue(view?.hideLoadingFeedbackCalled == true)
        XCTAssertTrue(view?.reoladDataCalled == true)
        
        //when an event is selected
        presenter?.eventSelected(0)
        
        //then it will call navigation router and pass value selected
        XCTAssertTrue(router?.navigateToEventDetailCalled == true)
        XCTAssertTrue(router?.idPassed == "1")
    }
    
    func testPresenterFetchEventsWithFailure() {
        //when presenter is attached
        
        //then it will show loading feedback and will fetchData from service
        XCTAssertTrue(view?.showLoadingFeedbackCalled == true)
        XCTAssertTrue(service?.fethEventCalled == true)
        
        //when service return failure
        presenter?.fetchEventsFailed(error: "error value")
        
        //then it will hide loading feedback and present error
        XCTAssertTrue(view?.hideLoadingFeedbackCalled == true)
        XCTAssertTrue(view?.showMessageCalled == true)
        XCTAssertTrue(view?.messagePassed == "error value")
    }
}

private class EventsViewSpy: EventsView {
    var showLoadingFeedbackCalled: Bool?
    var hideLoadingFeedbackCalled: Bool?
    var reoladDataCalled: Bool?
    var modelPassed: [EventModel]?
    var showMessageCalled:Bool?
    var titlePassed: String?
    var messagePassed: String?
    
    func showLoadingFeedback() {
        showLoadingFeedbackCalled = true
    }
    
    func hideLoadingFeedback() {
        hideLoadingFeedbackCalled = true
    }
    
    func reloadData(with model: [EventModel]) {
        reoladDataCalled = true
        modelPassed = model
    }
    
    func showMessage(title: String, message: String) {
        showMessageCalled = true
        titlePassed = title
        messagePassed = message
    }
}

private class EventsServiceSpy: EventsServiceInput {
    var output: EventsServiceOutput?
    
    var fethEventCalled: Bool?
    
    func fetchEvents() {
        fethEventCalled = true
    }
}

private class EventsRouterSpy: EventsRoutering {
    var makeViewControllerCalled: Bool?
    var navigateToEventDetailCalled: Bool?
    var idPassed: String?
    
    func makeViewController() -> UIViewController {
        makeViewControllerCalled = true
        return UIViewController()
    }
    
    func navigateToEventDetail(with id: String) {
        navigateToEventDetailCalled = true
        idPassed = id
    }
}

extension EventsOutput {
    static var dummy: [EventsOutput] {
        return [EventsOutput(id: "1",
                             title: "title value",
                             price: 1.0,
                             latitude: -10.0,
                             longitude: 10.0,
                             image: "image value",
                             description: "description value",
                             date: 0, cupons: [CuponOutput(id: "1",
                                                           eventID: "1",
                                                           discount: 10)],
                             people: [PeopleOutput(id: "1",
                                                   eventID: "1",
                                                   name: "name value",
                                                   picture: "picture value")])]
    }
}
