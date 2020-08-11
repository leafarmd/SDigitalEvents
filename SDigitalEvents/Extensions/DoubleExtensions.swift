import Foundation

extension Double {
    var ptBRCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt-BR")
        return formatter.string(from: self as NSNumber)!
    }
}
