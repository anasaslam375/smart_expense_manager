# ADR-004: Component Refactoring with Extensions

## Status

Accepted

## Context

During the development of the SmartExpenseManager application, we identified significant code duplication across the Flutter, Android, and iOS platforms:

1. **UI Component Duplication**: Similar UI patterns (empty states, error states, dialogs) were implemented multiple times across different screens
2. **Business Logic Duplication**: Common operations like currency formatting, date formatting, and color parsing were duplicated across files
3. **Hardcoded Values**: Magic numbers, string literals, and color values were scattered throughout the codebase
4. **Inconsistent Implementation**: Similar functionality was implemented differently across platforms, making maintenance difficult

This duplication led to:

- Increased maintenance burden
- Inconsistent user experience
- Higher risk of bugs
- Difficulty in implementing changes across platforms
- Reduced code readability

## Decision

We decided to implement a comprehensive refactoring strategy focused on:

### 1. Reusable UI Components

Extract duplicated UI patterns into reusable components:

**Flutter:**

- `CategoryIcon` widget for consistent category icon rendering
- `DeleteConfirmationDialog` widget for delete confirmations

**Android:**

- `EmptyState` composable for empty expense list UI
- `ErrorState` composable for error UI with retry button

**iOS:**

- `EmptyStateView` component for empty expense UI
- `AlertView` modifier for standardized alert presentation

### 2. Centralized Business Logic Utilities

Create utility classes for common operations:

**Flutter:**

- `CurrencyFormatter` for consistent currency formatting
- `DateFormatter` for consistent date formatting

**Android:**

- `CurrencyFormatter` for consistent currency formatting
- `DateFormatter` for consistent date formatting
- `ColorParser` for consistent color parsing

**iOS:**

- `CurrencyFormatter` for consistent currency formatting

### 3. Extension Methods

Create platform-specific extension methods for idiomatic API:

**Flutter:**

- `DoubleExtensions.toCurrency()` for currency formatting
- `DateTimeExtensions.toFormattedDate()` for date formatting

**Android:**

- `Double.toCurrency()` extension for currency formatting
- `Date.toFormattedDate()` extension for date formatting

**iOS:**

- `Double.toCurrency()` extension for currency formatting

### 4. Constants Extraction

Extract all hardcoded values to constants:

- Currency symbol constants across all platforms
- Animation offset constants
- All color values to AppColors
- All dimensions to AppConstants
- All string literals to AppStrings

## Consequences

### Positive

- **Reduced Duplication**: Eliminated code duplication across platforms
- **Improved Maintainability**: Changes to UI patterns or business logic now require updates in one place
- **Consistent User Experience**: UI components behave consistently across platforms
- **Better Code Readability**: Extension methods provide clean, idiomatic API
- **Easier Testing**: Centralized logic is easier to test
- **Type Safety**: Extension methods provide compile-time safety
- **Platform-Appropriate**: Each platform uses its idiomatic approach (extensions in Kotlin/Swift/Dart)

### Negative

- **Initial Refactoring Effort**: Required significant time to identify and extract duplicated code
- **Learning Curve**: Team needs to understand the new component structure
- **File Count Increase**: More files due to component extraction (though each is smaller and focused)

### Neutral

- **Similar Architecture**: All platforms now follow similar patterns for component organization
- **Import Changes**: Existing code needed to be updated to use new components and extensions

## Implementation Details

### File Organization

```text
flutter/lib/
├── core/
│   ├── extensions/
│   │   ├── double_extensions.dart
│   │   └── date_time_extensions.dart
│   ├── utils/
│   │   ├── currency_formatter.dart
│   │   └── date_formatter.dart
│   └── constants/
│       ├── app_constants.dart
│       └── app_colors.dart
└── presentation/shared/widgets/
    ├── category_icon.dart
    └── delete_confirmation_dialog.dart

android_native/app/src/main/java/com/smartexpense/manager/
├── presentation/
│   ├── extensions/
│   │   ├── DoubleExtensions.kt
│   │   └── DateExtensions.kt
│   ├── utils/
│   │   ├── CurrencyFormatter.kt
│   │   ├── DateFormatter.kt
│   │   └── ColorParser.kt
│   └── shared/components/
│       ├── EmptyState.kt
│       └── ErrorState.kt
└── constants/
    ├── AppConstants.kt
    └── AppColors.kt

ios_native/SmartExpenseManager/SmartExpenseManager/
├── Presentation/
│   ├── Extensions/
│   │   └── DoubleExtensions.swift
│   ├── Utils/
│   │   └── CurrencyFormatter.swift
│   └── Shared/Views/
│       ├── EmptyStateView.swift
│       └── AlertView.swift
└── Presentation/Constants/
    ├── AppConstants.swift
    └── AppColors.swift
```

### Usage Examples

**Before (Flutter):**

```dart
Text('\$${amount.toStringAsFixed(2)}')
```

**After (Flutter):**

```dart
Text(amount.toCurrency())
```

**Before (Android):**

```kotlin
Text("\$${String.format("%.2f", amount)}")
```

**After (Android):**

```kotlin
Text(amount.toCurrency())
```

**Before (iOS):**

```swift
Text(String(format: "$%.2f", amount))
```

**After (iOS):**

```swift
Text(amount.toCurrency())
```

## References

- [ADR-001: Clean Architecture](./ADR-001-clean-architecture.md)
- [ADR-002: SwiftUI Adoption](./ADR-002-swiftui-adoption.md)
- [05-Mobile-Engineering-Standards.md](../05-Mobile-Engineering-Standards.md)
