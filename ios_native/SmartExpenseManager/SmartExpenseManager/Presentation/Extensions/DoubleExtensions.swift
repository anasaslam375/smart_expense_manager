import Foundation
import SmartExpenseManager

extension Double {
    func toCurrency() -> String {
        return "\(AppConstants.currencySymbol)\(String(format: "%.2f", self))"
    }
}
