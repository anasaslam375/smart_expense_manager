# Part 7: CI/CD & Release Management

## CI/CD Pipeline Design

### Platform Choice: GitHub Actions

**Rationale**:

- Native GitHub integration
- Free for public repositories
- Excellent mobile app support
- Large marketplace of actions
- Easy configuration with YAML

---

## Android CI/CD Pipeline

### Workflow Configuration

```yaml
name: Android CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up JDK 17
      uses: actions/setup-java@v3
      with:
        java-version: '17'
        distribution: 'temurin'
        
    - name: Grant execute permission for gradlew
      run: chmod +x gradlew
      
    - name: Cache Gradle packages
      uses: actions/cache@v3
      with:
        path: |
          ~/.gradle/caches
          ~/.gradle/wrapper
        key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*', '**/gradle-wrapper.properties') }}
        
    - name: Run Lint
      run: ./gradlew lint
      
    - name: Run Unit Tests
      run: ./gradlew test
      
    - name: Generate Test Report
      if: always()
      uses: dorny/test-reporter@v1
      with:
        name: Android Tests
        path: '**/build/test-results/testDebugUnitTest/*.xml'
        reporter: java-junit
        fail-on-error: true
        
    - name: Build Debug APK
      run: ./gradlew assembleDebug
      
    - name: Upload Debug APK
      uses: actions/upload-artifact@v3
      with:
        name: debug-apk
        path: app/build/outputs/apk/debug/app-debug.apk
        
    - name: Build Release APK
      if: github.ref == 'refs/heads/main'
      run: ./gradlew assembleRelease
      
    - name: Upload Release APK
      if: github.ref == 'refs/heads/main'
      uses: actions/upload-artifact@v3
      with:
        name: release-apk
        path: app/build/outputs/apk/release/app-release.apk
```

### UI Testing Pipeline

```yaml
name: Android UI Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  ui-test:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up JDK 17
      uses: actions/setup-java@v3
      with:
        java-version: '17'
        distribution: 'temurin'
        
    - name: Run UI Tests
      uses: reactivecircus/android-emulator-runner@v2
      with:
        api-level: 33
        target: google_apis
        arch: x86_64
        profile: Nexus 6
        script: ./gradlew connectedAndroidTest
```

### Static Code Analysis

```yaml
- name: Run Detekt
  run: ./gradlew detekt
  
- name: Upload Detekt Results
  uses: github/codeql-action/upload-sarif@v2
  with:
    sarif_file: build/reports/detekt/detekt.sarif
```

---

## iOS CI/CD Pipeline

### Workflow Configuration

```yaml
name: iOS CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  build:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Xcode
      uses: maxim-lobanov/setup-xcode@v1
      with:
        xcode-version: '15.0'
        
    - name: Cache CocoaPods
      uses: actions/cache@v3
      with:
        path: Pods
        key: ${{ runner.os }}-pods-${{ hashFiles('**/Podfile.lock') }}
        
    - name: Install Dependencies
      run: |
        cd ios_native
        pod install
        
    - name: Run SwiftLint
      run: |
        brew install swiftlint
        swiftlint lint --reporter github-actions-logging
        
    - name: Run Unit Tests
      run: |
        cd ios_native
        xcodebuild test -workspace SmartExpenseManager.xcworkspace \
          -scheme SmartExpenseManager \
          -destination 'platform=iOS Simulator,name=iPhone 14,OS=latest' \
          -enableCodeCoverage YES
        
    - name: Build Debug
      run: |
        cd ios_native
        xcodebuild -workspace SmartExpenseManager.xcworkspace \
          -scheme SmartExpenseManager \
          -configuration Debug \
          -sdk iphonesimulator \
          -derivedDataPath build
          
    - name: Build Release
      if: github.ref == 'refs/heads/main'
      run: |
        cd ios_native
        xcodebuild -workspace SmartExpenseManager.xcworkspace \
          -scheme SmartExpenseManager \
          -configuration Release \
          -archivePath build/SmartExpenseManager.xcarchive \
          archive
```

### UI Testing Pipeline

```yaml
name: iOS UI Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  ui-test:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Xcode
      uses: maxim-lobanov/setup-xcode@v1
      with:
        xcode-version: '15.0'
        
    - name: Run UI Tests
      run: |
        cd ios_native
        xcodebuild test -workspace SmartExpenseManager.xcworkspace \
          -scheme SmartExpenseManager \
          -destination 'platform=iOS Simulator,name=iPhone 14,OS=latest' \
          -only-testing:SmartExpenseManagerUITests
```

---

## Flutter CI/CD Pipeline

### Workflow Configuration

```yaml
name: Flutter CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
        channel: 'stable'
        cache: true
        
    - name: Install dependencies
      run: |
        cd flutter
        flutter pub get
        
    - name: Run Lint
      run: |
        cd flutter
        flutter analyze
        
    - name: Run Unit Tests
      run: |
        cd flutter
        flutter test --coverage
        
    - name: Upload Coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        files: flutter/coverage/lcov.info
        
    - name: Build Debug APK
      run: |
        cd flutter
        flutter build apk --debug
        
    - name: Upload Debug APK
      uses: actions/upload-artifact@v3
      with:
        name: debug-apk
        path: flutter/build/app/outputs/flutter-apk/app-debug.apk
        
    - name: Build Release APK
      if: github.ref == 'refs/heads/main'
      run: |
        cd flutter
        flutter build apk --release
        
    - name: Upload Release APK
      if: github.ref == 'refs/heads/main'
      uses: actions/upload-artifact@v3
      with:
        name: release-apk
        path: flutter/build/app/outputs/flutter-apk/app-release.apk
```

### UI Testing Pipeline

```yaml
name: Flutter UI Tests

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  ui-test:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
        channel: 'stable'
        cache: true
        
    - name: Install dependencies
      run: |
        cd flutter
        flutter pub get
        
    - name: Run Integration Tests
      run: |
        cd flutter
        flutter test integration_test/
```

### Static Code Analysis

```yaml
- name: Run Flutter Analyze
  run: |
    cd flutter
    flutter analyze
    
- name: Run Custom Lint
  run: |
    cd flutter
    flutter pub run custom_lint
```

---

## Automated Builds

### Build Triggers

- **On Push**: Every push to main/develop branches
- **On Pull Request**: Every PR to main/develop
- **Scheduled**: Nightly builds for develop branch
- **Manual**: On-demand builds for testing

### Build Types

**Android**:

- Debug: Development and testing
- Release: Production builds with signing

**iOS**:

- Debug: Development and testing
- Release: Production builds with provisioning

**Flutter**:

- Debug: Development and testing
- Release: Production builds with signing
- Profile: Performance profiling builds

### Build Artifacts

**Android**:

- APK files (debug and release)
- AAB files for Play Store
- Test results
- Lint reports
- Coverage reports

**iOS**:

- IPA files
- Archive files
- Test results
- Lint reports
- Coverage reports

**Flutter**:

- APK files (Android from Flutter)
- IPA files (iOS from Flutter)
- Test results
- Lint reports
- Coverage reports

---

## Static Code Analysis

### Android Tools

**Detekt**: Kotlin static analysis

```kotlin
// detekt.yml
build:
  maxIssues: 0
  excludeCorrectable: false

complexity:
  active: true
  LongMethod:
    active: true
    threshold: 50
  LongParameterList:
    active: true
    threshold: 6
```

**Android Lint**: Built-in Android checks

```gradle
android {
    lint {
        abortOnError true
        checkReleaseBuilds true
        disable 'TypographyFractions'
    }
}
```

### iOS Tools

**SwiftLint**: Swift style and conventions

```yaml
# .swiftlint.yml
disabled_rules:
  - trailing_whitespace
opt_in_rules:
  - empty_count
  - empty_string
line_length: 120
```

**Xcode Static Analyzer**: Built-in Xcode analysis

### Flutter Tools

**Flutter Analyze**: Built-in Flutter static analysis

```yaml
# analysis_options.yaml
linter:
  rules:
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    avoid_print: true
    prefer_single_quotes: true
```

**Custom Lint**: Additional Dart linting rules

```yaml
# pubspec.yaml
dev_dependencies:
  custom_lint: ^0.5.0
  flutter_lints: ^3.0.0
```

---

## Unit Testing

### Android

```yaml
- name: Run Unit Tests
  run: ./gradlew testDebugUnitTest
  
- name: Generate Coverage Report
  run: ./gradlew jacocoTestReport
  
- name: Upload Coverage to Codecov
  uses: codecov/codecov-action@v3
  with:
    files: ./app/build/reports/jacoco/jacocoTestReport/jacocoTestReport.xml
```

### iOS

```yaml
- name: Run Unit Tests
  run: |
    xcodebuild test -workspace SmartExpenseManager.xcworkspace \
      -scheme SmartExpenseManager \
      -enableCodeCoverage YES \
      -resultBundlePath TestResults.xcresult
      
- name: Upload Coverage to Codecov
  uses: codecov/codecov-action@v3
  with:
    xcode: true
```

### Flutter

```yaml
- name: Run Unit Tests
  run: |
    cd flutter
    flutter test --coverage
    
- name: Upload Coverage to Codecov
  uses: codecov/codecov-action@v3
  with:
    files: flutter/coverage/lcov.info
```

---

## UI Testing

### Android

```yaml
- name: Run UI Tests
  uses: reactivecircus/android-emulator-runner@v2
  with:
    api-level: 33
    target: google_apis
    arch: x86_64
    script: ./gradlew connectedAndroidTest
```

### iOS

```yaml
- name: Run UI Tests
  run: |
    xcodebuild test -workspace SmartExpenseManager.xcworkspace \
      -scheme SmartExpenseManager \
      -destination 'platform=iOS Simulator,name=iPhone 14' \
      -only-testing:SmartExpenseManagerUITests
```

### Flutter

```yaml
- name: Run UI Tests
  run: |
    cd flutter
    flutter test integration_test/
```

---

## APK/IPA Generation

### Android APK/AAB

```yaml
- name: Build Release AAB
  run: ./gradlew bundleRelease
  
- name: Sign AAB
  uses: r0adkll/sign-android-release@v1
  with:
    releaseDirectory: app/build/outputs/bundle/release
    signingKeyBase64: ${{ secrets.SIGNING_KEY }}
    alias: ${{ secrets.ALIAS }}
    keyStorePassword: ${{ secrets.KEY_STORE_PASSWORD }}
    keyPassword: ${{ secrets.KEY_PASSWORD }}
```

### iOS IPA

```yaml
- name: Build and Archive
  run: |
    xcodebuild -workspace SmartExpenseManager.xcworkspace \
      -scheme SmartExpenseManager \
      -configuration Release \
      -archivePath build/SmartExpenseManager.xcarchive \
      archive
      
- name: Export IPA
  run: |
    xcodebuild -exportArchive \
      -archivePath build/SmartExpenseManager.xcarchive \
      -exportPath build/export \
      -exportOptionsPlist ExportOptions.plist
```

### Flutter APK/IPA

```yaml
- name: Build Android Release APK
  run: |
    cd flutter
    flutter build apk --release
    
- name: Build Android Release AAB
  run: |
    cd flutter
    flutter build appbundle --release
    
- name: Build iOS Release IPA
  run: |
    cd flutter
    flutter build ios --release
```

---

## TestFlight Deployment

### Workflow

```yaml
name: Deploy to TestFlight

on:
  push:
    tags:
      - 'ios-v*'

jobs:
  deploy:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Xcode
      uses: maxim-lobanov/setup-xcode@v1
      with:
        xcode-version: '15.0'
        
    - name: Install Dependencies
      run: |
        cd ios_native
        pod install
        
    - name: Build and Archive
      run: |
        cd ios_native
        xcodebuild -workspace SmartExpenseManager.xcworkspace \
          -scheme SmartExpenseManager \
          -configuration Release \
          -archivePath build/SmartExpenseManager.xcarchive \
          archive
          
    - name: Upload to TestFlight
      uses: apple-actions/upload-testflight-build@v1
      with:
        app-path: ios_native/build/SmartExpenseManager.xcarchive
        apple-id: ${{ secrets.APPLE_ID }}
        app-specific-password: ${{ secrets.APP_SPECIFIC_PASSWORD }}
        issuer-id: ${{ secrets.ISSUER_ID }}
        api-key-id: ${{ secrets.API_KEY_ID }}
        api-key: ${{ secrets.API_KEY }}
```

---

## Google Play Internal Testing

### Workflow

```yaml
name: Deploy to Google Play

on:
  push:
    tags:
      - 'android-v*'

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up JDK 17
      uses: actions/setup-java@v3
      with:
        java-version: '17'
        distribution: 'temurin'
        
    - name: Build Release AAB
      run: ./gradlew bundleRelease
      
    - name: Upload to Google Play
      uses: r0adkll/upload-google-play@v1
      with:
        serviceAccountJsonPlainText: ${{ secrets.SERVICE_ACCOUNT_JSON }}
        packageName: com.smartexpense.manager
        releaseFiles: app/build/outputs/bundle/release/app-release.aab
        track: internal
        status: completed
```

---

## Production Deployment

### Android Production

```yaml
name: Android Production Release

on:
  push:
    tags:
      - 'android-prod-v*'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Build and Sign
      run: ./gradlew bundleRelease
      
    - name: Deploy to Production
      uses: r0adkll/upload-google-play@v1
      with:
        serviceAccountJsonPlainText: ${{ secrets.SERVICE_ACCOUNT_JSON }}
        packageName: com.smartexpense.manager
        releaseFiles: app/build/outputs/bundle/release/app-release.aab
        track: production
        status: completed
```

### iOS Production

```yaml
name: iOS Production Release

on:
  push:
    tags:
      - 'ios-prod-v*'

jobs:
  deploy:
    runs-on: macos-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Build and Archive
      run: |
        cd ios_native
        xcodebuild -workspace SmartExpenseManager.xcworkspace \
          -scheme SmartExpenseManager \
          -configuration Release \
          -archivePath build/SmartExpenseManager.xcarchive \
          archive
          
    - name: Submit to App Store
      uses: apple-actions/upload-testflight-build@v1
      with:
        app-path: ios_native/build/SmartExpenseManager.xcarchive
        apple-id: ${{ secrets.APPLE_ID }}
        app-specific-password: ${{ secrets.APP_SPECIFIC_PASSWORD }}
        issuer-id: ${{ secrets.ISSUER_ID }}
        api-key-id: ${{ secrets.API_KEY_ID }}
        api-key: ${{ secrets.API_KEY }}
        submit-for-review: true
```

---

## Crash Monitoring

### Firebase Crashlytics Integration

**Android**:

```gradle
dependencies {
    implementation platform('com.google.firebase:firebase-bom:32.0.0')
    implementation 'com.google.firebase:firebase-crashlytics'
}
```

**iOS**:

```swift
import FirebaseCrashlytics

FirebaseApp.configure()
```

**Flutter**:

```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';

await Firebase.initializeApp();
FlutterError.onError = (errorDetails) {
  FirebaseCrashlytics.instance.recordError(
    errorDetails.exception,
    errorDetails.stack,
  );
};
```

### Crash Reporting Setup

```yaml
- name: Upload Crashlytics Symbols
  run: ./gradlew crashlyticsUploadSymbolsDebug
```

---

## Release Rollback Strategy

### Android Rollback

1. **Immediate Rollback**:
   - Use Google Play Console to unpublish app
   - Deploy previous version to production track
   - Notify users of rollback

2. **Hotfix Rollback**:
   - Build hotfix version
   - Deploy to internal testing
   - Rapid release to production

### iOS Rollback

1. **Immediate Rollback**:
   - Remove app from sale in App Store Connect
   - Submit previous version for review
   - Expedited review request

2. **Hotfix Rollback**:
   - Build hotfix version
   - Deploy to TestFlight
   - Expedited App Store review

### Rollback Triggers

- Crash rate > 5%
- Critical bug affecting > 10% of users
- Security vulnerability
- Data loss issue
- Performance degradation

### Rollback Communication

- In-app notification
- Email to affected users
- Social media announcement
- Status page update

---

## Release Checklist

### Pre-Release

- All tests passing
- Code coverage met
- Security scan passed
- Performance benchmarks met
- Documentation updated
- Release notes prepared
- Beta testing completed
- Stakeholder approval

### Release Day

- Deploy to production
- Monitor crash rates
- Monitor performance metrics
- Monitor user feedback
- Support team notified
- Rollback plan ready

### Post-Release

- Monitor for 24-48 hours
- Address critical issues
- Gather user feedback
- Analyze metrics
- Post-release retrospective
- Document lessons learned
