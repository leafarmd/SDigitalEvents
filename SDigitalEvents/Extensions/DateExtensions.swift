import Foundation

extension Date {
    static func fromMilli(_ milliseconds: Int) -> String{
        let date = Date.init(timeIntervalSince1970: TimeInterval(milliseconds)/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
        return formatter.string(from: date)
    }
    
    func fromFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
