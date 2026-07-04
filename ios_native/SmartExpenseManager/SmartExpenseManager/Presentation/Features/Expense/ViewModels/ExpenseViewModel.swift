import Foundation
import SwiftUI

@MainActor
class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedCategory: Category?
    @Published var selectedDate: Date = Date()

    private let getExpensesUseCase: GetExpensesUseCase
    private let saveExpenseUseCase: SaveExpenseUseCase
    private let deleteExpenseUseCase: DeleteExpenseUseCase

    init(
        getExpensesUseCase: GetExpensesUseCase,
        saveExpenseUseCase: SaveExpenseUseCase,
        deleteExpenseUseCase: DeleteExpenseUseCase
    ) {
        self.getExpensesUseCase = getExpensesUseCase
        self.saveExpenseUseCase = saveExpenseUseCase
        self.deleteExpenseUseCase = deleteExpenseUseCase
    }

    func loadExpenses() async {
        isLoading = true
        errorMessage = nil

        do {
            expenses = try await getExpensesUseCase.execute()
        } catch {
            errorMessage = "\(AppStrings.failedToLoadExpenses): \(error.localizedDescription)"
        }

        isLoading = false
    }

    func loadExpenses(forDate date: Date) async {
        isLoading = true
        errorMessage = nil

        do {
            expenses = try await getExpensesUseCase.execute(forDate: date)
        } catch {
            errorMessage = "\(AppStrings.failedToLoadExpenses): \(error.localizedDescription)"
        }

        isLoading = false
    }

    func loadExpenses(inCategory category: Category) async {
        isLoading = true
        errorMessage = nil

        do {
            expenses = try await getExpensesUseCase.execute(inCategory: category)
        } catch {
            errorMessage = "\(AppStrings.failedToLoadExpenses): \(error.localizedDescription)"
        }

        isLoading = false
    }

    func saveExpense(
        amount: Double,
        category: Category,
        date: Date,
        note: String?
    ) async {
        isLoading = true
        errorMessage = nil

        let expense = Expense(
            amount: amount,
            category: category,
            date: date,
            note: note
        )

        do {
            try await saveExpenseUseCase.execute(expense)
            await loadExpenses()
        } catch {
            errorMessage = "\(AppStrings.failedToSaveExpense): \(error.localizedDescription)"
        }

        isLoading = false
    }

    func deleteExpense(_ expense: Expense) async {
        isLoading = true
        errorMessage = nil

        do {
            try await deleteExpenseUseCase.execute(expense)
            await loadExpenses()
        } catch {
            errorMessage = "\(AppStrings.failedToDeleteExpense): \(error.localizedDescription)"
        }

        isLoading = false
    }

    var totalAmount: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    var expensesByCategory: [Category: [Expense]] {
        Dictionary(grouping: expenses) { $0.category }
    }
}
