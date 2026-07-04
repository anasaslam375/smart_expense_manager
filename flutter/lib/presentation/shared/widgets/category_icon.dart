import 'package:flutter/material.dart';
import 'package:smart_expense_manager/core/constants/app_constants.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';

class CategoryIcon extends StatelessWidget {
  final Category category;
  final double size;
  final double iconSize;

  const CategoryIcon({
    super.key,
    required this.category,
    this.size = AppConstants.iconBoxSize,
    this.iconSize = AppConstants.largeIconFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color:
            _parseColor(category.color).withValues(alpha: AppConstants.alpha20),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      child: Center(
        child: Text(
          category.icon,
          style: TextStyle(fontSize: iconSize),
        ),
      ),
    );
  }

  Color _parseColor(String colorString) {
    return Color(int.parse(colorString.replaceFirst('#', '0xFF')));
  }

  static Color parseColor(String colorString) {
    return Color(int.parse(colorString.replaceFirst('#', '0xFF')));
  }
}
