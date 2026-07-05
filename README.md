# Smart Expense Manager - Mobile Engineering Leadership

## Project Overview

Smart Expense Manager is a comprehensive mobile application for tracking personal and business expenses. This project demonstrates mobile engineering leadership through complete architecture design, project planning, team management strategies, and hands-on implementation.

## Tech Stack

### iOS

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Architecture**: Clean Architecture with MVVM
- **Data Persistence**: SwiftData
- **Networking**: URLSession with async/await
- **Dependency Injection**: Custom DI container
- **Testing**: XCTest

### Android

- **Language**: Kotlin 1.9+
- **UI Framework**: Jetpack Compose
- **Architecture**: Clean Architecture with MVVM
- **Data Persistence**: Room
- **Networking**: Retrofit + OkHttp
- **Dependency Injection**: Hilt
- **Testing**: JUnit, MockK, Espresso

## Architecture

### Clean Architecture Layers

```text
┌─────────────────────────────────────┐
│   Presentation Layer (UI)           │
│   - SwiftUI Views                   │
│   - ViewModels                      │
│   - State Management                │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│   Domain Layer (Business Logic)     │
│   - Use Cases                       │
│   - Entities                        │
│   - Repository Interfaces           │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│   Data Layer (Data Access)          │
│   - Repository Implementations      │
│   - Data Sources (API, Local)       │
└─────────────────────────────────────┘
```

### Key Features

- Expense creation and management
- Category-based organization
- Receipt image upload
- Offline-first architecture
- Automatic synchronization
- Budget tracking
- Expense analytics
- Multi-currency support
- Multi-language support

## Documentation

### Project Documentation

- [Mobile Solution Architecture](docs/01-Mobile-Solution-Architecture.md) - Complete architecture design with diagrams
- [Project Planning](docs/02-Project-Planning.md) - 12-week project plan with team coordination
- [Team Leadership](docs/03-Team-Leadership.md) - Strategies for leading mobile teams
- [Technical Decision Making](docs/04-Technical-Decision-Making.md) - Scenario-based decision frameworks
- [Mobile Engineering Standards](docs/05-Mobile-Engineering-Standards.md) - Development standards and best practices
- [Quality Assurance Strategy](docs/06-Quality-Assurance-Strategy.md) - Testing strategy and quality gates
- [CI/CD & Release Management](docs/07-CICD-Release-Management.md) - Pipeline design and deployment
- [Scalability & Security](docs/08-Scalability-Security.md) - Scalability and security approach
- [Risk Assessment](docs/09-Risk-Assessment.md) - Comprehensive risk analysis

### Architecture Decision Records

- [ADR-001: Clean Architecture Implementation](docs/adr/ADR-001-clean-architecture.md)
- [ADR-002: SwiftUI Adoption](docs/adr/ADR-002-swiftui-adoption.md)
- [ADR-003: Offline-First Strategy](docs/adr/ADR-003-offline-first-strategy.md)

### Code Review Checklist

- [Code Review Checklist](docs/code-review-checklist.md) - Comprehensive review guidelines

## Setup Instructions

### Prerequisites

- macOS 14.0+ / Windows 10+ / Linux
- Xcode 15.0+ (for iOS) / Android Studio Hedgehog+ (for Android)
- iOS 17.0+ (deployment target) / Android 7.0+ (minSdk 24)
- Swift 5.9+ / Kotlin 1.9+

### iOS Setup

- Clone the repository

```bash
git clone https://github.com/yourusername/SmartExpenseManager.git
cd SmartExpenseManager
```

- Open the project

```bash
open ios_native/SmartExpenseManager/SmartExpenseManager.xcodeproj
```

- Install dependencies

```bash
cd ios_native/SmartExpenseManager
# If using Swift Package Manager
# Dependencies are managed through Xcode
```

- Configure environment

- Create `Config.xcconfig` file with your API keys
- Add Firebase configuration if using Firebase services
- Configure signing certificates for distribution

- Run the app

- Select a simulator or device
- Press Cmd+R to build and run

### Android Setup

- Clone the repository

```bash
git clone https://github.com/yourusername/SmartExpenseManager.git
cd SmartExpenseManager
```

- Open the project

```bash
cd android_native
# Open in Android Studio
open -a "Android Studio" .
```

- Install dependencies

```bash
cd android_native
./gradlew build
```

- Configure environment

- Add API keys in `local.properties` if needed
- Configure signing certificates for release builds

- Run the app

- Connect an Android device or start an emulator
- Click Run in Android Studio or use:

```bash
./gradlew installDebug
```

### Running Tests

#### iOS Tests

```bash
# Run all tests
xcodebuild test -scheme SmartExpenseManager -destination 'platform=iOS Simulator,name=iPhone 14'

# Run unit tests only
xcodebuild test -scheme SmartExpenseManager -destination 'platform=iOS Simulator,name=iPhone 14' -only-testing:SmartExpenseManagerTests

# Run UI tests
xcodebuild test -scheme SmartExpenseManager -destination 'platform=iOS Simulator,name=iPhone 14' -only-testing:SmartExpenseManagerUITests
```

#### Android Tests

```bash
cd android_native

# Run all tests
./gradlew test

# Run unit tests only
./gradlew testDebugUnitTest

# Run instrumented tests
./gradlew connectedAndroidTest

# Run specific test class
./gradlew test --tests "com.smartexpense.manager.domain.usecase.GetExpensesTest"
```

## Project Structure

```text
SmartExpenseManager/
├── docs/                          # Documentation
│   ├── adr/                      # Architecture Decision Records
│   ├── 01-Mobile-Solution-Architecture.md
│   ├── 02-Project-Planning.md
│   └── ...
├── ios_native/                    # iOS Application
│   └── SmartExpenseManager/
│       ├── App/                   # App entry point
│       ├── Data/                  # Data layer
│       │   ├── Local/            # Local data sources
│       │   ├── Remote/           # Remote data sources
│       │   └── Repository/       # Repository implementations
│       ├── Domain/                # Domain layer
│       │   ├── Models/           # Domain models
│       │   ├── UseCases/         # Business logic
│       │   └── Repository/       # Repository interfaces
│       ├── Presentation/          # Presentation layer
│       │   ├── Features/         # Feature modules
│       │   ├── Navigation/       # Navigation
│       │   └── Theme/           # UI theme
│       └── DI/                   # Dependency injection
├── android_native/                # Android Application
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── java/com/smartexpense/manager/
│   │   │   │   ├── data/         # Data layer
│   │   │   │   │   ├── local/   # Room database
│   │   │   │   │   ├── remote/  # Retrofit API
│   │   │   │   │   └── repository/ # Repository implementations
│   │   │   │   ├── domain/       # Domain layer
│   │   │   │   │   ├── model/   # Domain models
│   │   │   │   │   ├── usecase/ # Business logic
│   │   │   │   │   └── repository/ # Repository interfaces
│   │   │   │   ├── presentation/ # Presentation layer
│   │   │   │   │   ├── feature/ # Feature modules
│   │   │   │   │   ├── viewmodel/ # ViewModels
│   │   │   │   │   └── theme/   # UI theme
│   │   │   │   └── di/           # Hilt modules
│   │   │   └── AndroidManifest.xml
│   │   └── build.gradle.kts
│   └── build.gradle.kts
├── flutter/                       # Flutter Application (Cross-platform)
│   ├── lib/
│   │   ├── core/                 # Core functionality
│   │   ├── data/                 # Data layer
│   │   ├── domain/               # Domain layer
│   │   └── presentation/         # Presentation layer
│   ├── android/                  # Android platform files
│   └── ios/                      # iOS platform files
└── README.md
```

## Development Workflow

### Git Flow

- `main` - Production-ready code
- `develop` - Integration branch
- `feature/*` - Feature development
- `bugfix/*` - Bug fixes
- `hotfix/*` - Production fixes

### Commit Message Format

```text
type(scope): subject

body

footer
```

Types: feat, fix, docs, style, refactor, test, chore

### Code Review Process

- Create feature branch from develop
- Implement changes with tests
- Create pull request
- Address review feedback
- Merge after approval

## Quality Standards

### Code Coverage

- Business logic: 80%
- UI code: 60%

### Performance Targets

- App startup: < 3 seconds
- Screen load: < 1 second
- API response: < 500ms (p95)

### Security Standards

- TLS 1.3 for all network calls
- Data encryption at rest
- Secure token storage (Keychain)
- No hardcoded secrets

## CI/CD

### GitHub Actions

- Automated builds on push
- Unit tests on every commit
- UI tests on pull requests
- Static code analysis
- Automated deployment to TestFlight

### Quality Gates

- All tests must pass
- Code coverage thresholds met
- No linting errors
- Security scan passed
- Performance benchmarks met

## Contributing

- Fork the repository
- Create a feature branch
- Make your changes
- Add tests
- Submit a pull request
- Address review feedback

## License

This project is created for assessment purposes.

## Contact

For questions about this assessment, please contact the project owner.

## Acknowledgments

This project demonstrates comprehensive mobile engineering leadership including:

- Architecture design
- Project planning
- Team management
- Technical decision making
- Quality assurance
- CI/CD implementation
- Security and scalability considerations
