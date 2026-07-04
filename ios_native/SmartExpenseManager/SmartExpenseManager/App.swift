import SwiftUI
import SwiftData

@main
struct SmartExpenseManagerApp: App {
    let modelContainer: ModelContainer
    
    init() {
        let schema = Schema([Expense.self, Category.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ExpenseListView(viewModel: AppContainer.shared.makeExpenseViewModel())
        }
        .modelContainer(modelContainer)
    }
}
