//
//  SDigitalEventsTests.swift
//  SDigitalEventsTests
//
//  Created by Rafael on 27/4/20.
//  Copyright © 2020 rmd. All rights reserved.
//

import XCTest
@testable import SDigitalEvents

class SDigitalEventsTests: XCTestCase {

    var api: APIStub!
    var sut: EventsService!
    fileprivate var output: EventServiceOutputSpy!
    
    func testFetchSucceeded() {
        output = EventServiceOutputSpy()
        api = APIStub(status: .success(EventsOutput.mock))
        sut = EventsService(service: api)
        sut.output = output
        sut.fetchEvents()
        
        XCTAssertEqual(api.url, "https://5b840ba5db24a100142dcd8c.mockapi.io/api/events")
        XCTAssertEqual(api.method, .GET)
        XCTAssertEqual(output.fetchEventsSucceededCalled, true)
        XCTAssertEqual(output.output?.count, 1)
    }
    
    func testDecodingError() {
        output = EventServiceOutputSpy()
        api = APIStub(status: .failure(.decodingFailed))
        sut = EventsService(service: api)
        sut.output = output
        sut.fetchEvents()
        XCTAssertEqual(output?.fetchEventsFailedCalled, true)
        XCTAssertEqual(output?.errorMessage, "data decode failed")
    }
    
    func testInvalidDataError() {
        output = EventServiceOutputSpy()
        api = APIStub(status: .failure(.invalidData))
        sut = EventsService(service: api)
        sut.output = output
        sut.fetchEvents()
        XCTAssertEqual(output?.fetchEventsFailedCalled, true)
        XCTAssertEqual(output?.errorMessage, "invalid data")
    }
    
    func testMalformedError() {
        output = EventServiceOutputSpy()
        api = APIStub(status: .failure(.malformedURL))
        sut = EventsService(service: api)
        sut.output = output
        sut.fetchEvents()
        XCTAssertEqual(output?.fetchEventsFailedCalled, true)
        XCTAssertEqual(output?.errorMessage, "error with URL requested")
    }
    
    func testRequestError() {
        output = EventServiceOutputSpy()
        api = APIStub(status: .failure(.requestFailed))
        sut = EventsService(service: api)
        sut.output = output
        sut.fetchEvents()
        XCTAssertEqual(output?.fetchEventsFailedCalled, true)
        XCTAssertEqual(output?.errorMessage, "error with request")
    }

}

fileprivate class EventServiceOutputSpy: EventsServiceOutput {
    
    var fetchEventsSucceededCalled: Bool!
    var output: [EventsOutput]?
    var fetchEventsFailedCalled: Bool?
    var errorMessage: String?
    
    func fetchEventsSucceeded(output: [EventsOutput]) {
        fetchEventsSucceededCalled = true
        self.output = output
    }
    
    func fetchEventsFailed(error message: String) {
        fetchEventsFailedCalled = true
        self.errorMessage = message
    }
}

fileprivate extension EventsOutput {
    static var mock: [EventsOutput] {
        [EventsOutput(id: "id value",
                      title: "title value",
                      price: 10.0,
                      latitude: 20.0,
                      longitude: -20.0,
                      image: "image value",
                      description: "description value",
                      date: 123456789,
                      cupons: [CuponOutput(id: "",
                                           eventID: "",
                                           discount: 0)],
                      people: [PeopleOutput(id: nil, eventID: nil,
                                            name: nil,
                                            picture: nil)])]
    }
}
