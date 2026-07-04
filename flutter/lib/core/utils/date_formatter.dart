import 'package:smart_expense_manager/core/constants/app_constants.dart';

class DateFormatter {
  static String format(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return AppStrings.today;
    } else if (difference.inDays == 1) {
      return AppStrings.yesterday;
    } else if (difference.inDays < 7) {
      return '${difference.inDays}${AppStrings.daysAgo}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
