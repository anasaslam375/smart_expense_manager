import 'package:flutter/material.dart';
import 'package:smart_expense_manager/core/constants/app_constants.dart';
import 'package:smart_expense_manager/core/constants/app_colors.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';
import 'package:smart_expense_manager/presentation/shared/widgets/category_icon.dart';
import 'package:smart_expense_manager/core/extensions/double_extensions.dart';
import 'package:smart_expense_manager/core/extensions/date_time_extensions.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMedium),
      child: Dismissible(
        key: Key(expense.id),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDelete(),
        background: Container(
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius:
                BorderRadius.circular(AppConstants.borderRadiusMedium),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: AppConstants.spacingExtraLarge),
          child: const Icon(
            AppIcons.delete,
            color: AppColors.white,
            size: AppConstants.deleteIconSize,
          ),
        ),
        child: Card(
          elevation: AppConstants.elevationSmall,
          child: InkWell(
            borderRadius:
                BorderRadius.circular(AppConstants.borderRadiusMedium),
            onTap: () => _showExpenseDetails(context),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingLarge),
              child: Row(
                children: [
                  _buildCategoryIcon(),
                  const SizedBox(width: AppConstants.spacingLarge),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.category.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.titleFontSize,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingSmall),
                        if (expense.note != null && expense.note!.isNotEmpty)
                          Text(
                            expense.note!,
                            style: const TextStyle(
                              color: AppColors.grey600,
                              fontSize: AppConstants.bodyFontSize,
                            ),
                            maxLines: AppConstants.maxLinesOne,
                            overflow: TextOverflow.ellipsis,
                          ),
                        const SizedBox(height: AppConstants.spacingSmall),
                        Text(
                          expense.date.toFormattedDate(),
                          style: const TextStyle(
                            color: AppColors.grey500,
                            fontSize: AppConstants.captionFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        expense.amount.toCurrency(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstants.amountFontSize,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingSmall),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingSmall,
                          vertical: AppConstants.spacingSmall,
                        ),
                        decoration: BoxDecoration(
                          color: CategoryIcon.parseColor(expense.category.color)
                              .withValues(alpha: AppConstants.alpha20),
                          borderRadius: BorderRadius.circular(
                              AppConstants.smallBorderRadius),
                        ),
                        child: Text(
                          expense.category.icon,
                          style: const TextStyle(
                              fontSize: AppConstants.titleFontSize),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryIcon() {
    return CategoryIcon(
      category: expense.category,
      size: AppConstants.iconBoxSize,
      iconSize: AppConstants.largeIconFontSize,
    );
  }

  void _showExpenseDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppConstants.borderRadiusLarge)),
        ),
        padding: const EdgeInsets.all(AppConstants.spacingExtraLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: AppConstants.handleBarWidth,
                height: AppConstants.handleBarHeight,
                margin:
                    const EdgeInsets.only(bottom: AppConstants.spacingLarge),
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius:
                      BorderRadius.circular(AppConstants.tinyBorderRadius),
                ),
              ),
            ),
            Row(
              children: [
                CategoryIcon(
                  category: expense.category,
                  size: AppConstants.detailIconBoxSize,
                  iconSize: AppConstants.hugeIconFontSize,
                ),
                const SizedBox(width: AppConstants.spacingLarge),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expense.category.name,
                        style: const TextStyle(
                          fontSize: AppConstants.detailTitleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        expense.date.toFormattedDate(),
                        style: const TextStyle(
                          color: AppColors.grey600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingExtraLarge),
            Text(
              expense.amount.toCurrency(),
              style: const TextStyle(
                fontSize: AppConstants.detailAmountFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            if (expense.note != null && expense.note!.isNotEmpty) ...[
              const Text(
                AppStrings.noteLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.titleFontSize,
                ),
              ),
              const SizedBox(height: AppConstants.spacingSmall),
              Text(
                expense.note!,
                style: const TextStyle(
                  color: AppColors.grey600,
                  fontSize: AppConstants.bodyFontSize,
                ),
              ),
              const SizedBox(height: AppConstants.spacingLarge),
            ],
            const SizedBox(height: AppConstants.spacingLarge),
          ],
        ),
      ),
    );
  }
}
