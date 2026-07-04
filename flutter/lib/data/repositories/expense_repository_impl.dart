import 'package:smart_expense_manager/core/constants/app_constants.dart';
import 'package:smart_expense_manager/core/result.dart';
import 'package:smart_expense_manager/data/datasources/expense_local_datasource.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';
import 'package:smart_expense_manager/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource dataSource;

  ExpenseRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<Expense>>> getExpenses() async {
    try {
      final expenses = await dataSource.getAllExpenses();
      return Result.success(expenses);
    } catch (e) {
      return Result.failure(
          Exception('${AppStrings.failedToLoadExpenses}: $e'));
    }
  }

  @override
  Future<Result<Expense?>> getExpenseById(String id) async {
    try {
      final expenses = await dataSource.getAllExpenses();
      final expense = expenses.firstWhere((expense) => expense.id == id);
      return Result.success(expense);
    } catch (e) {
      return Result.success(null);
    }
  }

  @override
  Future<Result<void>> saveExpense(Expense expense) async {
    try {
      await dataSource.saveExpense(expense);
      return Result.success(null);
    } catch (e) {
      return Result.failure(Exception('${AppStrings.failedToSaveExpense}: $e'));
    }
  }

  @override
  Future<Result<void>> deleteExpense(Expense expense) async {
    try {
      await dataSource.deleteExpense(expense.id);
      return Result.success(null);
    } catch (e) {
      return Result.failure(
          Exception('${AppStrings.failedToDeleteExpense}: $e'));
    }
  }

  @override
  Future<Result<List<Expense>>> getExpensesByDate(DateTime date) async {
    try {
      final expenses = await dataSource.getExpensesByDate(date);
      return Result.success(expenses);
    } catch (e) {
      return Result.failure(
          Exception('${AppStrings.failedToLoadExpensesByDate}: $e'));
    }
  }

  @override
  Future<Result<List<Expense>>> getExpensesByCategory(Category category) async {
    try {
      final expenses = await dataSource.getExpensesByCategory(category);
      return Result.success(expenses);
    } catch (e) {
      return Result.failure(
          Exception('${AppStrings.failedToLoadExpensesByCategory}: $e'));
    }
  }

  @override
  Future<Result<double>> getTotalAmount() async {
    try {
      final expenses = await dataSource.getAllExpenses();
      final total =
          expenses.fold<double>(0.0, (sum, expense) => sum + expense.amount);
      return Result.success(total);
    } catch (e) {
      return Result.failure(
          Exception('${AppStrings.failedToCalculateTotalAmount}: $e'));
    }
  }
}
