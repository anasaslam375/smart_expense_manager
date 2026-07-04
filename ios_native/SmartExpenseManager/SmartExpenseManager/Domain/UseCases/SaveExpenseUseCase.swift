import Foundation

class SaveExpenseUseCase {
    private let repository: ExpenseRepository
    
    init(repository: ExpenseRepository) {
        self.repository = repository
    }
    
    func execute(_ expense: Expense) async -> Result<Void, Error> {
        return await repository.saveExpense(expense)
    }
}
