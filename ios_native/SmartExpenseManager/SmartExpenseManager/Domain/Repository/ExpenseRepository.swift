import Foundation

protocol ExpenseRepository {
    func getExpenses() async -> Result<[Expense], Error>
    func getExpense(byId id: UUID) async -> Result<Expense?, Error>
    func saveExpense(_ expense: Expense) async -> Result<Void, Error>
    func deleteExpense(_ expense: Expense) async -> Result<Void, Error>
    func getExpenses(forDate date: Date) async -> Result<[Expense], Error>
    func getExpenses(inCategory category: Category) async -> Result<[Expense], Error>
    func getTotalAmount() async -> Result<Double, Error>
}
