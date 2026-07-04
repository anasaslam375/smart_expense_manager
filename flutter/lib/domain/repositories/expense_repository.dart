import 'package:smart_expense_manager/core/result.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';

abstract class ExpenseRepository {
  Future<Result<List<Expense>>> getExpenses();
  Future<Result<Expense?>> getExpenseById(String id);
  Future<Result<void>> saveExpense(Expense expense);
  Future<Result<void>> deleteExpense(Expense expense);
  Future<Result<List<Expense>>> getExpensesByDate(DateTime date);
  Future<Result<List<Expense>>> getExpensesByCategory(Category category);
  Future<Result<double>> getTotalAmount();
}
