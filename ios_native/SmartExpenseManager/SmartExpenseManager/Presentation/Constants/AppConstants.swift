import Foundation
import SwiftUI

/// App-wide constants for UI components
struct AppConstants {
    // Layout
    static let emptyStateIconSize: CGFloat = 60
    static let emptyStateSpacing: CGFloat = 20
    static let rowVerticalPadding: CGFloat = 4
    static let rowVerticalSpacing: CGFloat = 4
    static let formLabelWidth: CGFloat = 100
    static let emptyStatePadding: CGFloat = 16
}

/// App-wide string constants
struct AppStrings {
    // Navigation
    static let expensesTitle = "Expenses"
    static let addExpenseTitle = "Add Expense"

    // Loading
    static let loadingExpenses = "Loading expenses..."

    // Empty state
    static let noExpensesYet = "No expenses yet"
    static let tapToAddExpense = "Tap the + button to add your first expense"

    // Actions
    static let delete = "Delete"
    static let ok = "OK"
    static let error = "Error"
    static let cancel = "Cancel"
    static let save = "Save"

    // Form labels
    static let expenseDetails = "Expense Details"
    static let amount = "Amount"
    static let category = "Category"
    static let date = "Date"
    static let noteOptional = "Note (optional)"
    static let pleaseEnterValidAmount = "Please enter a valid amount"

    // Currency
    static let currencyCode = "USD"
    static let currencySymbol = "$"

    // Format
    static let amountPlaceholder = "0.00"

    // Error messages
    static let failedToLoadExpenses = "Failed to load expenses"
    static let failedToSaveExpense = "Failed to save expense"
    static let failedToDeleteExpense = "Failed to delete expense"
    
    // API endpoints
    static let httpsPrefix = "https://"
    
    // Validation thresholds
    static let maxAmount = 1_000_000.00
    static let maxNoteLength = 500
    static let maxCategoryNameLength = 50
    static let minCategoryNameLength = 1
}

/// App-wide icon constants
struct AppIcons {
    static let add = "plus"
    static let receipt = "receipt"
    static let trash = "trash"
}
