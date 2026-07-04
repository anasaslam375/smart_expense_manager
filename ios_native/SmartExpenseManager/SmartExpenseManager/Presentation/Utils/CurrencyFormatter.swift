import Foundation
import SmartExpenseManager

struct CurrencyFormatter {
    static func format(_ amount: Double) -> String {
        return "\(AppConstants.currencySymbol)\(String(format: "%.2f", amount))"
    }
}
