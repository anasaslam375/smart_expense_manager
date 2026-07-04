import 'package:smart_expense_manager/core/result.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';
import 'package:smart_expense_manager/domain/repositories/expense_repository.dart';

class GetExpenses {
  final ExpenseRepository repository;

  GetExpenses(this.repository);

  Future<Result<List<Expense>>> call() {
    return repository.getExpenses();
  }

  Future<Result<List<Expense>>> callByDate(DateTime date) {
    return repository.getExpensesByDate(date);
  }

  Future<Result<List<Expense>>> callByCategory(Category category) {
    return repository.getExpensesByCategory(category);
  }
}
