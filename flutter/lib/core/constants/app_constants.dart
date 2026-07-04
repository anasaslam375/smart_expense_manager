import 'package:flutter/material.dart';

/// App-wide constants for UI components
class AppConstants {
  // Animation durations
  static const Duration fabAnimationDuration = Duration(milliseconds: 300);
  static const Duration listAnimationDuration = Duration(milliseconds: 600);
  static const Duration chipAnimationDuration = Duration(milliseconds: 200);

  // Layout dimensions
  static const double appBarExpandedHeight = 200;
  static const double categoryFilterHeight = 50;
  static const double loadingItemHeight = 80;
  static const double loadingItemCount = 5;
  static const double emptyStateIconSize = 100;
  static const double errorStateIconSize = 64;

  // Spacing
  static const double spacingSmall = 8;
  static const double spacingMedium = 12;
  static const double spacingLarge = 16;
  static const double spacingExtraLarge = 24;
  static const double spacingTiny = 6;

  // Border radius
  static const double borderRadiusMedium = 16;
  static const double borderRadiusLarge = 24;
  static const double chipBorderRadius = 20;
  static const double smallBorderRadius = 8;
  static const double tinyBorderRadius = 2;

  // Text styles
  static const double totalAmountFontSize = 48;
  static const double totalSpentFontSize = 16;
  static const double chipIconFontSize = 16;
  static const double titleFontSize = 16;
  static const double bodyFontSize = 14;
  static const double captionFontSize = 12;
  static const double amountFontSize = 18;
  static const double headerFontSize = 24;
  static const double buttonFontSize = 18;
  static const double largeIconFontSize = 24;
  static const double extraLargeIconFontSize = 28;
  static const double hugeIconFontSize = 32;
  static const double detailAmountFontSize = 36;
  static const double detailTitleFontSize = 20;
  static const double categoryGridIconSize = 28;
  static const double categoryGridTextSize = 10;

  // Dimensions
  static const double iconBoxSize = 50;
  static const double detailIconBoxSize = 60;
  static const double handleBarWidth = 40;
  static const double handleBarHeight = 4;
  static const double deleteIconSize = 28;
  static const double categoryGridHeight = 100;
  static const double buttonHeight = 56;
  static const int categoryGridCrossAxisCount = 3;
  static const double totalCardPadding = 20;
  static const double totalCardCornerRadius = 20;
  static const double totalCardBlurRadius = 10;
  static const double totalCardOffsetY = 5;
  static const double totalCardLabelFontSize = 14;
  static const double totalCardAmountFontSize = 32;

  // Elevation
  static const double elevationNone = 0;
  static const double elevationSmall = 2;
  static const double elevationMedium = 4;
  static const double elevationLarge = 8;

  // Text constraints
  static const int maxLinesOne = 1;
  static const int maxLinesThree = 3;

  // Border
  static const double borderWidth = 2;

  // Animation
  static const double animationBegin = 0;
  static const double animationEnd = 1;
  static const double animationOffsetX = 1;
  static const double animationOffsetY = 0;

  // Grid
  static const double childAspectRatio = 1;

  // Alpha values
  static const double alpha20 = 0.2;
  static const double alpha30 = 0.3;

  // Regex patterns
  static const String amountInputPattern = r'^\d*\.?\d{0,2}';

  // API endpoints
  static const String httpsPrefix = 'https://';

  // Validation thresholds
  static const double maxAmount = 1000000.00;
  static const int maxNoteLength = 500;
  static const int maxCategoryNameLength = 50;
  static const int minCategoryNameLength = 1;
}

/// App-wide text constants
class AppStrings {
  // App bar
  static const String appTitle = 'My Expenses';
  static const String totalSpent = 'Total Spent';

  // Empty state
  static const String noExpensesYet = 'No expenses yet';
  static const String tapToAddExpense =
      'Tap the + button to add your first expense';

  // Error state
  static const String retry = 'Retry';

  // Actions
  static const String addExpense = 'Add Expense';
  static const String deleteExpense = 'Delete Expense';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';

  // Dialogs
  static const String deleteConfirmation =
      'Are you sure you want to delete this expense of \$';
  static const String deleteConfirmationSuffix = '?';

  // Filter
  static const String all = 'All';

  // Form labels
  static const String addNewExpense = 'Add New Expense';
  static const String amount = 'Amount';
  static const String category = 'Category';
  static const String date = 'Date';
  static const String note = 'Note (Optional)';
  static const String addANote = 'Add a note...';
  static const String pleaseEnterAmount = 'Please enter an amount';
  static const String pleaseEnterValidAmount = 'Please enter a valid amount';
  static const String pleaseSelectCategory = 'Please select a category';

  // Date format
  static const String today = 'Today';
  static const String yesterday = 'Yesterday';
  static const String daysAgo = ' days ago';
  static const String noteLabel = 'Note';

  // Error messages
  static const String failedToLoadExpenses = 'Failed to load expenses';
  static const String failedToSaveExpense = 'Failed to save expense';
  static const String failedToDeleteExpense = 'Failed to delete expense';
  static const String failedToLoadExpensesByDate =
      'Failed to load expenses by date';
  static const String failedToLoadExpensesByCategory =
      'Failed to load expenses by category';
  static const String failedToCalculateTotalAmount =
      'Failed to calculate total amount';

  // Format
  static const String currencySymbol = '\$';
  static const String amountPlaceholder = '0.00';
  static const int minDateYear = 2020;
}

/// App-wide icon constants
class AppIcons {
  static const IconData emptyState = Icons.receipt_long;
  static const IconData errorState = Icons.error_outline;
  static const IconData add = Icons.add;
  static const IconData delete = Icons.delete;
  static const IconData calendar = Icons.calendar_today;
}
