import 'package:equatable/equatable.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpenseEvent {}

class LoadExpensesByDate extends ExpenseEvent {
  final DateTime date;

  const LoadExpensesByDate(this.date);

  @override
  List<Object?> get props => [date];
}

class LoadExpensesByCategory extends ExpenseEvent {
  final Category category;

  const LoadExpensesByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class AddExpense extends ExpenseEvent {
  final double amount;
  final Category category;
  final DateTime date;
  final String? note;

  const AddExpense({
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  });

  @override
  List<Object?> get props => [amount, category, date, note];
}

class DeleteExpense extends ExpenseEvent {
  final Expense expense;

  const DeleteExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}
