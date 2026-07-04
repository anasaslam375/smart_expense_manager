import 'package:smart_expense_manager/core/utils/currency_formatter.dart';

extension DoubleExtensions on double {
  String toCurrency() {
    return CurrencyFormatter.format(this);
  }
}
