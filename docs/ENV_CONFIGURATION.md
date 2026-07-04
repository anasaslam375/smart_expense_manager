# Environment Configuration

This document explains how to configure environment variables and secret data for the SmartExpenseManager project.

## Overview

The project uses environment-specific configuration files to manage:

- API endpoints and keys
- Feature flags
- Authentication settings
- Third-party service credentials
- Debug and analytics settings

## Platform-Specific Configuration

### Flutter

**Template File:** `flutter/.env.example`

**Usage:**

1. Copy the template file:

   ```bash
   cp flutter/.env.example flutter/.env
   ```

2. Edit `flutter/.env` with your actual values:

   ```env
   API_BASE_URL=https://api.smartexpense.com/
   API_KEY=your_actual_api_key
   API_TIMEOUT_SECONDS=30
   ENABLE_ANALYTICS=false
   ENABLE_CRASH_REPORTING=true
   ENABLE_DEBUG_MODE=false
   ```

3. Add the `flutter_dotenv` package to `pubspec.yaml`:

   ```yaml
   dependencies:
     flutter_dotenv: ^5.1.0
   ```

4. Load environment variables in your app:

   ```dart
   import 'package:flutter_dotenv/flutter_dotenv.dart';

   Future<void> main() async {
     await dotenv.load(fileName: '.env');
     runApp(MyApp());
   }
   ```

5. Access environment variables:

   ```dart
   final apiUrl = dotenv.env['API_BASE_URL'];
   final apiKey = dotenv.env['API_KEY'];
   ```

### Android

**Template Files:**

- `android_native/.env.example` (for libraries like kotlin-dotenv)
- `android_native/local.properties.example` (for Gradle properties)

**Usage with local.properties:**

1. Copy the template:

   ```bash
   cp android_native/local.properties.example android_native/local.properties
   ```

2. Edit `android_native/local.properties` with your values:

   ```properties
   api.base.url=https://api.smartexpense.com/
   api.key=your_actual_api_key
   enable.analytics=false
   ```

3. Access in Gradle:

   ```gradle
   def apiBaseUrl = project.findProperty('api.base.url') ?: 'https://api.smartexpense.com/'
   def apiKey = project.findProperty('api.key') ?: ''
   ```

4. Access in Kotlin code:

   ```kotlin
   val apiBaseUrl = BuildConfig.API_BASE_URL
   val apiKey = BuildConfig.API_KEY
   ```

**Usage with BuildConfig:**
Add to `android/app/build.gradle`:

```gradle
android {
    defaultConfig {
        buildConfigField "String", "API_BASE_URL", "\"${project.findProperty('api.base.url') ?: 'https://api.smartexpense.com/'}\""
        buildConfigField "String", "API_KEY", "\"${project.findProperty('api.key') ?: ''}\""
    }
}
```

### iOS

**Template Files:**

- `ios_native/SmartExpenseManager/.env.example` (for libraries like swift-dotenv)
- `ios_native/SmartExpenseManager/Config.xcconfig.example` (for Xcode build settings)

**Usage with Config.xcconfig:**

1. Copy the template:

   ```bash
   cp ios_native/SmartExpenseManager/Config.xcconfig.example ios_native/SmartExpenseManager/Config.xcconfig
   ```

2. Edit `ios_native/SmartExpenseManager/Config.xcconfig` with your values:

   ```xcconfig
   API_BASE_URL = https://api.smartexpense.com/
   API_KEY = your_api_key_here
   ENABLE_ANALYTICS = NO
   ```

3. Add to your Xcode project:
   - Open Xcode
   - Select your project in the navigator
   - Select your target
   - Go to "Build Settings" tab
   - Add "Config.xcconfig" to "Config Files" section

4. Access in Swift code:

   ```swift
   let apiBaseUrl = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String ?? "https://api.smartexpense.com/"
   let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
   ```

## Security Best Practices

### DO

- ✅ Never commit `.env` files to version control
- ✅ Use `.env.example` files as templates
- ✅ Add `.env` to `.gitignore`
- ✅ Rotate API keys regularly
- ✅ Use different keys for different environments (dev, staging, prod)
- ✅ Document required environment variables

### DON'T

- ❌ Commit actual API keys or secrets
- ❌ Share `.env` files via email or chat
- ❌ Use the same keys across all environments
- ❌ Hardcode secrets in source code
- ❌ Log sensitive data

## Environment Variables Reference

### API Configuration

- `API_BASE_URL`: Base URL for API endpoints
- `API_KEY`: Authentication key for API requests
- `API_TIMEOUT_SECONDS`: Request timeout in seconds

### Feature Flags

- `ENABLE_ANALYTICS`: Enable/disable analytics tracking
- `ENABLE_CRASH_REPORTING`: Enable/disable crash reporting
- `ENABLE_DEBUG_MODE`: Enable/disable debug features

### Storage

- `MAX_IMAGE_SIZE_MB`: Maximum image upload size in MB
- `SUPPORTED_IMAGE_FORMATS`: Comma-separated list of supported image formats

### Authentication

- `AUTH_TOKEN_EXPIRY_DAYS`: Number of days until auth token expires
- `REFRESH_TOKEN_EXPIRY_DAYS`: Number of days until refresh token expires

### Firebase (Optional)

- `FIREBASE_API_KEY`: Firebase API key
- `FIREBASE_PROJECT_ID`: Firebase project ID

## CI/CD Configuration

For CI/CD pipelines, set environment variables in your CI/CD platform:

### GitHub Actions

```yaml
env:
  API_BASE_URL: ${{ secrets.API_BASE_URL }}
  API_KEY: ${{ secrets.API_KEY }}
```

### GitLab CI

```yaml
variables:
  API_BASE_URL: $API_BASE_URL
  API_KEY: $API_KEY
```

## Troubleshooting

### Flutter Environment Issues

- **Issue:** Environment variables not loading
  - **Solution:** Ensure `.env` file is in the root of the Flutter project and `flutter_dotenv` is properly initialized

### Android Environment Issues

- **Issue:** BuildConfig values not available
  - **Solution:** Rebuild the project after modifying `local.properties`

### iOS Environment Issues

- **Issue:** xcconfig values not available
  - **Solution:** Clean build folder (Product > Clean Build Folder) and rebuild

## Additional Resources

- [Flutter Dotenv Package](https://pub.dev/packages/flutter_dotenv)
- [Android BuildConfig](https://developer.android.com/studio/build/build-variables)
- [iOS Build Settings](https://developer.apple.com/documentation/xcode/build-settings-reference)
