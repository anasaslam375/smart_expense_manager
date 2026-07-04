# Expense Use Cases Specification

## Overview

Use cases define the business logic that must be consistent across all platforms. Each use case represents a specific business operation.

## Core Use Cases

### GetExpenses

**Purpose**: Retrieve all expenses with optional filtering

**Parameters**:

- None (for all expenses)
- date: DateTime (for date filtering)
- category: Category (for category filtering)

**Returns**: `Result<List<Expense>>`

**Business Logic**:

1. Validate input parameters if provided
2. Call repository with appropriate method
3. Order results by date (descending)
4. Calculate total amount
5. Return success with expenses and total

**Error Handling**:

- ValidationError: Invalid date or category
- NetworkError: Remote data unavailable
- PersistenceError: Local storage failure

### SaveExpense

**Purpose**: Create or update an expense

**Parameters**:

- amount: Double
- category: Category
- date: DateTime
- note: String? (optional)
- receiptUrl: String? (optional)

**Returns**: `Result<Expense>`

**Business Logic**:

1. Validate all input parameters
2. Generate UUID if creating new expense
3. Set createdAt timestamp if new
4. Set updatedAt timestamp always
5. Call repository to save
6. Return saved expense

**Validation Rules**:

- Amount must be > 0
- Amount max 2 decimal places
- Date cannot be in future
- Note max 500 characters
- Receipt URL must be valid if provided

### DeleteExpense

**Purpose**: Remove an expense from the system

**Parameters**:

- expense: Expense

**Returns**: `Result<Unit>`

**Business Logic**:

1. Verify expense exists
2. Call repository to delete
3. Return success or error

**Error Handling**:

- NotFoundError: Expense doesn't exist
- ValidationError: Invalid expense object
- PersistenceError: Delete operation failed

### GetTotalAmount

**Purpose**: Calculate total of all expenses

**Parameters**: None

**Returns**: `Result<Double>`

**Business Logic**:

1. Call repository to get total
2. Format to 2 decimal places
3. Return result

**Special Cases**:

- Return 0.0 if no expenses exist
- Handle null values gracefully

## Platform Implementations

### Flutter (Dart)

```dart
class GetExpenses {
  final ExpenseRepository repository;
  
  GetExpenses(this.repository);
  
  Future<Result<List<Expense>>> call() => repository.getExpenses();
  
  Future<Result<List<Expense>>> callByDate(DateTime date) => 
    repository.getExpensesByDate(date);
  
  Future<Result<List<Expense>>> callByCategory(Category category) => 
    repository.getExpensesByCategory(category);
}
```

### iOS (Swift)

```swift
class GetExpenses {
  private let repository: ExpenseRepository
  
  init(repository: ExpenseRepository) {
    self.repository = repository
  }
  
  func call() async -> Result<[Expense], Error> {
    return await repository.getExpenses()
  }
  
  func callByDate(_ date: Date) async -> Result<[Expense], Error> {
    return await repository.getExpensesByDate(date)
  }
  
  func callByCategory(_ category: Category) async -> Result<[Expense], Error> {
    return await repository.getExpensesByCategory(category)
  }
}
```

### Android (Kotlin)

```kotlin
class GetExpenses @Inject constructor(
  private val repository: ExpenseRepository
) {
  suspend operator fun invoke() = repository.getExpenses()
  
  suspend fun callByDate(date: Date) = repository.getExpensesByDate(date)
  
  suspend fun callByCategory(category: Category) = 
    repository.getExpensesByCategory(category)
}
```

## Validation Logic

All platforms must implement these validation functions:

### Amount Validation

- Must be positive (> 0)
- Maximum 2 decimal places
- Maximum value: 1,000,000.00

### Date Validation

- Cannot be in future
- Must be valid date object
- Timezone: Use device timezone

### Note Validation

- Maximum 500 characters
- Trim whitespace
- Allow empty/null

### URL Validation

- Must be valid URL format
- Must use HTTPS if present
- Maximum 2048 characters

## State Management

### Loading States

- Initial: No data loaded
- Loading: Fetching data
- Success: Data loaded successfully
- Error: Error occurred

### UI States

- Empty: No expenses to display
- Content: Expenses available
- Loading: Show loading indicator
- Error: Show error message with retry

## Error Messages

All platforms should use these standard error messages:

- "Failed to load expenses"
- "Failed to save expense"
- "Failed to delete expense"
- "Invalid amount"
- "Invalid date"
- "Network error"
- "Unknown error occurred"

## Performance Requirements

- Use case execution: < 200ms typical
- Validation: < 10ms
- Error handling: < 5ms
- Memory usage: < 10MB per use case

## Testing Requirements

Each use case must have:

- Unit tests for happy path
- Unit tests for error scenarios
- Validation tests
- Integration tests with repository
- Performance tests
