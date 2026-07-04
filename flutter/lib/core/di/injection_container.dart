import 'package:hive/hive.dart';
import 'package:smart_expense_manager/data/datasources/expense_local_datasource.dart';
import 'package:smart_expense_manager/data/repositories/expense_repository_impl.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';
import 'package:smart_expense_manager/domain/repositories/expense_repository.dart';
import 'package:smart_expense_manager/domain/usecases/delete_expense.dart';
import 'package:smart_expense_manager/domain/usecases/get_expenses.dart';
import 'package:smart_expense_manager/domain/usecases/save_expense.dart';

/// Simple dependency injection container following best practices
/// - Single responsibility: each getter handles one concern
/// - Lazy loading: dependencies are instantiated only when needed
/// - Clear lifecycle management: singleton vs factory
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  ExpenseLocalDataSource? _expenseLocalDataSource;
  ExpenseRepository? _expenseRepository;

  // Datasources (Singleton)
  ExpenseLocalDataSource get expenseLocalDataSource {
    _expenseLocalDataSource ??= ExpenseLocalDataSource(
      Hive.box<Expense>('expenses'),
    );
    return _expenseLocalDataSource!;
  }

  // Repositories (Singleton)
  ExpenseRepository get expenseRepository {
    _expenseRepository ??= ExpenseRepositoryImpl(
      expenseLocalDataSource,
    );
    return _expenseRepository!;
  }

  // Use cases (Factory - new instance each time)
  GetExpenses getGetExpenses() {
    return GetExpenses(expenseRepository);
  }

  SaveExpense getSaveExpense() {
    return SaveExpense(expenseRepository);
  }

  DeleteExpense getDeleteExpense() {
    return DeleteExpense(expenseRepository);
  }

  // Reset for testing
  void reset() {
    _expenseLocalDataSource = null;
    _expenseRepository = null;
  }
}

// Global instance
final sl = ServiceLocator();
