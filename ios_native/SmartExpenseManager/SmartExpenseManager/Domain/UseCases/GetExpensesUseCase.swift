import Foundation

class GetExpensesUseCase {
    private let repository: ExpenseRepository
    
    init(repository: ExpenseRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<[Expense], Error> {
        return await repository.getExpenses()
    }
    
    func execute(forDate date: Date) async -> Result<[Expense], Error> {
        return await repository.getExpenses(forDate: date)
    }
    
    func execute(inCategory category: Category) async -> Result<[Expense], Error> {
        return await repository.getExpenses(inCategory: category)
    }
}
