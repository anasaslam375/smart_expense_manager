import 'package:flutter/material.dart';
import 'package:smart_expense_manager/core/constants/app_constants.dart';
import 'package:smart_expense_manager/core/constants/app_colors.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';

class CategoryFilterChip extends StatelessWidget {
  final Category? category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryFilterChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppConstants.spacingSmall),
      child: AnimatedContainer(
        duration: AppConstants.chipAnimationDuration,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : AppColors.grey200,
          borderRadius: BorderRadius.circular(AppConstants.chipBorderRadius),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : AppColors.grey300,
            width: AppConstants.borderWidth,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.chipBorderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingLarge,
                vertical: AppConstants.spacingSmall),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (category != null) ...[
                  Text(
                    category!.icon,
                    style: const TextStyle(
                        fontSize: AppConstants.chipIconFontSize),
                  ),
                  const SizedBox(width: AppConstants.spacingTiny),
                ],
                Text(
                  category?.name ?? AppStrings.all,
                  style: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.grey700,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
