# Smart Expense Manager - Android Native

## Overview

This is the native Android implementation of the Smart Expense Manager application, built with Kotlin, Jetpack Compose, and following Clean Architecture principles.

## Tech Stack

- **Language**: Kotlin 1.9+
- **UI Framework**: Jetpack Compose with Material 3
- **Architecture**: Clean Architecture with MVVM
- **Data Persistence**: Room Database
- **Networking**: Retrofit + OkHttp
- **Dependency Injection**: Hilt
- **Testing**: JUnit, MockK, Espresso
- **Asynchronous**: Kotlin Coroutines & Flow

## Architecture

### Clean Architecture Layers

```
┌─────────────────────────────────────┐
│   Presentation Layer (UI)          │
│   - Jetpack Compose Screens       │
│   - ViewModels                    │
│   - State Management              │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│   Domain Layer (Business Logic)     │
│   - Use Cases                      │
│   - Models                         │
│   - Repository Interfaces          │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│   Data Layer (Data Access)          │
│   - Repository Implementations      │
│   - Room Database                   │
│   - Retrofit API                    │
└─────────────────────────────────────┘
```

## Project Structure

```
app/src/main/java/com/smartexpense/manager/
├── data/
│   ├── local/
│   │   ├── entity/          # Room entities
│   │   ├── ExpenseDao.kt    # Data access object
│   │   └── AppDatabase.kt  # Room database
│   └── repository/
│       └── ExpenseRepositoryImpl.kt
├── domain/
│   ├── model/
│   │   └── Expense.kt      # Domain models
│   ├── repository/
│   │   └── ExpenseRepository.kt
│   └── usecase/
│       ├── GetExpenses.kt
│       ├── SaveExpense.kt
│       └── DeleteExpense.kt
├── presentation/
│   ├── MainActivity.kt
│   ├── feature/
│   │   └── expense/
│   │       ├── ExpenseListScreen.kt
│   │       └── AddExpenseBottomSheet.kt
│   ├── viewmodel/
│   │   └── ExpenseViewModel.kt
│   └── theme/
│       ├── Theme.kt
│       └── Type.kt
└── di/
    ├── DatabaseModule.kt
    └── RepositoryModule.kt
```

## Key Features

- **Expense Management**: Create, read, update, and delete expenses
- **Category Organization**: Filter expenses by predefined categories
- **Offline-First**: Local database with Room for offline access
- **Modern UI**: Jetpack Compose with Material 3 design
- **State Management**: ViewModel with StateFlow
- **Dependency Injection**: Hilt for loose coupling
- **Testing**: Unit tests with JUnit/MockK, UI tests with Espresso

## Setup Instructions

### Prerequisites

- Android Studio Hedgehog or later
- JDK 17
- Android SDK 34
- Minimum SDK: 24 (Android 7.0)

### Build Steps

1. Open the project in Android Studio
2. Sync Gradle files
3. Build the project: `./gradlew build`
4. Run on emulator or device: `./gradlew installDebug`

## Running Tests

### Unit Tests

```bash
./gradlew test
```

### Instrumented Tests

```bash
./gradlew connectedAndroidTest
```

### Specific Test Class

```bash
./gradlew test --tests "com.smartexpense.manager.domain.usecase.GetExpensesTest"
```

## Dependency Injection

The app uses Hilt for dependency injection:

- **DatabaseModule**: Provides Room database and DAO
- **RepositoryModule**: Binds repository implementations to interfaces
- **Application**: `@HiltAndroidApp` annotation enables Hilt

## Data Layer

### Room Database

- **ExpenseEntity**: Maps expenses to database table
- **ExpenseDao**: Provides database operations
- **AppDatabase**: Main database configuration

### Repository Pattern

- **ExpenseRepository**: Interface for data operations
- **ExpenseRepositoryImpl**: Concrete implementation using Room

## Domain Layer

### Models

- **Expense**: Core expense model with amount, category, date, etc.
- **Category**: Expense category with icon and color
- **Budget**: Budget tracking model

### Use Cases

- **GetExpenses**: Retrieve expenses with filtering options
- **SaveExpense**: Save new or update existing expenses
- **DeleteExpense**: Remove expenses from database

## Presentation Layer

### Screens

- **ExpenseListScreen**: Main screen showing expense list with filters
- **AddExpenseBottomSheet**: Modal for adding new expenses

### ViewModels

- **ExpenseViewModel**: Manages expense state and business logic

### Theme

- **SmartExpenseManagerTheme**: Material 3 theme with light/dark modes
- **Typography**: Custom typography configuration

## Build Configuration

### Gradle Plugins

- Kotlin Android
- Hilt Android
- KSP (Kotlin Symbol Processing)

### Dependencies

- Jetpack Compose BOM
- Navigation Compose
- Hilt
- Room
- Retrofit
- Coroutines
- DataStore

## Code Quality

### Testing Strategy

- **Unit Tests**: Test business logic in isolation
- **Integration Tests**: Test database operations
- **UI Tests**: Test user interactions with Compose

### Code Standards

- Kotlin coding conventions
- Clean Architecture principles
- SOLID principles
- Material Design guidelines

## Performance Considerations

- **Coroutines**: Asynchronous operations for smooth UI
- **Flow**: Reactive data streams for real-time updates
- **Room**: Efficient database queries with indexing
- **Compose**: Efficient recomposition with proper state management

## Security

- **ProGuard**: Code obfuscation for release builds
- **Network Security**: TLS for API calls
- **Data Encryption**: Room database encryption (optional)

## Future Enhancements

- [ ] Cloud synchronization with Firebase
- [ ] Biometric authentication
- [ ] Export to CSV/PDF
- [ ] Advanced analytics and charts
- [ ] Multi-currency support
- [ ] Recurring expenses
- [ ] Budget alerts and notifications

## Contributing

1. Follow the existing code structure
2. Write tests for new features
3. Ensure all tests pass before committing
4. Follow Kotlin coding conventions
5. Update documentation as needed

## License

This project is created for assessment purposes.
