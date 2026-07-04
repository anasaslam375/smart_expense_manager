import Foundation

@MainActor
class ExpenseRepositoryImpl: ExpenseRepository {
    private let localDataSource: ExpenseLocalDataSource

    init(localDataSource: ExpenseLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func getExpenses() async -> Result<[Expense], Error> {
        do {
            let expenses = localDataSource.fetchAllExpenses()
            return .success(expenses)
        } catch {
            return .failure(error)
        }
    }

    func getExpense(byId id: UUID) async -> Result<Expense?, Error> {
        do {
            let expenses = localDataSource.fetchAllExpenses()
            let expense = expenses.first { $0.id == id }
            return .success(expense)
        } catch {
            return .failure(error)
        }
    }

    func saveExpense(_ expense: Expense) async -> Result<Void, Error> {
        do {
            localDataSource.saveExpense(expense)
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func deleteExpense(_ expense: Expense) async -> Result<Void, Error> {
        do {
            localDataSource.deleteExpense(expense)
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func getExpenses(forDate date: Date) async -> Result<[Expense], Error> {
        do {
            let expenses = localDataSource.fetchExpenses(forDate: date)
            return .success(expenses)
        } catch {
            return .failure(error)
        }
    }

    func getExpenses(inCategory category: Category) async -> Result<[Expense], Error> {
        do {
            let expenses = localDataSource.fetchExpenses(inCategory: category)
            return .success(expenses)
        } catch {
            return .failure(error)
        }
    }

    func getTotalAmount() async -> Result<Double, Error> {
        do {
            let expenses = localDataSource.fetchAllExpenses()
            let total = expenses.reduce(0.0) { $0 + $1.amount }
            return .success(total)
        } catch {
            return .failure(error)
        }
    }
}
