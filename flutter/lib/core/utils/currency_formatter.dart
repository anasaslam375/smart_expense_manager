import 'package:smart_expense_manager/core/constants/app_constants.dart';

class CurrencyFormatter {
  static String format(double amount) {
    return '${AppStrings.currencySymbol}${amount.toStringAsFixed(2)}';
  }
}
