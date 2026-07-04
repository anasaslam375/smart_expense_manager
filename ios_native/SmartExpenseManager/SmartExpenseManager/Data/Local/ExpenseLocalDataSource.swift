import Foundation
import SwiftData

@MainActor
class ExpenseLocalDataSource {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchAllExpenses() -> [Expense] {
        let descriptor = FetchDescriptor<Expense>()
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func saveExpense(_ expense: Expense) {
        modelContext.insert(expense)
        try? modelContext.save()
    }
    
    func deleteExpense(_ expense: Expense) {
        modelContext.delete(expense)
        try? modelContext.save()
    }
    
    func fetchExpenses(forDate date: Date) -> [Expense] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = #Predicate<Expense> { $0.date >= startOfDay && $0.date < endOfDay }
        let descriptor = FetchDescriptor<Expense>(predicate: predicate)
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func fetchExpenses(inCategory category: Category) -> [Expense] {
        let predicate = #Predicate<Expense> { $0.category.id == category.id }
        let descriptor = FetchDescriptor<Expense>(predicate: predicate)
        return (try? modelContext.fetch(descriptor)) ?? []
    }
}
