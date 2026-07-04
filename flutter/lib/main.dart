import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_expense_manager/core/di/injection_container.dart';
import 'package:smart_expense_manager/core/theme/app_theme.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';
import 'package:smart_expense_manager/presentation/features/expense/bloc/expense_bloc.dart';
import 'package:smart_expense_manager/presentation/features/expense/bloc/expense_event.dart';
import 'package:smart_expense_manager/presentation/features/expense/pages/expense_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(CategoryAdapter());

  runApp(const SmartExpenseManagerApp());
}

class SmartExpenseManagerApp extends StatelessWidget {
  const SmartExpenseManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => sl.expenseRepository,
      child: BlocProvider(
        create: (context) {
          return ExpenseBloc(
            getExpenses: sl.getGetExpenses(),
            saveExpense: sl.getSaveExpense(),
            deleteExpense: sl.getDeleteExpense(),
          )..add(LoadExpenses());
        },
        child: MaterialApp(
          title: 'Smart Expense Manager',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const ExpenseListPage(),
        ),
      ),
    );
  }
}
