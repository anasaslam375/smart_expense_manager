import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ExpenseViewModel

    @State private var amount: String = ""
    @State private var selectedCategory: Category = Category.defaultCategories[0]
    @State private var date: Date = Date()
    @State private var note: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(AppStrings.expenseDetails)) {
                    HStack {
                        Text(AppStrings.amount)
                            .frame(width: AppConstants.formLabelWidth, alignment: .leading)
                        TextField(AppStrings.amountPlaceholder, text: $amount)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }

                    Picker(AppStrings.category, selection: $selectedCategory) {
                        ForEach(Category.defaultCategories) { category in
                            HStack {
                                Image(systemName: category.icon)
                                Text(category.name)
                            }
                            .tag(category)
                        }
                    }

                    DatePicker(AppStrings.date, selection: $date, displayedComponents: .date)

                    TextField(AppStrings.noteOptional, text: $note)
                }
            }
            .navigationTitle(AppStrings.addExpenseTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(AppStrings.cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(AppStrings.save) {
                        saveExpense()
                    }
                    .disabled(amount.isEmpty || Double(amount) == nil)
                }
            }
            .alertView(
                isPresented: $showingAlert,
                message: alertMessage
            )
        }
    }

    private func saveExpense() {
        guard let expenseAmount = Double(amount), expenseAmount > 0 else {
            alertMessage = AppStrings.pleaseEnterValidAmount
            showingAlert = true
            return
        }

        Task {
            await viewModel.saveExpense(
                amount: expenseAmount,
                category: selectedCategory,
                date: date,
                note: note.isEmpty ? nil : note
            )

            if viewModel.errorMessage == nil {
                dismiss()
            }
        }
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: Expense.self, Category.self)
    let localDataSource = ExpenseLocalDataSource(modelContext: modelContainer.mainContext)
    let repository = ExpenseRepositoryImpl(localDataSource: localDataSource)
    let getExpensesUseCase = GetExpensesUseCase(repository: repository)
    let saveExpenseUseCase = SaveExpenseUseCase(repository: repository)
    let deleteExpenseUseCase = DeleteExpenseUseCase(repository: repository)
    let viewModel = ExpenseViewModel(
        getExpensesUseCase: getExpensesUseCase,
        saveExpenseUseCase: saveExpenseUseCase,
        deleteExpenseUseCase: deleteExpenseUseCase
    )
    
    return AddExpenseView(viewModel: viewModel)
        .modelContainer(modelContainer)
}
