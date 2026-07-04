import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_manager/core/constants/app_constants.dart';
import 'package:smart_expense_manager/core/constants/app_colors.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';
import 'package:smart_expense_manager/presentation/features/expense/bloc/expense_bloc.dart';
import 'package:smart_expense_manager/presentation/features/expense/bloc/expense_event.dart';
import 'package:smart_expense_manager/presentation/features/expense/bloc/expense_state.dart';
import 'package:smart_expense_manager/presentation/features/expense/widgets/add_expense_bottom_sheet.dart';
import 'package:smart_expense_manager/presentation/features/expense/widgets/expense_card.dart';
import 'package:smart_expense_manager/presentation/features/expense/widgets/category_filter_chip.dart';
import 'package:smart_expense_manager/presentation/shared/widgets/delete_confirmation_dialog.dart';
import 'package:smart_expense_manager/core/extensions/double_extensions.dart';

class ExpenseListPage extends StatefulWidget {
  const ExpenseListPage({super.key});

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage>
    with TickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late AnimationController _listAnimationController;
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: AppConstants.fabAnimationDuration,
    );
    _listAnimationController = AnimationController(
      vsync: this,
      duration: AppConstants.listAnimationDuration,
    );
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _listAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          _buildContent(context),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: AppConstants.appBarExpandedHeight,
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          AppStrings.appTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
          child: Center(
            child: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                if (state is ExpenseLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        AppStrings.totalSpent,
                        style: TextStyle(
                          color: AppColors.white70,
                          fontSize: AppConstants.totalSpentFontSize,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingSmall),
                      Text(
                        state.totalAmount.toCurrency(),
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: AppConstants.totalAmountFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryFilter(context),
            const SizedBox(height: AppConstants.spacingLarge),
            BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                if (state is ExpenseLoading) {
                  return _buildLoadingState();
                } else if (state is ExpenseLoaded) {
                  if (state.expenses.isEmpty) {
                    return _buildEmptyState(context);
                  }
                  return _buildExpenseList(state.expenses);
                } else if (state is ExpenseError) {
                  return _buildErrorState(state.message);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    return SizedBox(
      height: AppConstants.categoryFilterHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Category.defaultCategories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return CategoryFilterChip(
              category: null,
              isSelected: _selectedCategory == null,
              onTap: () {
                setState(() {
                  _selectedCategory = null;
                });
                context.read<ExpenseBloc>().add(LoadExpenses());
              },
            );
          }
          final category = Category.defaultCategories[index - 1];
          return CategoryFilterChip(
            category: category,
            isSelected: _selectedCategory?.id == category.id,
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
              context.read<ExpenseBloc>().add(LoadExpensesByCategory(category));
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppConstants.loadingItemCount.toInt(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.spacingMedium),
          height: AppConstants.loadingItemHeight,
          decoration: BoxDecoration(
            color: AppColors.grey200,
            borderRadius:
                BorderRadius.circular(AppConstants.borderRadiusMedium),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            AppIcons.emptyState,
            size: AppConstants.emptyStateIconSize,
            color: AppColors.grey400,
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          Text(
            AppStrings.noExpensesYet,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          Text(
            AppStrings.tapToAddExpense,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.grey600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseList(List<Expense> expenses) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return AnimatedBuilder(
          animation: _listAnimationController,
          builder: (context, child) {
            final slideAnimation = Tween<Offset>(
              begin: const Offset(
                  AppConstants.animationOffsetX, AppConstants.animationOffsetY),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _listAnimationController,
              curve: Interval(
                index / expenses.length,
                (index + 1) / expenses.length,
                curve: Curves.easeOut,
              ),
            ));
            return SlideTransition(
              position: slideAnimation,
              child: child,
            );
          },
          child: ExpenseCard(
            expense: expense,
            onDelete: () {
              HapticFeedback.heavyImpact();
              _showDeleteConfirmationDialog(expense);
            },
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            AppIcons.errorState,
            size: AppConstants.errorStateIconSize,
            color: AppColors.red,
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          Text(
            message,
            style: const TextStyle(color: AppColors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          ElevatedButton(
            onPressed: () {
              context.read<ExpenseBloc>().add(LoadExpenses());
            },
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _fabAnimationController,
          curve: Curves.elasticOut,
        ),
      ),
      child: FloatingActionButton.extended(
        onPressed: () => _showAddExpenseBottomSheet(context),
        icon: const Icon(AppIcons.add),
        label: const Text(AppStrings.addExpense),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: AppColors.white,
      ),
    );
  }

  void _showAddExpenseBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (context) => AddExpenseBottomSheet(
        onExpenseAdded: (amount, category, date, note) {
          context.read<ExpenseBloc>().add(
                AddExpense(
                  amount: amount,
                  category: category,
                  date: date,
                  note: note,
                ),
              );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(Expense expense) {
    DeleteConfirmationDialog.show(
      context: context,
      title: AppStrings.deleteExpense,
      content:
          '${AppStrings.deleteConfirmation}${expense.amount.toCurrency()}${AppStrings.deleteConfirmationSuffix}',
    ).then((confirmed) {
      if (confirmed == true && mounted) {
        context.read<ExpenseBloc>().add(DeleteExpense(expense));
      }
    });
  }
}
