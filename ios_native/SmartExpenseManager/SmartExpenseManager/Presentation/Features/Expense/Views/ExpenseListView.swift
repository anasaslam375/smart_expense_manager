import SwiftUI
import SmartExpenseManager

struct ExpenseListView: View {
    @StateObject private var viewModel: ExpenseViewModel
    @State private var showingAddExpense = false
    @State private var selectedExpense: Expense?

    init(viewModel: ExpenseViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading && viewModel.expenses.isEmpty {
                    ProgressView(AppStrings.loadingExpenses)
                } else if viewModel.expenses.isEmpty {
                    emptyStateView
                } else {
                    expenseList
                }
            }
            .navigationTitle(AppStrings.expensesTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddExpense = true }) {
                        Image(systemName: AppIcons.add)
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView(viewModel: viewModel)
            }
            .alertView(
                isPresented: .constant(viewModel.errorMessage != nil),
                message: viewModel.errorMessage
            ) {
                viewModel.errorMessage = nil
            }
            .task {
                await viewModel.loadExpenses()
            }
        }
    }

    private var emptyStateView: some View {
        EmptyStateView()
    }
    
    private var expenseList: some View {
        List {
            ForEach(viewModel.expenses) { expense in
                ExpenseRowView(expense: expense)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedExpense = expense
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            Task {
                                await viewModel.deleteExpense(expense)
                            }
                        } label: {
                            Label(AppStrings.delete, systemImage: AppIcons.trash)
                        }
                    }
            }
        }
        .refreshable {
            await viewModel.loadExpenses()
        }
    }
}

struct ExpenseRowView: View {
    let expense: Expense

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: AppConstants.rowVerticalSpacing) {
                Text(expense.category.name)
                    .font(.headline)
                if let note = expense.note, !note.isEmpty {
                    Text(note)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Text(expense.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(expense.amount, format: .currency(code: AppStrings.currencyCode))
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
        .padding(.vertical, AppConstants.rowVerticalPadding)
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
    
    return ExpenseListView(viewModel: viewModel)
        .modelContainer(modelContainer)
}
