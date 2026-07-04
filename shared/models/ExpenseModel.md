# Expense Model Specification

## Overview

The Expense model is the core data structure used across all platforms. This specification defines the contract that all platform implementations must follow.

## Data Structure

### Expense

| Field | Type | Required | Description | Validation |
|-------|------|----------|-------------|------------|
| id | String | Yes | Unique identifier | UUID v4 format |
| amount | Double | Yes | Expense amount | > 0, max 2 decimal places |
| category | Category | Yes | Expense category | Must be valid category |
| date | DateTime | Yes | Expense date | Not in future |
| note | String? | No | Optional note | Max 500 characters |
| receiptUrl | String? | No | Receipt image URL | Valid URL if present |
| createdAt | DateTime | Yes | Creation timestamp | Auto-generated |
| updatedAt | DateTime | Yes | Last update timestamp | Auto-generated |

### Category

| Field | Type | Required | Description | Validation |
|-------|------|----------|-------------|------------|
| id | String | Yes | Unique identifier | UUID v4 format |
| name | String | Yes | Category name | 1-50 characters |
| icon | String | Yes | Emoji icon | Single emoji character |
| color | String | Yes | Hex color code | Valid hex format (#RRGGBB) |

### Default Categories

All platforms must support these default categories with exact values:

- Food - 🍔 - #FF6B6B
- Transport - 🚗 - #4ECDC4
- Shopping - 🛍️ - #45B7D1
- Entertainment - 🎬 - #96CEB4
- Bills - 📄 - #FFEAA7
- Health - ❤️ - #DDA0DD
- Education - 📚 - #98D8C8
- Travel - ✈️ - #F7DC6F
- Other - 📦 - #95A5A6

## Platform Implementations

### Flutter (Dart)

```dart
class Expense {
  final String id;
  final double amount;
  final Category category;
  final DateTime date;
  final String? note;
  final String? receiptUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Immutable with copyWith pattern
  // Hive annotations for persistence
}
```

### iOS (Swift)

```swift
struct Expense: Identifiable, Codable {
  let id: UUID
  let amount: Double
  let category: Category
  let date: Date
  let note: String?
  let receiptUrl: URL?
  let createdAt: Date
  let updatedAt: Date
  
  // SwiftData persistence
}
```

### Android (Kotlin)

```kotlin
data class Expense(
  val id: String,
  val amount: Double,
  val category: Category,
  val date: Date,
  val note: String?,
  val receiptUrl: String?,
  val createdAt: Date,
  val updatedAt: Date
) // Room entity with proper converters
```

## Validation Rules

- **Amount**: Must be positive, maximum 2 decimal places
- **Date**: Cannot be in the future
- **Note**: Maximum 500 characters if provided
- **Receipt URL**: Must be valid URL format if provided
- **Category**: Must be from default or custom categories
- **ID**: Must be UUID v4 format

## Serialization

All platforms must support:

- JSON serialization/deserialization
- Platform-specific persistence (Hive, SwiftData, Room)
- API DTO mapping

## Equality

Two expenses are equal if and only if their IDs match.
