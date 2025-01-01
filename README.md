# Biruni Connect

Biruni Connect is a comprehensive university mobile application developed for students and academics. Built with Flutter, it aims to streamline campus life, track events, and provide easy access to university information.

## Features

### Authentication
- Firebase Authentication integration
- Google Sign-in support
- Email/Password authentication
- Remember Me functionality
- Password reset / Email verification

### Home
- Announcements and news
- Quick access links (Student portal, library, course schedule, etc.)
- Dynamic slider section
- Content detail viewing

### Campus
- Interactive campus building map
- Building details and directions
- Campus facility information
- Google Maps integration
- Location-based services

### Events
- Event calendar and details
- Category-based filtering
- Event registration system
- Calendar integration
- Notification system

### University Information
- Faculty and department details
- Academic programs
- Contact information
- Social media integration

## Technical Infrastructure

### Technologies Used
- **Framework:** Flutter SDK ^3.5.3
- **Backend Services:** Firebase (Auth, Firestore, Analytics)
- **State Management:** BLoC Pattern (flutter_bloc: ^8.1.3)
- **Dependency Injection:** GetIt and Injectable
- **Navigation:** Go Router
- **Local Storage:** Hive and Shared Preferences
- **Network:** Dio and Retrofit
- **Localization:** intl
- **Map Services:** Google Maps Flutter

### Platform Requirements
- **Android:**
  - Minimum SDK: 21 (Android 5.0)
  - Target SDK: 33 (Android 13)
  - Google Play Services

- **iOS:**
  - Minimum iOS Version: 12.0
  - CocoaPods
  - Google Maps API Key

### App Permissions
- Internet access
- Location services (fine and coarse location)
- Calendar read/write
- Network state access

## Installation

1. [Install Flutter](https://flutter.dev/docs/get-started/install)

2. Clone the repository:
   ```bash
   git clone https://github.com/Mehmettakkan/biruni_connect
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Firebase configuration:
   - Create a new project in Firebase Console
   - Add configuration files for Android and iOS:
     - Android: `google-services.json`
     - iOS: `GoogleService-Info.plist`
   - Configure FlutterFire using Firebase CLI:
     ```bash
     flutterfire configure
     ```

5. Google Maps API Key:
   - Get API key from Google Cloud Console
   - Android: Update API key in AndroidManifest.xml
   - iOS: Update API key in AppDelegate.swift

6. Run the application:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── config/         # App configurations and route management
├── core/           # Core components, themes, and utilities
├── mock/           # Mock data for testing and development
├── screens/        # Application screens and modules
└── shared/         # Shared widgets and components
```

## Development Guide

### Style Guide
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Very Good Analysis lint rules applied
- Material 3 design principles

### State Management
Using BLoC (Business Logic Component) pattern:
- Separate BLoC class for each feature
- State management with Event and State classes
- Data layer abstraction with Repository pattern

### Mock Data Usage
- Data in `mock/` directory is used only in development environment
- Production uses real data from Firebase Firestore
- Use `--dart-define=USE_MOCKS=true` for testing with mock data

## Recommended Development Environment

- VS Code or Android Studio
- Flutter and Dart plugins
- Flutter Intl extension
- Firebase CLI
- Git

## Contact

[Mehmet Akkan](https://github.com/Mehmettakkan)
- Email: [mehmetakkan18@gmail.com](mailto:mehmetakkan18@gmail.com)
- LinkedIn: [Mehmet Akkan](https://www.linkedin.com/in/mehmettakkan/)

## Future Roadmap

### Planned Features
- Push Notifications
- Real-time Chat
- Online Course Integration
- Attendance Tracking
- Virtual Student ID
