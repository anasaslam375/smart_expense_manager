import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';
import 'package:smart_expense_manager/domain/usecases/delete_expense.dart'
    as usecases;
import 'package:smart_expense_manager/domain/usecases/get_expenses.dart';
import 'package:smart_expense_manager/domain/usecases/save_expense.dart';
import 'package:smart_expense_manager/presentation/features/expense/bloc/expense_event.dart';
import 'package:smart_expense_manager/presentation/features/expense/bloc/expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetExpenses getExpenses;
  final SaveExpense saveExpense;
  final usecases.DeleteExpense deleteExpense;

  ExpenseBloc({
    required this.getExpenses,
    required this.saveExpense,
    required this.deleteExpense,
  }) : super(ExpenseInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<LoadExpensesByDate>(_onLoadExpensesByDate);
    on<LoadExpensesByCategory>(_onLoadExpensesByCategory);
    on<AddExpense>(_onAddExpense);
    on<DeleteExpense>(_onDeleteExpense);
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    final result = await getExpenses();
    result.fold(
      (expenses) {
        final totalAmount =
            expenses.fold<double>(0, (sum, e) => sum + e.amount);
        emit(ExpenseLoaded(expenses, totalAmount));
      },
      (error) => emit(ExpenseError(error.toString())),
    );
  }

  Future<void> _onLoadExpensesByDate(
    LoadExpensesByDate event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    final result = await getExpenses.callByDate(event.date);
    result.fold(
      (expenses) {
        final totalAmount =
            expenses.fold<double>(0, (sum, e) => sum + e.amount);
        emit(ExpenseLoaded(expenses, totalAmount));
      },
      (error) => emit(ExpenseError(error.toString())),
    );
  }

  Future<void> _onLoadExpensesByCategory(
    LoadExpensesByCategory event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseLoading());
    final result = await getExpenses.callByCategory(event.category);
    result.fold(
      (expenses) {
        final totalAmount =
            expenses.fold<double>(0, (sum, e) => sum + e.amount);
        emit(ExpenseLoaded(expenses, totalAmount));
      },
      (error) => emit(ExpenseError(error.toString())),
    );
  }

  Future<void> _onAddExpense(
    AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseSaving());
    final expense = Expense(
      amount: event.amount,
      category: event.category,
      date: event.date,
      note: event.note,
    );
    final result = await saveExpense(expense);
    result.fold(
      (_) {
        emit(ExpenseSaved());
        add(LoadExpenses());
      },
      (error) => emit(ExpenseError(error.toString())),
    );
  }

  Future<void> _onDeleteExpense(
    DeleteExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(ExpenseDeleting());
    final result = await deleteExpense(event.expense);
    result.fold(
      (_) {
        emit(ExpenseDeleted());
        add(LoadExpenses());
      },
      (error) => emit(ExpenseError(error.toString())),
    );
  }
}
