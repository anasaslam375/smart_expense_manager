import 'package:equatable/equatable.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  final double totalAmount;

  const ExpenseLoaded(this.expenses, this.totalAmount);

  @override
  List<Object?> get props => [expenses, totalAmount];
}

class ExpenseError extends ExpenseState {
  final String message;

  const ExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}

class ExpenseSaving extends ExpenseState {}

class ExpenseSaved extends ExpenseState {}

class ExpenseDeleting extends ExpenseState {}

class ExpenseDeleted extends ExpenseState {}
