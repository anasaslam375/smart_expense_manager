import 'package:smart_expense_manager/core/result.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';
import 'package:smart_expense_manager/domain/repositories/expense_repository.dart';

class SaveExpense {
  final ExpenseRepository repository;

  SaveExpense(this.repository);

  Future<Result<void>> call(Expense expense) {
    return repository.saveExpense(expense);
  }
}
