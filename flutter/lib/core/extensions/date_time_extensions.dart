import 'package:smart_expense_manager/core/utils/date_formatter.dart';

extension DateTimeExtensions on DateTime {
  String toFormattedDate() {
    return DateFormatter.format(this);
  }
}
