import 'package:flutter/material.dart';
import 'package:smart_expense_manager/core/constants/app_constants.dart';
import 'package:smart_expense_manager/core/constants/app_colors.dart';
import 'package:smart_expense_manager/core/extensions/double_extensions.dart';

class TotalAmountCard extends StatelessWidget {
  final double totalAmount;

  const TotalAmountCard({
    super.key,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.totalCardPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.totalCardCornerRadius),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withValues(alpha: AppConstants.alpha30),
            blurRadius: AppConstants.totalCardBlurRadius,
            offset: const Offset(0, AppConstants.totalCardOffsetY),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.totalSpent,
            style: TextStyle(
              color: AppColors.white70,
              fontSize: AppConstants.totalCardLabelFontSize,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          Text(
            totalAmount.toCurrency(),
            style: const TextStyle(
              color: AppColors.white,
              fontSize: AppConstants.totalCardAmountFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
