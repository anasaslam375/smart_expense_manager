import XCTest
import SwiftData
@testable import SmartExpenseManager

@MainActor
class ExpenseViewModelTests: XCTestCase {
    var viewModel: ExpenseViewModel!
    var mockRepository: MockExpenseRepository!
    var modelContainer: ModelContainer!
    
    override func setUp() {
        super.setUp()
        
        let schema = Schema([Expense.self, Category.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        modelContainer = try! ModelContainer(for: schema, configurations: [modelConfiguration])
        
        mockRepository = MockExpenseRepository()
        let getExpensesUseCase = GetExpensesUseCase(repository: mockRepository)
        let saveExpenseUseCase = SaveExpenseUseCase(repository: mockRepository)
        let deleteExpenseUseCase = DeleteExpenseUseCase(repository: mockRepository)
        
        viewModel = ExpenseViewModel(
            getExpensesUseCase: getExpensesUseCase,
            saveExpenseUseCase: saveExpenseUseCase,
            deleteExpenseUseCase: deleteExpenseUseCase
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        modelContainer = nil
        super.tearDown()
    }
    
    func testLoadExpenses_Success() async {
        let expectedExpenses = [
            Expense(amount: 100.0, category: Category.defaultCategories[0]),
            Expense(amount: 50.0, category: Category.defaultCategories[1])
        ]
        mockRepository.expensesToReturn = expectedExpenses
        
        await viewModel.loadExpenses()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.expenses.count, 2)
        XCTAssertEqual(viewModel.expenses[0].amount, 100.0)
    }
    
    func testLoadExpenses_Failure() async {
        mockRepository.shouldThrowError = true
        
        await viewModel.loadExpenses()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.expenses.isEmpty)
    }
    
    func testSaveExpense_Success() async {
        let category = Category.defaultCategories[0]
        
        await viewModel.saveExpense(amount: 100.0, category: category, date: Date(), note: "Test")
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertTrue(mockRepository.saveCalled)
    }
    
    func testSaveExpense_InvalidAmount() async {
        let category = Category.defaultCategories[0]
        
        await viewModel.saveExpense(amount: -10.0, category: category, date: Date(), note: "Test")
        
        XCTAssertFalse(mockRepository.saveCalled)
    }
    
    func testDeleteExpense_Success() async {
        let expense = Expense(amount: 100.0, category: Category.defaultCategories[0])
        mockRepository.expensesToReturn = [expense]
        
        await viewModel.deleteExpense(expense)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertTrue(mockRepository.deleteCalled)
    }
    
    func testTotalAmount() async {
        let expenses = [
            Expense(amount: 100.0, category: Category.defaultCategories[0]),
            Expense(amount: 50.0, category: Category.defaultCategories[1]),
            Expense(amount: 25.0, category: Category.defaultCategories[2])
        ]
        mockRepository.expensesToReturn = expenses
        
        await viewModel.loadExpenses()
        
        XCTAssertEqual(viewModel.totalAmount, 175.0)
    }
}

class MockExpenseRepository: ExpenseRepository {
    var expensesToReturn: [Expense] = []
    var shouldThrowError = false
    var saveCalled = false
    var deleteCalled = false
    
    func getExpenses() async throws -> [Expense] {
        if shouldThrowError {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
        return expensesToReturn
    }
    
    func getExpense(byId id: UUID) async throws -> Expense? {
        return expensesToReturn.first { $0.id == id }
    }
    
    func saveExpense(_ expense: Expense) async throws {
        if shouldThrowError {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
        saveCalled = true
        expensesToReturn.append(expense)
    }
    
    func deleteExpense(_ expense: Expense) async throws {
        if shouldThrowError {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
        deleteCalled = true
        expensesToReturn.removeAll { $0.id == expense.id }
    }
    
    func getExpenses(forDate date: Date) async throws -> [Expense] {
        return expensesToReturn
    }
    
    func getExpenses(inCategory category: Category) async throws -> [Expense] {
        return expensesToReturn.filter { $0.category.id == category.id }
    }
}
