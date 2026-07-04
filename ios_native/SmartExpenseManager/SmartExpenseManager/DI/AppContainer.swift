import Foundation
import SwiftData

@MainActor
class AppContainer {
    static let shared = AppContainer()
    
    private let modelContainer: ModelContainer
    private let localDataSource: ExpenseLocalDataSource
    private let repository: ExpenseRepositoryImpl
    
    private init() {
        let schema = Schema([Expense.self, Category.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
        localDataSource = ExpenseLocalDataSource(modelContext: modelContainer.mainContext)
        repository = ExpenseRepositoryImpl(localDataSource: localDataSource)
    }
    
    func makeExpenseViewModel() -> ExpenseViewModel {
        let getExpensesUseCase = GetExpensesUseCase(repository: repository)
        let saveExpenseUseCase = SaveExpenseUseCase(repository: repository)
        let deleteExpenseUseCase = DeleteExpenseUseCase(repository: repository)
        
        return ExpenseViewModel(
            getExpensesUseCase: getExpensesUseCase,
            saveExpenseUseCase: saveExpenseUseCase,
            deleteExpenseUseCase: deleteExpenseUseCase
        )
    }
    
    var modelContext: ModelContext {
        modelContainer.mainContext
    }
}
