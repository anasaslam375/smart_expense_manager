# Part 5: Mobile Engineering Standards

## Architecture Standards

### Clean Architecture

**Principles**:

- Dependency Rule: Dependencies only point inward
- Platform-independent business logic
- Testable at every layer
- Framework-agnostic core

**Layer Structure**:

```text
┌─────────────────────────────────────┐
│   Presentation Layer (UI)           │
│   - Views, ViewModels, Controllers  │
│   - Platform-specific UI code       │
└─────────────────────────────────────┘
              ↓ depends on
┌─────────────────────────────────────┐
│   Domain Layer (Business Logic)     │
│   - Use Cases, Entities             │
│   - Platform-independent            │
└─────────────────────────────────────┘
              ↓ depends on
┌─────────────────────────────────────┐
│   Data Layer (Data Access)          │
│   - Repositories, Data Sources      │
│   - External dependencies           │
└─────────────────────────────────────┘
```

**Rules**:

- No dependencies from inner to outer layers
- Use cases contain business logic only
- Repositories abstract data sources
- Entities are plain data objects
- ViewModels handle UI logic only

### SOLID Principles

**Single Responsibility Principle**:

- Each class/module has one reason to change
- Functions do one thing well
- Keep classes focused and small

**Open/Closed Principle**:

- Open for extension, closed for modification
- Use interfaces and abstractions
- Dependency injection for flexibility

**Liskov Substitution Principle**:

- Subtypes must be substitutable for base types
- Honor contracts of base classes
- Don't violate invariants

**Interface Segregation Principle**:

- Prefer small, specific interfaces
- Clients shouldn't depend on unused methods
- Split large interfaces

**Dependency Inversion Principle**:

- Depend on abstractions, not concretions
- High-level modules shouldn't depend on low-level
- Use dependency injection

### Design Patterns

**Common Patterns**:

- Repository: Abstract data access
- Factory: Object creation
- Strategy: Interchangeable algorithms
- Observer: Reactive updates
- Singleton: Single instance (use carefully)
- Builder: Complex object construction
- Adapter: Interface compatibility
- Decorator: Add functionality dynamically
- Extension Methods: Add functionality to existing types (platform-specific)

**When to Use**:

- Repository: Data access layer
- Factory: Complex object creation
- Strategy: Multiple implementations
- Observer: Event handling, UI updates
- Builder: Objects with many parameters
- Extension Methods: Common operations on existing types (formatting, parsing)

**Platform-Specific Extensions**:

**Android (Kotlin)**:

- Use extension functions for common operations
- Example: `Double.toCurrency()`, `Date.toFormattedDate()`
- Place in `presentation/extensions/` package

**iOS (Swift)**:

- Use extensions for common operations
- Example: `Double.toCurrency()`, `Date.toFormattedDate()`
- Place in `Presentation/Extensions/` directory

**Flutter (Dart)**:

- Use extensions for common operations
- Example: `double.toCurrency()`, `DateTime.toFormattedDate()`
- Place in `core/extensions/` directory

---

## Development Standards

### Code Style

**Android (Kotlin)**:

- Follow Kotlin coding conventions
- Use ktlint for formatting
- Maximum line length: 120 characters
- Use meaningful names
- Prefer immutable variables (val)
- Use data classes for models
- Avoid nested functions (> 3 levels)

**iOS (Swift)**:

- Follow Swift API design guidelines
- Use SwiftLint for formatting
- Maximum line length: 120 characters
- Use meaningful names
- Prefer let over var
- Use structs for value types
- Avoid nested functions (> 3 levels)

**Flutter (Dart)**:

- Follow Dart effective style guide
- Use dart format for formatting
- Maximum line length: 120 characters
- Use meaningful names
- Prefer final variables
- Use data classes for models
- Avoid nested functions (> 3 levels)

### Folder Structure

**Android**:

```text
app/
├── src/main/java/com/company/app/
│   ├── data/
│   │   ├── local/
│   │   ├── remote/
│   │   └── repository/
│   ├── domain/
│   │   ├── model/
│   │   ├── usecase/
│   │   └── repository/
│   ├── presentation/
│   │   ├── feature/
│   │   │   ├── expense/
│   │   │   │   ├── ExpenseScreen.kt
│   │   │   │   ├── ExpenseViewModel.kt
│   │   │   │   └── ExpenseUiState.kt
│   │   ├── navigation/
│   │   └── theme/
│   └── di/
```

**iOS**:

```text
SmartExpenseManager/
├── App/
├── Data/
│   ├── Local/
│   ├── Remote/
│   └── Repository/
├── Domain/
│   ├── Models/
│   ├── UseCases/
│   └── Repository/
├── Presentation/
│   ├── Features/
│   │   ├── Expense/
│   │   │   ├── ExpenseView.swift
│   │   │   ├── ExpenseViewModel.swift
│   │   │   └── ExpenseState.swift
│   ├── Navigation/
│   └── Theme/
└── DI/
```

**Flutter**:

```text
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── datasources/
│       ├── local/
│       └── remote/
├── domain/
│   ├── entities/
│   ├── usecases/
│   └── repositories/
├── presentation/
│   ├── bloc/
│   ├── pages/
│   ├── widgets/
│   └── routes/
└── main.dart
```

### Dependency Management

**Android**:

- Use Gradle version catalogs
- Pin dependency versions
- Regular dependency updates
- Document why each dependency is needed
- Avoid duplicate dependencies

**iOS**:

- Use Swift Package Manager or CocoaPods
- Pin dependency versions
- Regular dependency updates
- Document dependency purposes
- Resolve conflicts promptly

**Flutter**:

- Use pubspec.yaml for dependencies
- Pin dependency versions
- Regular dependency updates (flutter pub upgrade)
- Document dependency purposes
- Use dependency_overrides for conflicts

### Error Handling

**Principles**:

- Handle errors at appropriate layers
- Never silently ignore errors
- Provide user-friendly error messages
- Log technical errors
- Use typed errors where possible

**Android**:

```kotlin
sealed class AppError {
    data class NetworkError(val message: String) : AppError()
    data class ValidationError(val field: String) : AppError()
    data class UnknownError(val message: String) : AppError()
}
```

**iOS**:

```swift
enum AppError: Error {
    case networkError(String)
    case validationError(String)
    case unknownError(String)
}
```

**Flutter**:

```dart
abstract class AppError extends Equatable {
  final String message;
  const AppError(this.message);
  
  @override
  List<Object> get props => [message];
}

class NetworkError extends AppError {
  const NetworkError(String message) : super(message);
}

class ValidationError extends AppError {
  const ValidationError(String message) : super(message);
}

class UnknownError extends AppError {
  const UnknownError(String message) : super(message);
}
```

### Logging

**Levels**:

- VERBOSE: Detailed debugging
- DEBUG: Development info
- INFO: General information
- WARNING: Warning conditions
- ERROR: Error conditions

**Guidelines**:

- Use structured logging
- Include context (user ID, session ID)
- No sensitive data in logs
- Production: INFO and above
- Development: all levels

### Performance Optimization

**Best Practices**:

- Lazy load resources
- Use efficient data structures
- Optimize images (compression, caching)
- Minimize allocations in hot paths
- Use background threads for heavy work
- Profile regularly
- Monitor memory usage

**Android Specific**:

- Use ViewBinding/DataBinding instead of findViewById
- Optimize RecyclerView with DiffUtil
- Use Glide/Coil for image loading
- Avoid memory leaks (weak references)
- Use WorkManager for background tasks

**iOS Specific**:

- Use lazy loading for views
- Optimize UITableView/UICollectionView
- Use Kingfisher for image loading
- Avoid retain cycles
- Use background queues for heavy work

**Flutter Specific**:

- Use const widgets where possible
- Optimize ListView/GridView with builders
- Use cached_network_image for image loading
- Avoid unnecessary rebuilds (use const, keys)
- Use Isolate for heavy computations

### Memory Management

**Android**:

- Avoid memory leaks (static references, handlers)
- Use weak references for contexts
- Clear references in onDestroy
- Use memory profiling tools
- Optimize bitmap usage

**iOS**:

- Understand ARC (Automatic Reference Counting)
- Avoid retain cycles (weak/unowned)
- Use value types where appropriate
- Profile with Instruments
- Manage large objects carefully

**Flutter**:

- Understand Dart garbage collection
- Avoid memory leaks (dispose controllers, close streams)
- Use const constructors where possible
- Profile with DevTools
- Manage large objects carefully

---

## Git Standards

### Git Flow Strategy

**Branch Types**:

- main: Production-ready code
- develop: Integration branch
- feature/*: Feature development
- release/*: Release preparation
- hotfix/*: Production fixes

**Workflow**:

1. Create feature branch from develop
2. Develop and test feature
3. Create pull request to develop
4. Code review and approval
5. Merge to develop
6. Create release branch from develop
7. Test release branch
8. Merge release to main and develop
9. Tag release

### Branch Naming

**Conventions**:

- feature/description (e.g., feature/expense-creation)
- bugfix/description (e.g., bugfix/login-crash)
- hotfix/description (e.g., hotfix/security-patch)
- release/version (e.g., release/1.0.0)

**Rules**:

- Use kebab-case
- Be descriptive but concise
- Include ticket number if applicable
- Delete merged branches

### Commit Message Conventions

**Format**:

```text
type(scope): subject

body

footer
```

**Types**:

- feat: New feature
- fix: Bug fix
- docs: Documentation
- style: Code style (formatting)
- refactor: Code refactoring
- test: Adding tests
- chore: Maintenance tasks

**Examples**:

```text
feat(expense): add receipt image upload

Implement image capture and upload functionality
with compression and error handling.

Closes #123
```

### Pull Request Process

**Before PR**:

- Update develop branch
- Rebase if necessary
- Run all tests
- Run linting
- Update documentation

**PR Description**:

- Title following commit conventions
- Description of changes
- Related issue number
- Screenshots for UI changes
- Testing performed
- Breaking changes (if any)

**Review Process**:

- At least one approval required
- All checks must pass
- Address all review comments
- Squash commits if needed
- Delete branch after merge

### Code Review Checklist

**Functionality**:

- Does it work as intended?
- Are edge cases handled?
- Is error handling appropriate?
- Are tests included?

**Code Quality**:

- Does it follow style guide?
- Is code readable and maintainable?
- Are there code smells?
- Is complexity acceptable?

**Architecture**:

- Does it follow architecture patterns?
- Are dependencies appropriate?
- Is separation of concerns maintained?
- Is it testable?

**Performance**:

- Is performance considered?
- Are there potential bottlenecks?
- Is memory usage appropriate?
- Are resources managed properly?

**Security**:

- Are there security vulnerabilities?
- Is sensitive data protected?
- Are inputs validated?
- Are dependencies secure?

**Documentation**:

- Is code documented where needed?
- Are comments helpful?
- Is README updated?
- Are API docs updated?

---

## Documentation Standards

### README

**Required Sections**:

- Project description
- Features
- Tech stack
- Installation instructions
- Usage guide
- Configuration
- Testing
- Contributing guidelines
- License

**Template**:

```markdown
# Project Name

Brief description

## Features
- Feature 1
- Feature 2

## Tech Stack
- Technology 1
- Technology 2

## Installation
Step-by-step instructions

## Usage
How to use the project

## Configuration
Environment variables, settings

## Testing
How to run tests

## Contributing
Guidelines for contributors

## License
License information
```

### API Documentation

**Requirements**:

- OpenAPI/Swagger specification
- Endpoint descriptions
- Request/response examples
- Error codes
- Authentication requirements
- Rate limits

**Tools**:

- Swagger UI
- Postman collections
- API versioning documentation

### Architecture Decision Records (ADR)

**Format**:

```markdown
# ADR-001: Title

## Status
Accepted / Proposed / Deprecated / Superseded

## Context
What is the issue we're facing?

## Decision
What did we decide?

## Consequences
What are the results of this decision?
```

**Location**: `/docs/adr/`

### Technical Documentation

**Types**:

- Architecture overview
- Component documentation
- Setup guides
- Troubleshooting guides
- Onboarding documentation

**Standards**:

- Keep documentation up to date
- Use clear language
- Include diagrams where helpful
- Provide examples
- Review documentation regularly
