package com.smartexpense.manager.presentation.constants

import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

/// App-wide constants for UI components
object AppConstants {
    // Layout dimensions
    val cardPadding = 16.dp
    val cardInnerPadding = 20.dp
    val cardCornerRadius = 20.dp
    val itemCornerRadius = 16.dp
    val iconBoxCornerRadius = 12.dp
    val categoryFilterHeight = 40.dp
    val iconBoxSize = 50.dp
    val deleteIconSize = 32.dp
    val deleteIconInnerSize = 20.dp
    val bottomSheetPadding = 16.dp
    val bottomSheetCornerRadius = 20.dp
    val bottomSheetInnerPadding = 24.dp
    val categoryChipHeight = 40.dp

    // Spacing
    val spacingSmall = 8.dp
    val spacingMedium = 12.dp
    val spacingLarge = 16.dp
    val spacingExtraLarge = 20.dp

    // Elevation
    val cardElevation = 2.dp

    // Typography - Font sizes
    val displayLargeFontSize = 57.sp
    val displayMediumFontSize = 45.sp
    val displaySmallFontSize = 36.sp
    val headlineLargeFontSize = 32.sp
    val headlineMediumFontSize = 28.sp
    val headlineSmallFontSize = 24.sp
    val titleLargeFontSize = 22.sp
    val titleMediumFontSize = 16.sp
    val titleSmallFontSize = 14.sp
    val bodyLargeFontSize = 16.sp
    val bodyMediumFontSize = 14.sp
    val bodySmallFontSize = 12.sp
    val labelLargeFontSize = 14.sp
    val labelMediumFontSize = 12.sp
    val labelSmallFontSize = 11.sp

    // Typography - Line heights
    val displayLargeLineHeight = 64.sp
    val displayMediumLineHeight = 52.sp
    val displaySmallLineHeight = 44.sp
    val headlineLargeLineHeight = 40.sp
    val headlineMediumLineHeight = 36.sp
    val headlineSmallLineHeight = 32.sp
    val titleLargeLineHeight = 28.sp
    val titleMediumLineHeight = 24.sp
    val titleSmallLineHeight = 20.sp
    val bodyLargeLineHeight = 24.sp
    val bodyMediumLineHeight = 20.sp
    val bodySmallLineHeight = 16.sp
    val labelLargeLineHeight = 20.sp
    val labelMediumLineHeight = 16.sp
    val labelSmallLineHeight = 16.sp

    // Typography - Letter spacing
    val letterSpacingNone = 0.sp
    val letterSpacingTight = 0.1.sp
    val letterSpacingNormal = 0.15.sp
    val letterSpacingWide = 0.25.sp
    val letterSpacingWider = 0.4.sp
    val letterSpacingWidest = 0.5.sp

    // Alpha values
    val alpha20 = 0.2f
    val alpha50 = 0.5f
    val alpha60 = 0.6f
    val alpha70 = 0.7f

    // Text constraints
    val maxLinesOne = 1
    val maxLinesThree = 3

    // Time calculations
    val millisecondsPerSecond = 1000
    val secondsPerMinute = 60
    val minutesPerHour = 60
    val hoursPerDay = 24
    val millisecondsPerDay = millisecondsPerSecond * secondsPerMinute * minutesPerHour * hoursPerDay

    // Network timeouts
    val networkTimeoutSeconds = 30

    // API endpoints
    const val BASE_URL = "https://api.smartexpense.com/"
    const val HTTPS_PREFIX = "https://"

    // Database
    const val DATABASE_VERSION = 1

    // Date formats
    const val DATE_FORMAT = "dd/MM/yyyy"

    // Validation thresholds
    const val MAX_AMOUNT = 1000000.00
    const val MAX_NOTE_LENGTH = 500
    const val MAX_CATEGORY_NAME_LENGTH = 50
    const val MIN_CATEGORY_NAME_LENGTH = 1
}

/// App-wide string constants
object AppStrings {
    // App bar
    const val APP_TITLE = "My Expenses"
    const val TOTAL_SPENT = "Total Spent"

    // Actions
    const val ADD_EXPENSE = "Add Expense"
    const val DELETE_EXPENSE = "Delete Expense"
    const val DELETE = "Delete"
    const val CANCEL = "Cancel"
    const val RETRY = "Retry"

    // Filter
    const val ALL = "All"

    // Empty state
    const val NO_EXPENSES_YET = "No expenses yet"
    const val TAP_TO_ADD_EXPENSE = "Tap the + button to add your first expense"

    // Dialogs
    const val DELETE_CONFIRMATION = "Are you sure you want to delete this expense of $"
    const val DELETE_CONFIRMATION_SUFFIX = "?"

    // Format
    const val CURRENCY_SYMBOL = "$"
    const val AMOUNT_PLACEHOLDER = "0.00"

    // Form labels
    const val AMOUNT = "Amount"
    const val CATEGORY = "Category"
    const val NOTE_OPTIONAL = "Note (optional)"

    // Date format
    const val TODAY = "Today"
    const val YESTERDAY = "Yesterday"

    // Error messages
    const val UNKNOWN_ERROR = "Unknown error"
    const val FAILED_TO_SAVE_EXPENSE = "Failed to save expense"
    const val FAILED_TO_DELETE_EXPENSE = "Failed to delete expense"

    // Navigation routes
    const val ROUTE_EXPENSE_LIST = "expense_list"
}
