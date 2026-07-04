import 'package:hive/hive.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';

class ExpenseLocalDataSource {
  final Box<Expense> expenseBox;

  ExpenseLocalDataSource(this.expenseBox);

  Future<List<Expense>> getAllExpenses() async {
    // Hive operations are synchronous, but we return Future for consistency
    // Using toList() to create a new list for immutability
    return expenseBox.values.toList(growable: false);
  }

  Future<List<Expense>> getExpensesByCategory(Category category) async {
    // Filter and create immutable list
    return expenseBox.values
        .where((expense) => expense.category.id == category.id)
        .toList(growable: false);
  }

  Future<List<Expense>> getExpensesByDate(DateTime date) async {
    // Filter by date and create immutable list
    return expenseBox.values
        .where((expense) =>
            expense.date.year == date.year &&
            expense.date.month == date.month &&
            expense.date.day == date.day)
        .toList(growable: false);
  }

  Future<void> saveExpense(Expense expense) async {
    // Hive put is synchronous but we await for consistency
    await expenseBox.put(expense.id, expense);
  }

  Future<void> deleteExpense(String id) async {
    // Hive delete is synchronous but we await for consistency
    await expenseBox.delete(id);
  }

  Future<double> getTotalAmount() async {
    // Calculate total without creating intermediate list for performance
    return expenseBox.values.fold<double>(
      0.0,
      (sum, expense) => sum + expense.amount,
    );
  }
}
