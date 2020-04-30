import Foundation

final class CheckInService: CheckInServiceInput {
    var output: CheckInServiceOutput?
    
    func checkIn(input: CheckInInput) {
        
        do{
            let jsonData = try JSONEncoder().encode(input)
            
            APIService.requestObject(from: .checkIn, data: jsonData, type: CheckInOutput.self) { [weak self] result in
                switch result {
                case .success(let response):
                    if response.code == "200" {
                        self?.output?.checkInSucceeded()
                    } else {
                        self?.output?.checkInFailed(error: "check in failed")
                    }
                case .failure(_):
                    self?.output?.checkInFailed(error: "check in failed")
                }
                
            }
        } catch {
            output?.checkInFailed(error: "check in failed")
        }
        
    }
}


